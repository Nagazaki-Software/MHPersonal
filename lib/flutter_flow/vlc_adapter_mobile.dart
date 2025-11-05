import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';

// Allow disabling VLC at runtime for troubleshooting with --dart-define=DISABLE_VLC=true
const bool _disableVlc = bool.fromEnvironment('DISABLE_VLC', defaultValue: false);

class VlcAdapterController {
  VlcAdapterController.network(String url, {bool autoPlay = false, bool looping = false})
      : _controller = VlcPlayerController.network(
          url,
          // Use automatic hardware accel to avoid device-specific crashes.
          hwAcc: HwAcc.auto,
          autoPlay: autoPlay,
          options: VlcPlayerOptions(
            // Increase network caching for stability on mobile networks.
            advanced: VlcAdvancedOptions([
              // Slightly higher cache to reduce stalls on high-bitrate videos.
              VlcAdvancedOptions.networkCaching(2000),
            ]),
            video: VlcVideoOptions([
              // Drop late frames to keep playback stable.
              VlcVideoOptions.dropLateFrames(true),
            ]),
          ),
        );

  final VlcPlayerController _controller;

  VlcPlayerController get controller => _controller;

  void dispose() {
    _controller.stop();
    _controller.dispose();
  }
}

bool get vlcAvailable => !kIsWeb && !_disableVlc; // IO platforms only

VlcAdapterController createVlcController(
  String url, {
  bool autoPlay = false,
  bool looping = false,
}) => VlcAdapterController.network(url, autoPlay: autoPlay, looping: looping);

Widget buildVlcPlayer({
  required VlcAdapterController controller,
  required double aspectRatio,
  required bool showControls,
  required double width,
  required double height,
}) {
  return SizedBox(
    width: width,
    height: height,
    child: VlcPlayer(
      controller: controller.controller,
      aspectRatio: aspectRatio,
      placeholder: const Center(child: CircularProgressIndicator()),
    ),
  );
}
