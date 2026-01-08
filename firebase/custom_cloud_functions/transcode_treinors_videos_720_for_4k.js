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
const DEFAULT_TARGET_FIELD = 'videoUrl720';
const DEFAULT_STORAGE_PREFIX = 'treinors_720';
const DEFAULT_CONCURRENCY = 2;
const DEFAULT_MAX_HEIGHT = 720;
const DEFAULT_MIN_SOURCE_HEIGHT = 2160;
const DEFAULT_MIN_SOURCE_WIDTH = 3840;

const options = parseOptions();

main().catch((error) => {
  console.error('Transcode failed:', error.message || error);
  process.exit(1);
});

async function main() {
  if (!ffprobePath) {
    throw new Error(
      'ffprobe path could not be resolved. Run npm install to pull @ffprobe-installer/ffprobe.',
    );
  }
  if (!ffmpegPath) {
    throw new Error(
      'ffmpeg path could not be resolved. Run npm install to pull @ffmpeg-installer/ffmpeg.',
    );
  }

  ensureFirebaseInitialized();

  const bucket = admin.storage().bucket();
  const bucketName = bucket.name;
  if (!bucketName) {
    throw new Error(
      'Firebase Storage bucket name could not be resolved. Ensure the default bucket is configured.',
    );
  }

  const configPieces = [
    `collection=${options.collectionName}`,
    `sourceField=${options.sourceField}`,
    `targetField=${options.targetField}`,
    `minSource=${options.minSourceWidth}x${options.minSourceHeight}`,
    `maxHeight=${options.maxHeight}px`,
    `prefix=${options.storagePrefix}`,
    `concurrency=${options.concurrency}`,
    options.dryRun ? 'dryRun=true' : 'dryRun=false',
  ];
  if (options.limit) {
    configPieces.push(`limit=${options.limit}`);
  }
  console.log('Transcoding 4K videos to 720p:', configPieces.join(' '));

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
    skippedNot4k: 0,
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
          console.log(
            `[${ordinal}/${stats.total}] ${entry.path} -> skip (already has ${options.targetField})`,
          );
          return;
        }

        const info = await probeVideo(entry.sourceUrl);
        const is4k =
          (info.height ?? 0) >= options.minSourceHeight ||
          (info.width ?? 0) >= options.minSourceWidth;
        if (!is4k) {
          stats.skippedNot4k += 1;
          console.log(
            `[${ordinal}/${stats.total}] ${entry.path} -> skip (not 4k: ${info.width ?? '?'}x${info.height ?? '?'})`,
          );
          return;
        }

        const tmpOut = path.join(
          os.tmpdir(),
          `treinors_${entry.id}_${Date.now()}_720.mp4`,
        );

        if (!options.dryRun) {
          await transcodeToMp4(entry.sourceUrl, tmpOut, options.maxHeight);

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
          `[${ordinal}/${stats.total}] ${entry.path} -> transcoded (${info.width ?? '?'}x${info.height ?? '?'} -> 720p mp4/h264)`,
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
  console.log(`Skipped (not 4k): ${stats.skippedNot4k}`);
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

async function probeVideo(url) {
  const result = await runFfprobe(url);
  const parsed = JSON.parse(result);
  const stream = (parsed.streams ?? []).find(
    (candidate) => candidate.codec_type === 'video',
  );
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
        return reject(
          new Error(stderr.trim() || `ffprobe exited with code ${code}`),
        );
      }
      resolve(stdout);
    });
  });
}

function transcodeToMp4(inputUrl, outputPath, scaleHeight) {
  return new Promise((resolve, reject) => {
    const args = [
      '-y',
      '-i',
      inputUrl,
      '-vf',
      `scale=-2:${scaleHeight}`,
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
      try {
        await fs.stat(outputPath);
      } catch (_) {
        // ignore
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
  const minSourceHeight =
    toPositiveInt(parsed.minSourceHeight ?? parsed.minHeight ?? parsed.minH) ??
    DEFAULT_MIN_SOURCE_HEIGHT;
  const minSourceWidth =
    toPositiveInt(parsed.minSourceWidth ?? parsed.minWidth ?? parsed.minW) ??
    DEFAULT_MIN_SOURCE_WIDTH;
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
    minSourceHeight,
    minSourceWidth,
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

