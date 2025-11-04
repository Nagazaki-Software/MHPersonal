import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';

class VlcAdapterController {
  VlcAdapterController.network(String url, {bool autoPlay = false, bool looping = false})
      : _controller = VlcPlayerController.network(
          url,
          hwAcc: HwAcc.full,
          autoPlay: autoPlay,
          options: VlcPlayerOptions(
            advanced: VlcAdvancedOptions([VlcAdvancedOptions.networkCaching(200)]),
            video: VlcVideoOptions([if (looping) VlcVideoOptions.dropLateFrames(false)]),
          ),
        );

  final VlcPlayerController _controller;

  VlcPlayerController get controller => _controller;

  void dispose() {
    _controller.stop();
    _controller.dispose();
  }
}

bool get vlcAvailable => !kIsWeb; // IO platforms only

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
