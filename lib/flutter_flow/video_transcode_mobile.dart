import 'dart:typed_data';
import 'dart:io' as io;

import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:ffmpeg_kit_flutter_full_gpl/ffmpeg_kit.dart';
import 'package:ffmpeg_kit_flutter_full_gpl/ffprobe_kit.dart';
import 'package:ffmpeg_kit_flutter_full_gpl/return_code.dart';

// Transcodes an input video file to an Android-friendly MP4 (H.264/AAC),
// downscaling to max 1080p when necessary. Returns the output bytes.
Future<Uint8List> transcodeToCompatibleMp4(
  String inputPath,
  Uint8List originalBytes,
) async {
  // Determine if we need to transcode based on extension/codec/resolution.
  String ext = p.extension(inputPath).toLowerCase().replaceAll('.', '');
  bool needsTranscode = ext != 'mp4';
  int? height;
  String? vcodec;

  const int maxHeight = 1080;

  try {
    final probeSession = await FFprobeKit.getMediaInformation(inputPath);
    final info = probeSession.getMediaInformation();
    final streams = info?.getStreams();
    if (streams != null) {
      for (var s in streams) {
        final type = s?.getType();
        if (type != null && type.toLowerCase() == 'video') {
          vcodec = s?.getCodec();
          // getHeight can be String or int depending on probe; handle both safely.
          final Object? hVal = s?.getHeight();
          if (hVal is String) {
            height = int.tryParse(hVal);
          } else if (hVal is int) {
            height = hVal;
          }
          break;
        }
      }
    }
    final codec = (vcodec ?? '').toLowerCase();
    if (codec.contains('hevc') ||
        codec.contains('h265') ||
        codec.contains('hvc1') ||
        codec.contains('av1') ||
        codec.contains('av01') ||
        codec.contains('vp9')) {
      needsTranscode = true;
    }
    if ((height ?? 0) > maxHeight) {
      needsTranscode = true;
    }
  } catch (_) {
    // If probe fails, err on the safe side and transcode when not mp4.
  }

  if (!needsTranscode) {
    return originalBytes;
  }

  final tmpDir = await getTemporaryDirectory();
  final outPath = p.join(
    tmpDir.path,
    'transcoded_${DateTime.now().microsecondsSinceEpoch}.mp4',
  );

  // Only scale if over maxHeight to keep processing light.
  final addScale = (height ?? 0) > maxHeight;
  final scaleArgs = addScale ? '-vf scale=-2:$maxHeight' : '';

  final cmd = [
    '-y',
    '-i',
    '"$inputPath"',
    if (scaleArgs.isNotEmpty) scaleArgs,
    '-c:v',
    'libx264',
    '-preset',
    'veryfast',
    '-crf',
    '23',
    '-c:a',
    'aac',
    '-b:a',
    '128k',
    '-movflags',
    '+faststart',
    '"$outPath"',
  ].join(' ');

  final session = await FFmpegKit.execute(cmd);
  final returnCode = await session.getReturnCode();
  if (ReturnCode.isSuccess(returnCode)) {
    final outBytes = await io.File(outPath).readAsBytes();
    return outBytes;
  }

  // Fallback: original bytes if transcode fails.
  return originalBytes;
}
