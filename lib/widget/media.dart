import 'package:universal_io/io.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import "package:play/play.dart";
 
import "package:video_player/video_player.dart" as video_player;


import "package:play/media_kit_video/media_kit_video.dart" as media_kit_video;

class MediaPlayer extends StatefulWidget {
  final MediaController mediaController;
  final Widget Function(BuildContext context)? onPlatformNotSupport;
  final Widget Function(BuildContext context) onProcces;
  MediaPlayer({
    super.key,
    required this.mediaController,
    this.onPlatformNotSupport,
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
    if (Platform.isAndroid || Platform.isIOS || kIsWeb) {
      return Visibility(
        visible: widget.mediaController.is_init,
        replacement: widget.onProcces(context),
        child: video_player.VideoPlayer(
          widget.mediaController.mobilePlayer,
        ),
      );
    } else if (Platform.isWindows || Platform.isLinux) {
      return Visibility(
        visible: widget.mediaController.is_init,
        replacement: widget.onProcces(context),
        child: media_kit_video.Video(
          controller: widget.mediaController.desktopPlayer,
        ),
      );
    } else {
      if (widget.onPlatformNotSupport != null) {
        return widget.onPlatformNotSupport!(context);
      }
      return SizedBox.shrink();
    }
  }
}
