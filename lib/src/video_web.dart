

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:universal_io/io.dart';

import 'package:dart_vlc/dart_vlc.dart' if (dart.library.html) 'package:play/dart_vlc/web.dart' as dart_vlc;
import "package:video_player/video_player.dart" as video_player;
/// if you want tutorial please check [Youtube](https://youtube.com/@azkadev)
enum VideoFromType {
  asset,
  file,
  network,
}

/// if you want tutorial please check [Youtube](https://youtube.com/@azkadev)
class VideoData {
  final VideoFromType videoFromType;
  final String path;

  /// if you want tutorial please check [Youtube](https://youtube.com/@azkadev)
  VideoData({
    required this.videoFromType,
    required this.path,
  });

  /// if you want tutorial please check [Youtube](https://youtube.com/@azkadev)
  factory VideoData.asset({
    required String path,
  }) {
    return VideoData(
      path: path,
      videoFromType: VideoFromType.asset,
    );
  }

  /// if you want tutorial please check [Youtube](https://youtube.com/@azkadev)
  factory VideoData.file({
    required File file,
  }) {
    return VideoData(
      path: file.path,
      videoFromType: VideoFromType.file,
    );
  }

  /// if you want tutorial please check [Youtube](https://youtube.com/@azkadev)
  factory VideoData.network({
    required String url,
  }) {
    return VideoData(
      path: url,
      videoFromType: VideoFromType.network,
    );
  }
}

/// if you want tutorial please check [Youtube](https://youtube.com/@azkadev)
class VideoController {
  late dart_vlc.Player desktopPlayer;
  late video_player.VideoPlayerController mobilePlayer;
  final int id;
  final bool isAutoStart;

  bool get isDesktop => Platform.isWindows || Platform.isLinux;
  bool get isMobile => Platform.isAndroid || Platform.isIOS || kIsWeb;

  dart_vlc.Playlist _getDesktopPlayListFromFile(File file) {
    return dart_vlc.Playlist(
      medias: [
        dart_vlc.Media.file(file),
      ],
    );
  }

  dart_vlc.Playlist _getDesktopPlayListFromAsset(String path) {
    return dart_vlc.Playlist(
      medias: [
        dart_vlc.Media.asset(path),
      ],
    );
  }

  /// if you want tutorial please check [Youtube](https://youtube.com/@azkadev)
  VideoController({
    this.id = 0,
    this.isAutoStart = false,
  });

  /// if you want tutorial please check [Youtube](https://youtube.com/@azkadev)
  void dispose() {
    if (isDesktop) {
      desktopPlayer.dispose();
    } else {
      mobilePlayer.dispose();
    }
  }

  /// if you want tutorial please check [Youtube](https://youtube.com/@azkadev)
  Future<void> initialize({required void Function(void Function() callback) setState, required VideoData videoData, required void Function(bool isInit) onReady}) async {
    VideoFromType type = videoData.videoFromType;
    if (isDesktop) {
      setState(() {
        desktopPlayer = dart_vlc.Player(
          id: id,
        );
      });
      onReady.call(true);
      setState(() {});

      dart_vlc.Playlist? playlist;
      if (type == VideoFromType.asset) {
        playlist = _getDesktopPlayListFromAsset(videoData.path);
      } else if (type == VideoFromType.file) {
        playlist = _getDesktopPlayListFromFile(File(videoData.path));
      } else if (type == VideoFromType.network) {
        playlist = dart_vlc.Playlist(
          medias: [
            dart_vlc.Media.network(videoData.path),
          ],
        );
      }

      desktopPlayer.open(
        playlist!,
        autoStart: isAutoStart,
      );
    } else if (isMobile) {
      if (type == VideoFromType.asset) {
        setState(() {
          mobilePlayer = video_player.VideoPlayerController.asset(videoData.path);
        });
      }  if (type == VideoFromType.network) {
        setState(() {
          mobilePlayer = video_player.VideoPlayerController.network(videoData.path);
        });
      }
      await mobilePlayer.initialize();
      if (isAutoStart) {
        await mobilePlayer.play();
      }
      setState(() {});
      onReady.call(true);
      setState(() {});
      mobilePlayer.addListener(() {
        setState(() {});
      });
    }
  }

  /// if you want tutorial please check [Youtube](https://youtube.com/@azkadev)
  void playFromFile(File file) {
    if (isDesktop) {
      desktopPlayer.open(
        _getDesktopPlayListFromFile(file),
      );
    }
  }

  /// if you want tutorial please check [Youtube](https://youtube.com/@azkadev)
  FutureOr<bool> openNetwork(String url) async {
    if (isDesktop) {
      desktopPlayer.open(
        dart_vlc.Playlist(
          medias: [
            dart_vlc.Media.network(url),
          ],
        ),
      );
    } else if (isMobile) {
      mobilePlayer = video_player.VideoPlayerController.network(url);
      await mobilePlayer.initialize();
    }
    return false;
  }

  /// if you want tutorial please check [Youtube](https://youtube.com/@azkadev)
  FutureOr<bool> openAsset(String path) async {
    if (isDesktop) {
      desktopPlayer.open(
        _getDesktopPlayListFromAsset(path),
      );
    } else {
      mobilePlayer = video_player.VideoPlayerController.asset(path);
      await mobilePlayer.initialize();
    }
    return false;
  }

  FutureOr<bool> openFile(File file) async {
    if (isDesktop) {
      desktopPlayer.open(
        _getDesktopPlayListFromFile(file),
      );
      return true;
    }
    return false;
  }

  /// if you want tutorial please check [Youtube](https://youtube.com/@azkadev)
  Duration getDurationMax() {
    if (isDesktop) {
      return desktopPlayer.position.duration ?? Duration();
    } else {
      return mobilePlayer.value.duration;
    }
  }

  /// if you want tutorial please check [Youtube](https://youtube.com/@azkadev)
  Duration getDurationPosition() {
    if (isDesktop) {
      return desktopPlayer.position.position ?? Duration();
    } else {
      return mobilePlayer.value.position;
    }
  }

  /// if you want tutorial please check [Youtube](https://youtube.com/@azkadev)
  Stream? streamDurationPosition() {
    if (isDesktop) {
      return desktopPlayer.positionStream;
    } else if (isMobile) {}
    return Stream.value("ok");
  }

  /// if you want tutorial please check [Youtube](https://youtube.com/@azkadev)
  seek(Duration duration) {
    if (isDesktop) {
      desktopPlayer.seek(duration);
    } else {
      mobilePlayer.seekTo(duration);
    }
  }

  /// if you want tutorial please check [Youtube](https://youtube.com/@azkadev)
  void playOrPause() {
    if (isDesktop) {
      desktopPlayer.playOrPause();
    } else {
      (mobilePlayer.value.isPlaying == true) ? mobilePlayer.pause() : mobilePlayer.play();
    }
  }

  /// if you want tutorial please check [Youtube](https://youtube.com/@azkadev)
  bool get isPlaying {
    if (isDesktop) {
      return desktopPlayer.playback.isPlaying;
    } else {
      return mobilePlayer.value.isPlaying;
    }
  }

  /// if you want tutorial please check [Youtube](https://youtube.com/@azkadev)
  void play() {
    if (isDesktop) {
      desktopPlayer.play();
    } else {
      mobilePlayer.play();
    }
  }

  /// if you want tutorial please check [Youtube](https://youtube.com/@azkadev)
  void pause() {
    if (isDesktop) {
      desktopPlayer.pause();
    } else {
      mobilePlayer.pause();
    }
  }

  /// if you want tutorial please check [Youtube](https://youtube.com/@azkadev)
  Size get size {
    if (isDesktop) {
      return Size(desktopPlayer.videoDimensions.width.toDouble(), desktopPlayer.videoDimensions.height.toDouble());
    } else {
      return mobilePlayer.value.size;
    }
  }

  /// if you want tutorial please check [Youtube](https://youtube.com/@azkadev)
  double get aspectRatio {
    if (isDesktop) {
      if (size.width == 0 || size.height == 0) {
        return 1.0;
      }
      final double aspectRatios = size.width / size.height;
      if (aspectRatios <= 0) {
        return 1.0;
      }
      return aspectRatios;
    } else {
      return mobilePlayer.value.aspectRatio;
    }
  }

  /// if you want tutorial please check [Youtube](https://youtube.com/@azkadev)
  void setPlaybackSpeed(double speed) {
    if (isDesktop) {
      desktopPlayer.setRate(speed);
    } else {
      mobilePlayer.setPlaybackSpeed(speed);
    }
  }

  /// if you want tutorial please check [Youtube](https://youtube.com/@azkadev)
  void setVolume(double volume) {
    if (isDesktop) {
      desktopPlayer.setVolume(volume);
    } else {
      mobilePlayer.setVolume(volume);
    }
  }
}
