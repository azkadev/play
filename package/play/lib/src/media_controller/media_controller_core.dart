import 'dart:async';

import "package:flutter/foundation.dart";
import "package:play/src/media_data.dart";
import "package:play/src/media_from_type.dart";
import 'package:universal_io/io.dart';

import "package:video_player/video_player.dart" as video_player;

import "package:play/media_kit/media_kit.dart" as media_kit;

import "package:play/media_kit_video/media_kit_video.dart" as media_kit_video;

/// if you want tutorial please check [Youtube](https://youtube.com/@azkadev)
class MediaController {
  late media_kit.Player desktop_player;
  late video_player.VideoPlayerController mobilePlayer;
  late media_kit_video.VideoController desktopPlayer;
  final int id;
  final bool isAutoStart;

  bool is_init = false;

  bool get isDesktop {
    if (kIsWeb) {
      return false;
    }
    if (Platform.isWindows ||
        Platform.isLinux ||
        Platform.isAndroid ||
        Platform.isIOS) {
      return true;
    }

    return false;
  }

  bool get isMobile {
    if (kIsWeb) {
      return true;
    }
    return false;
  }

  media_kit.Playlist _getDesktopPlayListFromFile(File file) {
    return media_kit.Playlist(
      [
        media_kit.Media(file.path),
      ],
    );
  }

  media_kit.Playlist _getDesktopPlayListFromAsset(String path) {
    return media_kit.Playlist(
      [
        media_kit.Media(path),
      ],
    );
  }

  /// if you want tutorial please check [Youtube](https://youtube.com/@azkadev)
  MediaController({
    this.id = 0,
    this.isAutoStart = false,
  });

  /// if you want tutorial please check [Youtube](https://youtube.com/@azkadev)
  Future<void> dispose() async {
    if (!is_init) {
      return;
    }
    if (isDesktop) {
      // desktopPlayer
      // await desktopPlayer.dispose();
      await desktop_player.dispose();
    } else {
      await mobilePlayer.dispose();
    }
  }

  /// if you want tutorial please check [Youtube](https://youtube.com/@azkadev)
  Future<void> initialize({
    required void Function(void Function() fn) setState,
    required MediaData mediaData,
    required void Function(bool isInit) onReady,
  }) async {
    MediaFromType type = mediaData.videoFromType;
    if (isDesktop) {
      desktop_player = media_kit.Player();

      setState(() {});
      media_kit.Playlist? playlist;
      if (type == MediaFromType.asset) {
        playlist = _getDesktopPlayListFromAsset(mediaData.path);
      } else if (type == MediaFromType.file) {
        playlist = _getDesktopPlayListFromFile(File(mediaData.path));
      } else if (type == MediaFromType.network) {
        playlist = media_kit.Playlist(
          [
            media_kit.Media(mediaData.path),
          ],
        );
      } else {
        playlist = media_kit.Playlist([]);
      }
      desktopPlayer = await media_kit_video.VideoController(
        desktop_player,
      );

      await desktop_player.open(
        playlist,
        play: true,
      );
      setState(() {});
      onReady.call(true);
      is_init = true;
      setState(() {});
    } else if (isMobile) {
      if (type == MediaFromType.asset) {
        setState(() {
          mobilePlayer =
              video_player.VideoPlayerController.asset(mediaData.path);
        });
      } else if (type == MediaFromType.file) {
        setState(() {
          mobilePlayer =
              video_player.VideoPlayerController.file(File(mediaData.path));
        });
      } else if (type == MediaFromType.network) {
        setState(() {
          mobilePlayer =
              video_player.VideoPlayerController.network(mediaData.path);
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
      desktop_player.open(
        _getDesktopPlayListFromFile(file),
      );
    }
  }

  /// if you want tutorial please check [Youtube](https://youtube.com/@azkadev)
  FutureOr<bool> openNetwork(String url) async {
    if (isDesktop) {
      await desktop_player.open(
        media_kit.Playlist(
          [
            media_kit.Media(url),
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
      desktop_player.open(
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
      await desktop_player.open(
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
