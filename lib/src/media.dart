import "dart:ui";

import "media_app.dart" if (dart.library.html) "media_web.dart";
export "media_app.dart" if (dart.library.html) "media_web.dart";

extension MediaControllerExtensions on MediaController {
  /// if you want tutorial please check [Youtube](https://youtube.com/@azkadev)
  Duration getDurationMax() {
    if (!is_init) {
      return Duration();
    }
    if (isDesktop) {
      return desktopPlayer.position.duration ?? Duration();
    } else {
      return mobilePlayer.value.duration;
    }
  }

  /// if you want tutorial please check [Youtube](https://youtube.com/@azkadev)
  Duration getDurationPosition() {
    if (!is_init) {
      return Duration();
    }
    if (isDesktop) {
      return desktopPlayer.position.position ?? Duration();
    } else {
      return mobilePlayer.value.position;
    }
  }

  /// if you want tutorial please check [Youtube](https://youtube.com/@azkadev)
  Future<Duration> position() async {
    if (!is_init) {
      return Duration();
    }
    if (isDesktop) {
      return (await desktopPlayer.positionStream.last).position ?? Duration();
    } else if (isMobile) {
      return (await mobilePlayer.position) ?? Duration();
    }
    return Duration();
  }

  /// if you want tutorial please check [Youtube](https://youtube.com/@azkadev)
  Stream? streamDurationPosition() {
    if (!is_init) {
      return Stream.value("ok");
    }
    if (isDesktop) {
      return desktopPlayer.positionStream;
    } else if (isMobile) {
      return mobilePlayer.position.asStream();
    }
    return Stream.value("ok");
  }

  /// if you want tutorial please check [Youtube](https://youtube.com/@azkadev)
  Future<void> seek(Duration duration) async {
    if (!is_init) {
      return;
    }
    if (isDesktop) {
      desktopPlayer.seek(duration);
    } else {
      await mobilePlayer.seekTo(duration);
    }
  }

  /// if you want tutorial please check [Youtube](https://youtube.com/@azkadev)
  Future<void> playOrPause() async {
    if (!is_init) {
      return;
    }

    if (isDesktop) {
      desktopPlayer.playOrPause();
    } else {
      (mobilePlayer.value.isPlaying == true)
          ? await mobilePlayer.pause()
          : await mobilePlayer.play();
    }
  }

  /// if you want tutorial please check [Youtube](https://youtube.com/@azkadev)
  bool get isPlaying {
    if (!is_init) {
      return false;
    }
    if (isDesktop) {
      return desktopPlayer.playback.isPlaying;
    } else {
      return mobilePlayer.value.isPlaying;
    }
  }

  /// if you want tutorial please check [Youtube](https://youtube.com/@azkadev)
  Future<void> play() async {
    if (!is_init) {
      return;
    }
    if (isDesktop) {
      desktopPlayer.play();
    } else {
      await mobilePlayer.play();
    }
  }

  /// if you want tutorial please check [Youtube](https://youtube.com/@azkadev)
  Future<void> pause() async {
    if (!is_init) {
      return;
    }

    if (isDesktop) {
      desktopPlayer.pause();
    } else {
      await mobilePlayer.pause();
    }
  }

  /// if you want tutorial please check [Youtube](https://youtube.com/@azkadev)
  Size get size {
    if (!is_init) {
      return Size(0, 0);
    }
    if (isDesktop) {
      return Size(desktopPlayer.videoDimensions.width.toDouble(),
          desktopPlayer.videoDimensions.height.toDouble());
    } else {
      return mobilePlayer.value.size;
    }
  }

  /// if you want tutorial please check [Youtube](https://youtube.com/@azkadev)
  double get aspectRatio {
    if (!is_init) {
      return 1.0;
    }
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
  Future<void> setPlaybackSpeed(double speed) async {
    if (!is_init) {
      return;
    }
    if (isDesktop) {
      desktopPlayer.setRate(speed);
    } else {
      await mobilePlayer.setPlaybackSpeed(speed);
    }
  }

  /// if you want tutorial please check [Youtube](https://youtube.com/@azkadev)
  Future<void> setVolume(double volume) async {
    if (!is_init) {
      return;
    }
    if (isDesktop) {
      desktopPlayer.setVolume(volume);
    } else {
      await mobilePlayer.setVolume(volume);
    }
  }
}
