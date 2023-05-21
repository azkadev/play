import "dart:ui";

// import "media_app.dart" if (dart.library.html) "media_web.dart";
// export "media_app.dart" if (dart.library.html) "media_web.dart";
 

import "media_app.dart" if (dart.library.html) "media_web.dart";
export "media_app.dart" if (dart.library.html) "media_web.dart";

extension MediaControllerExtensions on MediaController {
  /// if you want tutorial please check [Youtube](https://youtube.com/@azkadev)
  Duration getDurationMax() {
    if (!is_init) {
      return Duration();
    }
    if (isDesktop) {
      return desktop_player.state.duration;
      // return desktop_player.position.duration ?? Duration();
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
      return desktop_player.state.position;
      // return desktop_player.position.position ?? Duration();
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
      return desktop_player.streams.position.last;
    } else if (isMobile) {
      return (await mobilePlayer.position) ?? Duration();
    }
    return Duration();
  }

  /// if you want tutorial please check [Youtube](https://youtube.com/@azkadev)
  Stream? streamDurationPosition() {
    if (!is_init) {
      return Stream.value(Duration(milliseconds: 1));
    }
    if (isDesktop) {
      return desktop_player.streams.position;
      // return desktop_player.positionStream;
    } else if (isMobile) {
      return mobilePlayer.position.asStream();
    }
    return Stream.value(Duration());
  }

  /// if you want tutorial please check [Youtube](https://youtube.com/@azkadev)
  Future<void> seek(Duration duration) async {
    if (!is_init) {
      return;
    }
    if (isDesktop) {
      await desktop_player.seek(duration);
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
      await desktop_player.playOrPause();
    } else {
      (mobilePlayer.value.isPlaying == true) ? await mobilePlayer.pause() : await mobilePlayer.play();
    }
  }

  /// if you want tutorial please check [Youtube](https://youtube.com/@azkadev)
  bool get isPlaying {
    if (!is_init) {
      return false;
    }
    if (isDesktop) {
      // return desktop_player.playback.isPlaying;
    } else {
      return mobilePlayer.value.isPlaying;
    }
    return false;
  }

  /// if you want tutorial please check [Youtube](https://youtube.com/@azkadev)
  Future<void> play() async {
    if (!is_init) {
      return;
    }
    if (isDesktop) {
      await desktop_player.play();
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
      await desktop_player.pause();
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
      // return Size(desktop_player.videoDimensions.width.toDouble(), desktop_player.videoDimensions.height.toDouble());
    } else {
      return mobilePlayer.value.size;
    }
    return Size(0, 0);
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
      // desktop_player.setRate(speed);
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
      // desktop_player.setVolume(volume);
    } else {
      await mobilePlayer.setVolume(volume);
    }
  }
}
