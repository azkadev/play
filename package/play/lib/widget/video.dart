import 'package:flutter/material.dart';
import 'package:play/media_kit_video/media_kit_video.dart';
import 'package:play/play.dart';

// import "package:video_player/video_player.dart" as video_player;

// import 'package:media_kit_video/media_kit_video.dart' as media_kit_video;
import "package:play/media_kit_video/media_kit_video.dart" as media_kit_video;

/// if you want tutorial please chek [Youtube](https://youtube.com/@azkadev)
class Video extends StatefulWidget {
  final int id;
  final MediaData mediaData;
  final bool isAutoStart;
  final Widget Function(
    BuildContext context,
    Widget child,
    Video video,
    VideoState videoState,
    MediaController mediaController,
  ) builder;
  final Widget Function(BuildContext context)? onPlatformNotSupport;
  final Widget Function(BuildContext context) onProcces;

  final BoxFit fit;

  final FilterQuality filterQuality;
  final Widget Function(media_kit_video.VideoState videoState)? controls;

  Video({
    super.key,
    this.id = 0,
    this.isAutoStart = false,
    required this.mediaData,
    this.fit = BoxFit.cover,
    this.filterQuality = FilterQuality.low,
    this.controls = AdaptiveVideoControls,
    required this.builder,
    this.onPlatformNotSupport,
    required this.onProcces,
  });
  @override
  State<Video> createState() => VideoState();
}

/// if you want tutorial please chek [Youtube](https://youtube.com/@azkadev)
class VideoState extends State<Video> {
  late final MediaController mediaController = MediaController(
    id: widget.id,
    isAutoStart: widget.isAutoStart,
  );
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((Duration duration) async {
      await mediaController.initialize(
        setState: setState,
        mediaData: widget.mediaData,
        onReady: (bool isReady) {
          setState(() {
            mediaController.is_init = isReady;
          });
        },
      );
    });
  }

  @override
  void dispose() {
    Future.microtask(() async {
      print("Exit slebew maniez");
      await mediaController.dispose();
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!mediaController.is_init) {
      return widget.onProcces(context);
    }

    return Visibility(
      visible: mediaController.is_init,
      replacement: frame(widget.onProcces(context)),
      child: frame(
        media_kit_video.Video(
          controller: mediaController.videoController,
          fit: widget.fit,
          filterQuality: widget.filterQuality,
          controls: widget.controls,
        ),
      ),
    );
  }

  Widget frame(Widget child) {
    return widget.builder(context, child, widget, this, mediaController);
  }
}
