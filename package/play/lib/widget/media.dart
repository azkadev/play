import 'package:flutter/material.dart';
import "package:play/media_kit_video/media_kit_video.dart";
import "package:play/play.dart";

// import "package:video_player/video_player.dart" as video_player;

import "package:play/media_kit_video/media_kit_video.dart" as media_kit_video;

class MediaPlayer extends StatefulWidget {
  final MediaController mediaController;
  final Widget Function(BuildContext context)? onPlatformNotSupport;
  final Widget Function(BuildContext context) onProcces;
  final BoxFit fit;

  final FilterQuality filterQuality;
  final Widget Function(media_kit_video.VideoState videoState)? controls;
  MediaPlayer({
    super.key,
    required this.mediaController,
    this.onPlatformNotSupport,
    this.fit = BoxFit.cover,
    this.filterQuality = FilterQuality.low,
    this.controls = AdaptiveVideoControls,
    required this.onProcces,
  });
  @override
  State<MediaPlayer> createState() => _MediaPlayerState();
}

class _MediaPlayerState extends State<MediaPlayer> {
  @override
  Widget build(BuildContext context) {
    if (!widget.mediaController.is_init) {
      return widget.onProcces(context);
    }

    return Visibility(
      visible: widget.mediaController.is_init,
      replacement: widget.onProcces(context),
      child: media_kit_video.Video(
        controller: widget.mediaController.videoController,
        fit: widget.fit,
        filterQuality: widget.filterQuality,
        controls: widget.controls,
      ),
    );
  }
}
