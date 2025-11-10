# MH Personal Trainer

A new Flutter project.

## Getting Started

FlutterFlow projects are built to run on the Flutter _stable_ release.

## Verifying stored videos

If you need to check the resolution of the videos already uploaded to `treinors -> videoUrl` (for example to confirm how many are still 4K), there is now a helper script under `firebase/custom_cloud_functions/check_treinors_videos.js` that uses `ffprobe` to inspect each URL.

1. Create or download a Firebase service-account key and expose it via `GOOGLE_APPLICATION_CREDENTIALS` (or `gcloud auth application-default login`).
2. From the repo root run `cd firebase/custom_cloud_functions && npm install` (this pulls `@ffprobe-installer/ffprobe`).
3. Execute the script with the thresholds that make sense for your Android builds, for example:

   ```
   node check_treinors_videos.js --collection=treinors --threshold=1080 --limit=200
   ```

   The script will print each document path, codec, and whether it exceeds the configured height threshold, then summarize the counts and failures at the end.

Available flags are `--collection`, `--threshold` (default `1080`), `--limit`, and `--concurrency` (default `6`). Leave `--limit` out to scan the full collection, but be mindful that probing ~500 videos can take several minutes depending on your network and storage response.
