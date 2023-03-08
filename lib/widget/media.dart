import 'package:universal_io/io.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import "package:play/play.dart";

import 'package:dart_vlc/dart_vlc.dart'
    if (dart.library.html) 'package:play/dart_vlc/web.dart' as dart_vlc;
import "package:video_player/video_player.dart" as video_player;

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
        child: dart_vlc.Video(
          player: widget.mediaController.desktopPlayer,
          width: widget.mediaController.size.width,
          height: widget.mediaController.size.height,
          volumeThumbColor: Colors.blue,
          volumeActiveColor: Colors.blue,
          showControls: false,
          showTimeLeft: true,
          fillColor: Colors.black,
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
