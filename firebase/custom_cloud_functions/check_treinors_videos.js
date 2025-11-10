#!/usr/bin/env node

'use strict';

const admin = require('firebase-admin');
const { spawn } = require('child_process');
const ffprobePath = require('@ffprobe-installer/ffprobe').path;

const DEFAULT_COLLECTION = 'treinors';
const DEFAULT_THRESHOLD_HEIGHT = 1080;
const DEFAULT_CONCURRENCY = 6;

const options = parseOptions();

main().catch((error) => {
  console.error('Video verification failed:', error.message || error);
  process.exit(1);
});

async function main() {
  if (!ffprobePath) {
    throw new Error('ffprobe path could not be resolved. Run npm install to pull @ffprobe-installer/ffprobe.');
  }

  ensureFirebaseInitialized();

  const configPieces = [
    `collection=${options.collectionName}`,
    `threshold=${options.thresholdHeight}px`,
    `concurrency=${options.concurrency}`,
  ];
  if (options.limit) {
    configPieces.push(`limit=${options.limit}`);
  }
  console.log('Checking videos:', configPieces.join(' '));

  const snapshot = await admin.firestore().collection(options.collectionName).get();
  const candidateDocs = snapshot.docs.map((doc) => ({
    path: doc.ref.path,
    videoUrl: (doc.get('videoUrl') ?? '').toString().trim(),
  }));

  const videos = candidateDocs.filter((doc) => doc.videoUrl.length > 0);
  if (videos.length === 0) {
    console.warn(
      `No documents with a non-empty videoUrl were found inside collection "${options.collectionName}".`,
    );
    return;
  }

  const entries = options.limit ? videos.slice(0, options.limit) : videos;
  console.log(`Found ${videos.length} videos; processing ${entries.length} of them.`);

  const stats = {
    total: entries.length,
    highRes: 0,
    ok: 0,
    unknown: 0,
    errors: 0,
  };

  let processed = 0;
  await mapWithConcurrency(
    entries,
    async (entry) => {
      const ordinal = ++processed;
      try {
        const info = await probeVideo(entry.videoUrl);
        const height = info.height;
        const width = info.width;
        const label = height && height > options.thresholdHeight ? 'HIGH-RES' : 'STANDARD';
        if (height && height > options.thresholdHeight) {
          stats.highRes += 1;
        } else if (height) {
          stats.ok += 1;
        } else {
          stats.unknown += 1;
        }
        console.log(
          `[${ordinal}/${stats.total}] ${entry.path} -> ${width ?? '?'}x${height ?? '?'} (${label}; codec=${info.codec ??
            'unknown'})`,
        );
      } catch (error) {
        stats.errors += 1;
        console.error(
          `[${ordinal}/${stats.total}] ${entry.path} -> failed to probe (${error.message || error})`,
        );
      }
    },
    options.concurrency,
  );

  console.log('--- Summary ---');
  console.log(`Processed: ${stats.total}`);
  console.log(`Above ${options.thresholdHeight}px: ${stats.highRes}`);
  console.log(`At or below ${options.thresholdHeight}px: ${stats.ok}`);
  console.log(`Unknown resolution: ${stats.unknown}`);
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
  const thresholdHeight = toPositiveInt(parsed.threshold ?? parsed.height ?? parsed.minHeight) ??
    DEFAULT_THRESHOLD_HEIGHT;
  const concurrency = toPositiveInt(parsed.concurrency) ?? DEFAULT_CONCURRENCY;
  const collectionName = parsed.collection ?? parsed.collectionName ?? DEFAULT_COLLECTION;

  return {
    limit,
    thresholdHeight,
    concurrency,
    collectionName,
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
