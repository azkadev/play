import 'dart:async';

import 'package:flutter/material.dart';
import 'package:universal_io/io.dart';

import 'package:dart_vlc/dart_vlc.dart' if (dart.library.html) 'package:play/dart_vlc/web.dart' as dart_vlc;
import "package:video_player/video_player.dart" as video_player;

/// if you want tutorial please check [Youtube](https://youtube.com/@azkadev)
enum MediaFromType {
  asset,
  file,
  network,
}

/// if you want tutorial please check [Youtube](https://youtube.com/@azkadev)
class MediaData {
  final MediaFromType videoFromType;
  final String path;

  /// if you want tutorial please check [Youtube](https://youtube.com/@azkadev)
  MediaData({
    required this.videoFromType,
    required this.path,
  });

  /// if you want tutorial please check [Youtube](https://youtube.com/@azkadev)
  factory MediaData.asset({
    required String path,
  }) {
    return MediaData(
      path: path,
      videoFromType: MediaFromType.asset,
    );
  }

  /// if you want tutorial please check [Youtube](https://youtube.com/@azkadev)
  factory MediaData.file({
    required File file,
  }) {
    return MediaData(
      path: file.path,
      videoFromType: MediaFromType.file,
    );
  }

  /// if you want tutorial please check [Youtube](https://youtube.com/@azkadev)
  factory MediaData.network({
    required String url,
  }) {
    return MediaData(
      path: url,
      videoFromType: MediaFromType.network,
    );
  }
}

/// if you want tutorial please check [Youtube](https://youtube.com/@azkadev)
class MediaController {
  late dart_vlc.Player desktopPlayer;
  late video_player.VideoPlayerController mobilePlayer;
  final int id;
  final bool isAutoStart;

  bool is_init = false;
  bool get isDesktop => Platform.isWindows || Platform.isLinux;
  bool get isMobile => Platform.isAndroid || Platform.isIOS;

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
  MediaController({
    this.id = 0,
    this.isAutoStart = false,
  });

  /// if you want tutorial please check [Youtube](https://youtube.com/@azkadev)
  void dispose() {
    if (!is_init) {
      return;
    }
    if (isDesktop) {
      desktopPlayer.dispose();
    } else {
      mobilePlayer.dispose();
    }
  }

  /// if you want tutorial please check [Youtube](https://youtube.com/@azkadev)
  Future<void> initialize({required void Function(void Function() fn) setState, required MediaData mediaData, required void Function(bool isInit) onReady}) async {
    MediaFromType type = mediaData.videoFromType;
    if (isDesktop) {
      setState(() {
        desktopPlayer = dart_vlc.Player(
          id: id,
        );
      });
      onReady.call(true);
      setState(() {});

      dart_vlc.Playlist? playlist;
      if (type == MediaFromType.asset) {
        playlist = _getDesktopPlayListFromAsset(mediaData.path);
      } else if (type == MediaFromType.file) {
        playlist = _getDesktopPlayListFromFile(File(mediaData.path));
      } else if (type == MediaFromType.network) {
        playlist = dart_vlc.Playlist(
          medias: [
            dart_vlc.Media.network(mediaData.path),
          ],
        );
      }

      desktopPlayer.open(
        playlist!,
        autoStart: isAutoStart,
      );
    } else if (isMobile) {
      if (type == MediaFromType.asset) {
        setState(() {
          mobilePlayer = video_player.VideoPlayerController.asset(mediaData.path);
        });
      } else if (type == MediaFromType.file) {
        setState(() {
          mobilePlayer = video_player.VideoPlayerController.file(File(mediaData.path));
        });
      } else if (type == MediaFromType.network) {
        setState(() {
          mobilePlayer = video_player.VideoPlayerController.network(mediaData.path);
        });
      }
      await mobilePlayer.initialize();
      if (isAutoStart) {
        await mobilePlayer.play();
      }
      setState(() {});
      onReady.call(true);
      is_init = true;
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
    } else if (isMobile) {
      mobilePlayer = video_player.VideoPlayerController.file(file);
      await mobilePlayer.initialize();
      return true;
    }
    return false;
  }
  
}
