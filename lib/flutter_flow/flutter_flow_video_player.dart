import 'package:chewie/chewie.dart';
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:video_player/video_player.dart';
import 'vlc_adapter_stub.dart' if (dart.library.io) 'vlc_adapter_mobile.dart' as vlc;

import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart' show routeObserver;

const kDefaultAspectRatio = 16 / 9;

enum VideoType {
  asset,
  network,
}

Set<VideoPlayerController> _videoPlayers = Set();

class FlutterFlowVideoPlayer extends StatefulWidget {
  const FlutterFlowVideoPlayer({
    super.key,
    required this.path,
    this.videoType = VideoType.network,
    this.width,
    this.height,
    this.aspectRatio,
    this.autoPlay = false,
    this.looping = false,
    this.showControls = true,
    this.allowFullScreen = true,
    this.allowPlaybackSpeedMenu = false,
    this.lazyLoad = false,
    this.pauseOnNavigate = true,
  });

  final String path;
  final VideoType videoType;
  final double? width;
  final double? height;
  final double? aspectRatio;
  final bool autoPlay;
  final bool looping;
  final bool showControls;
  final bool allowFullScreen;
  final bool allowPlaybackSpeedMenu;
  final bool lazyLoad;
  final bool pauseOnNavigate;

  @override
  State<StatefulWidget> createState() => _FlutterFlowVideoPlayerState();
}

class _FlutterFlowVideoPlayerState extends State<FlutterFlowVideoPlayer>
    with RouteAware {

  bool get _shouldPreferVlcForFirebaseStorage {
    if (kIsWeb || defaultTargetPlatform != TargetPlatform.android) {
      return false;
    }
    if (widget.videoType != VideoType.network || !vlc.vlcAvailable) {
      return false;
    }
    final url = widget.path.toLowerCase();
    return url.contains('firebasestorage.googleapis.com') ||
        url.contains('storage.googleapis.com');
  }

  VideoPlayerController? _videoPlayerController;
  ChewieController? _chewieController;
  vlc.VlcAdapterController? _vlcController;
  bool _loggedError = false;
  bool _subscribedRoute = false;
  bool _isFullScreen = false;
  bool _useVlc = false;
  Timer? _androidStallFallbackTimer;

  @override
  void initState() {
    super.initState();
    _initializePlayer();
  }

  @override
  void dispose() {
    if (_subscribedRoute) {
      routeObserver.unsubscribe(this);
    }
    _disposeCurrentPlayer();
    super.dispose();
  }

  @override
  void didUpdateWidget(FlutterFlowVideoPlayer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.path != widget.path) {
      _disposeCurrentPlayer();
      _initializePlayer();
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (widget.pauseOnNavigate && ModalRoute.of(context) is PageRoute) {
      _subscribedRoute = true;
      routeObserver.subscribe(this, ModalRoute.of(context)!);
    }
  }

  @override
  void didPushNext() {
    if (widget.pauseOnNavigate) {
      _videoPlayerController?.pause();
    }
  }

  double get width => widget.width == null || widget.width! >= double.infinity
      ? MediaQuery.sizeOf(context).width
      : widget.width!;

  double get height =>
      widget.height == null || widget.height! >= double.infinity
          ? width / aspectRatio
          : widget.height!;

  double get aspectRatio =>
      _chewieController?.videoPlayerController.value.aspectRatio ??
      kDefaultAspectRatio;

  void _disposeCurrentPlayer() {
    _videoPlayers.remove(_videoPlayerController);
    _videoPlayerController?.dispose();
    _chewieController?.dispose();
    _vlcController?.dispose();
    _vlcController = null;
    _useVlc = false;
    _androidStallFallbackTimer?.cancel();
    _androidStallFallbackTimer = null;
  }

  Future _initializePlayer() async {
    if (_shouldPreferVlcForFirebaseStorage) {
      try {
        _vlcController = vlc.createVlcController(
          widget.path,
          autoPlay: widget.autoPlay,
          looping: widget.looping,
        );
        _useVlc = true;
        if (mounted) {
          setState(() {});
        }
      } catch (_) {
        // Fall back to the normal video player if VLC fails.
      }
      return;
    }

    _videoPlayerController = widget.videoType == VideoType.network
        ? VideoPlayerController.networkUrl(Uri.parse(widget.path!))
        : VideoPlayerController.asset(widget.path);
    if (kIsWeb && widget.autoPlay) {
      // Browsers generally don't allow autoplay unless it's muted.
      // Ideally this should be configurable, but for now we just automatically
      // mute on web.
      // See https://pub.dev/packages/video_player_web#autoplay
      _videoPlayerController!.setVolume(0);
    }
    if (!widget.lazyLoad) {
      try {
        await _videoPlayerController?.initialize();
      } catch (e) {
        // On Android, fallback to VLC if initialize fails.
        if (!kIsWeb && defaultTargetPlatform == TargetPlatform.android &&
            widget.videoType == VideoType.network && vlc.vlcAvailable && !_useVlc) {
          try {
            _disposeCurrentPlayer();
            _vlcController = vlc.createVlcController(
              widget.path,
              autoPlay: widget.autoPlay,
              looping: widget.looping,
            );
            if (mounted) setState(() => _useVlc = true);
            return;
          } catch (_) {}
        }
      }
    }

    // Android-only: if video starts but stalls (common with 4K codecs),
    // auto-fallback to VLC after a short grace period.
    if (!kIsWeb && defaultTargetPlatform == TargetPlatform.android &&
        widget.videoType == VideoType.network && vlc.vlcAvailable && !_useVlc) {
      // Give ExoPlayer a few seconds to actually start rendering frames.
      _androidStallFallbackTimer?.cancel();
      _androidStallFallbackTimer = Timer(const Duration(seconds: 6), () async {
        // If not playing or position very small, consider it a stall and fallback to VLC.
        final ctrl = _videoPlayerController;
        if (!mounted || ctrl == null) return;
        final value = ctrl.value;
        final hasStarted = value.isPlaying || (value.position > const Duration(seconds: 0));
        if (!hasStarted && !_useVlc) {
          try {
            _disposeCurrentPlayer();
            _vlcController = vlc.createVlcController(
              widget.path,
              autoPlay: widget.autoPlay,
              looping: widget.looping,
            );
            if (mounted) setState(() => _useVlc = true);
          } catch (_) {
            // Keep current controller if VLC init fails
          }
        }
      });
    }
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController!,
      deviceOrientationsOnEnterFullScreen: [
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ],
      deviceOrientationsAfterFullScreen: [DeviceOrientation.portraitUp],
      aspectRatio: widget.aspectRatio,
      autoPlay: widget.autoPlay,
      looping: widget.looping,
      showControls: widget.showControls,
      allowFullScreen: widget.allowFullScreen,
      allowPlaybackSpeedChanging: widget.allowPlaybackSpeedMenu,
    );

    _videoPlayers.add(_videoPlayerController!);
    _videoPlayerController!.addListener(() {
      if (_videoPlayerController!.value.hasError && !_loggedError) {
        print(
            'Error playing video: ${_videoPlayerController!.value.errorDescription}');
        _loggedError = true;
        // On Android, fall back to VLC for incompatible codecs/containers.
        if (!kIsWeb && defaultTargetPlatform == TargetPlatform.android &&
            widget.videoType == VideoType.network && vlc.vlcAvailable && !_useVlc) {
          SchedulerBinding.instance.addPostFrameCallback((_) async {
            try {
              _disposeCurrentPlayer();
              _vlcController = vlc.createVlcController(
                widget.path,
                autoPlay: widget.autoPlay,
                looping: widget.looping,
              );
              if (mounted) {
                setState(() => _useVlc = true);
              }
            } catch (e) {
              // Keep Chewie error UI if VLC fallback fails.
              if (mounted) setState(() {});
            }
          });
        }
      }
      // Stop all other players when one video is playing.
      if (_videoPlayerController!.value.isPlaying) {
        _videoPlayers.forEach((otherPlayer) {
          if (otherPlayer != _videoPlayerController &&
              otherPlayer.value.isPlaying &&
              mounted) {
            setState(() {
              otherPlayer.pause();
            });
          }
        });
      }
    });

    _chewieController!.addListener(() {
      // On web, Chewie has issues when exiting fullscreen. As a workaround,
      // reset the video player when exiting fullscreen, as suggested here:
      // https://github.com/fluttercommunity/chewie/issues/688#issuecomment-1790033300.
      if (kIsWeb && !_chewieController!.isFullScreen && _isFullScreen) {
        SchedulerBinding.instance.addPostFrameCallback((_) async {
          final position = _videoPlayerController!.value.position;
          _disposeCurrentPlayer();
          await _initializePlayer();
          _videoPlayerController!.seekTo(position);
        });
      }
      _isFullScreen = _chewieController!.isFullScreen;
    });
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) => FittedBox(
        fit: BoxFit.cover,
        child: Container(
          height: height,
          width: width,
          child: _useVlc && _vlcController != null
              ? vlc.buildVlcPlayer(
                  controller: _vlcController!,
                  aspectRatio: widget.aspectRatio ?? kDefaultAspectRatio,
                  showControls: widget.showControls,
                  width: width,
                  height: height,
                )
              : _chewieController != null &&
                  (widget.lazyLoad ||
                      _chewieController!
                          .videoPlayerController.value.isInitialized)
              ? Chewie(controller: _chewieController!)
              : (_chewieController != null &&
                      _chewieController!.videoPlayerController.value.hasError)
                  ? Text('Error playing video')
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 50.0,
                          height: 50.0,
                          child: SpinKitFadingFour(
                            color: FlutterFlowTheme.of(context).customColor3,
                            size: 50.0,
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Text('Loading'),
                      ],
                    ),
        ),
      );
}
