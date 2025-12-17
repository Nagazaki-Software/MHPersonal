#!/usr/bin/env node
'use strict';

const admin = require('firebase-admin');
const { spawn } = require('child_process');
const os = require('os');
const path = require('path');
const fs = require('fs/promises');
const { randomUUID } = require('crypto');

const ffprobePath = require('@ffprobe-installer/ffprobe').path;
const ffmpegPath = require('@ffmpeg-installer/ffmpeg').path;

const DEFAULT_COLLECTION = 'treinors';
const DEFAULT_SOURCE_FIELD = 'videoUrl';
const DEFAULT_TARGET_FIELD = 'videoUrl1080';
const DEFAULT_STORAGE_PREFIX = 'treinors_1080';
const DEFAULT_CONCURRENCY = 2;
const DEFAULT_MAX_HEIGHT = 1080;

const options = parseOptions();

main().catch((error) => {
  console.error('Transcode failed:', error.message || error);
  process.exit(1);
});

async function main() {
  if (!ffprobePath) {
    throw new Error('ffprobe path could not be resolved. Run npm install to pull @ffprobe-installer/ffprobe.');
  }
  if (!ffmpegPath) {
    throw new Error('ffmpeg path could not be resolved. Run npm install to pull @ffmpeg-installer/ffmpeg.');
  }

  ensureFirebaseInitialized();

  const bucket = admin.storage().bucket();
  const bucketName = bucket.name;
  if (!bucketName) {
    throw new Error('Firebase Storage bucket name could not be resolved. Ensure the default bucket is configured.');
  }

  const configPieces = [
    `collection=${options.collectionName}`,
    `sourceField=${options.sourceField}`,
    `targetField=${options.targetField}`,
    `maxHeight=${options.maxHeight}px`,
    `prefix=${options.storagePrefix}`,
    `concurrency=${options.concurrency}`,
    options.dryRun ? 'dryRun=true' : 'dryRun=false',
  ];
  if (options.limit) {
    configPieces.push(`limit=${options.limit}`);
  }
  console.log('Transcoding videos:', configPieces.join(' '));

  const snapshot = await admin.firestore().collection(options.collectionName).get();
  const candidateDocs = snapshot.docs.map((doc) => ({
    id: doc.id,
    path: doc.ref.path,
    ref: doc.ref,
    sourceUrl: (doc.get(options.sourceField) ?? '').toString().trim(),
    targetUrl: (doc.get(options.targetField) ?? '').toString().trim(),
  }));

  const entriesAll = candidateDocs.filter((doc) => doc.sourceUrl.length > 0);
  const entries = options.limit ? entriesAll.slice(0, options.limit) : entriesAll;
  console.log(`Found ${entriesAll.length} candidates; processing ${entries.length} of them.`);
  if (entries.length === 0) {
    console.warn('No documents with a non-empty source URL were found.');
    return;
  }

  const stats = {
    total: entries.length,
    skippedAlreadyHasTarget: 0,
    assignedFromSource: 0,
    transcoded: 0,
    errors: 0,
  };

  let processed = 0;
  await mapWithConcurrency(
    entries,
    async (entry) => {
      const ordinal = ++processed;
      try {
        if (!options.overwrite && entry.targetUrl.length > 0) {
          stats.skippedAlreadyHasTarget += 1;
          console.log(`[${ordinal}/${stats.total}] ${entry.path} -> skip (already has ${options.targetField})`);
          return;
        }

        const info = await probeVideo(entry.sourceUrl);
        const needs = shouldTranscode(info, entry.sourceUrl, options.maxHeight);

        if (!needs) {
          if (!options.dryRun) {
            await entry.ref.set({ [options.targetField]: entry.sourceUrl }, { merge: true });
          }
          stats.assignedFromSource += 1;
          console.log(
            `[${ordinal}/${stats.total}] ${entry.path} -> ok (${info.width ?? '?'}x${info.height ?? '?'}; codec=${info.codec ??
              'unknown'})`,
          );
          return;
        }

        const tmpOut = path.join(os.tmpdir(), `treinors_${entry.id}_${Date.now()}.mp4`);
        const scaleTo = info.height && info.height > options.maxHeight ? options.maxHeight : null;

        if (!options.dryRun) {
          await transcodeToMp4(entry.sourceUrl, tmpOut, scaleTo);

          const token = randomUUID();
          const destination = `${options.storagePrefix}/${entry.id}.mp4`;
          await bucket.upload(tmpOut, {
            destination,
            metadata: {
              contentType: 'video/mp4',
              metadata: {
                firebaseStorageDownloadTokens: token,
              },
            },
          });

          const downloadUrl = buildFirebaseDownloadUrl(bucketName, destination, token);
          await entry.ref.set({ [options.targetField]: downloadUrl }, { merge: true });
        }

        stats.transcoded += 1;
        console.log(
          `[${ordinal}/${stats.total}] ${entry.path} -> transcoded (${info.width ?? '?'}x${info.height ?? '?'}; codec=${info.codec ??
            'unknown'} -> mp4/h264 ${options.maxHeight}p max)`,
        );
      } catch (error) {
        stats.errors += 1;
        console.error(
          `[${ordinal}/${stats.total}] ${entry.path} -> failed (${error.message || error})`,
        );
      }
    },
    options.concurrency,
  );

  console.log('--- Summary ---');
  console.log(`Processed: ${stats.total}`);
  console.log(`Skipped (already had target): ${stats.skippedAlreadyHasTarget}`);
  console.log(`Assigned from source (already <= ${options.maxHeight}p and compatible): ${stats.assignedFromSource}`);
  console.log(`Transcoded + uploaded: ${stats.transcoded}`);
  console.log(`Errors: ${stats.errors}`);
}

function ensureFirebaseInitialized() {
  if (admin.apps.length === 0) {
    admin.initializeApp({
      credential: admin.credential.applicationDefault(),
    });
  }
}

function shouldTranscode(info, url, maxHeight) {
  const codec = (info.codec ?? '').toLowerCase();
  const height = info.height ?? 0;
  if (height > maxHeight) return true;
  if (
    codec.includes('hevc') ||
    codec.includes('h265') ||
    codec.includes('hvc1') ||
    codec.includes('av1') ||
    codec.includes('av01') ||
    codec.includes('vp9') ||
    codec.includes('vp09')
  ) {
    return true;
  }

  const ext = getUrlExtension(url);
  if (ext && ext !== 'mp4') {
    return true;
  }
  return false;
}

function getUrlExtension(url) {
  try {
    const parsed = new URL(url);
    const pathname = parsed.pathname ?? '';
    const last = pathname.split('/').pop() ?? '';
    const dot = last.lastIndexOf('.');
    if (dot < 0) return null;
    return last.slice(dot + 1).toLowerCase();
  } catch (_) {
    return null;
  }
}

async function probeVideo(url) {
  const result = await runFfprobe(url);
  const parsed = JSON.parse(result);
  const stream = (parsed.streams ?? []).find((candidate) => candidate.codec_type === 'video');
  if (!stream) {
    throw new Error('ffprobe did not return a video stream');
  }

  return {
    width: toFiniteNumber(stream.width),
    height: toFiniteNumber(stream.height),
    codec: stream.codec_name ?? stream.codec_long_name ?? null,
  };
}

function runFfprobe(url) {
  return new Promise((resolve, reject) => {
    const args = [
      '-v',
      'error',
      '-select_streams',
      'v:0',
      '-show_entries',
      'stream=index,codec_type,codec_name,width,height',
      '-of',
      'json',
      url,
    ];
    const child = spawn(ffprobePath, args, { windowsHide: true });
    let stdout = '';
    let stderr = '';

    child.stdout.on('data', (chunk) => {
      stdout += chunk.toString();
    });

    child.stderr.on('data', (chunk) => {
      stderr += chunk.toString();
    });

    child.on('error', (error) => {
      reject(error);
    });

    child.on('close', (code) => {
      if (code !== 0) {
        return reject(new Error(stderr.trim() || `ffprobe exited with code ${code}`));
      }
      resolve(stdout);
    });
  });
}

function transcodeToMp4(inputUrl, outputPath, scaleHeightOrNull) {
  return new Promise((resolve, reject) => {
    const args = [
      '-y',
      '-i',
      inputUrl,
      ...(scaleHeightOrNull ? ['-vf', `scale=-2:${scaleHeightOrNull}`] : []),
      '-c:v',
      'libx264',
      '-preset',
      'veryfast',
      '-crf',
      '23',
      '-pix_fmt',
      'yuv420p',
      '-c:a',
      'aac',
      '-b:a',
      '128k',
      '-movflags',
      '+faststart',
      outputPath,
    ];
    const child = spawn(ffmpegPath, args, { windowsHide: true });
    let stderr = '';

    child.stderr.on('data', (chunk) => {
      stderr += chunk.toString();
    });

    child.on('error', (error) => {
      reject(error);
    });

    child.on('close', async (code) => {
      if (code !== 0) {
        return reject(new Error(stderr.trim() || `ffmpeg exited with code ${code}`));
      }
      // Best-effort cleanup for previous file at same path is handled by -y.
      try {
        await fs.stat(outputPath);
      } catch (_) {
        // Ignore stat errors; ffmpeg could still have succeeded but the filesystem failed.
      }
      resolve();
    });
  });
}

function buildFirebaseDownloadUrl(bucketName, objectPath, token) {
  return `https://firebasestorage.googleapis.com/v0/b/${encodeURIComponent(
    bucketName,
  )}/o/${encodeURIComponent(objectPath)}?alt=media&token=${encodeURIComponent(token)}`;
}

function toFiniteNumber(value) {
  if (value === undefined || value === null) {
    return null;
  }
  const number = Number(value);
  if (Number.isFinite(number)) {
    return number;
  }
  return null;
}

function mapWithConcurrency(items, iterator, concurrency) {
  const limit = Math.max(1, concurrency);
  let pointer = 0;
  const workers = [];
  for (let i = 0; i < limit; i += 1) {
    workers.push(
      (async () => {
        while (true) {
          const index = pointer;
          pointer += 1;
          if (index >= items.length) {
            break;
          }
          await iterator(items[index], index);
        }
      })(),
    );
  }
  return Promise.all(workers);
}

function parseOptions() {
  const rawArgs = process.argv.slice(2);
  const parsed = {};
  for (let i = 0; i < rawArgs.length; i += 1) {
    const arg = rawArgs[i];
    if (!arg.startsWith('--')) {
      continue;
    }
    const noPrefix = arg.slice(2);
    const equalsIndex = noPrefix.indexOf('=');
    if (equalsIndex >= 0) {
      parsed[noPrefix.slice(0, equalsIndex)] = noPrefix.slice(equalsIndex + 1);
      continue;
    }
    const next = rawArgs[i + 1];
    if (next && !next.startsWith('--')) {
      parsed[noPrefix] = next;
      i += 1;
    } else {
      parsed[noPrefix] = true;
    }
  }

  const limit = toPositiveInt(parsed.limit);
  const concurrency = toPositiveInt(parsed.concurrency) ?? DEFAULT_CONCURRENCY;
  const maxHeight = toPositiveInt(parsed.maxHeight ?? parsed.height) ?? DEFAULT_MAX_HEIGHT;
  const collectionName = parsed.collection ?? parsed.collectionName ?? DEFAULT_COLLECTION;
  const sourceField = parsed.sourceField ?? DEFAULT_SOURCE_FIELD;
  const targetField = parsed.targetField ?? DEFAULT_TARGET_FIELD;
  const storagePrefix = parsed.storagePrefix ?? DEFAULT_STORAGE_PREFIX;
  const dryRun = Boolean(parsed.dryRun ?? parsed.dry ?? false);
  const overwrite = Boolean(parsed.overwrite ?? false);

  return {
    limit,
    concurrency,
    maxHeight,
    collectionName,
    sourceField,
    targetField,
    storagePrefix,
    dryRun,
    overwrite,
  };
}

function toPositiveInt(value) {
  if (value === undefined || value === null || value === true) {
    return undefined;
  }
  const number = Number(value);
  if (!Number.isFinite(number) || number <= 0) {
    return undefined;
  }
  return Math.floor(number);
}

