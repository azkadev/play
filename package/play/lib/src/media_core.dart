import "dart:ui";

// import 'media_controller/media_controller.dart' if (dart.library.html) "media_web.dart";
// export 'media_controller/media_controller.dart' if (dart.library.html) "media_web.dart";

import 'media_controller/media_controller_core.dart';
export 'media_controller/media_controller_core.dart';

extension MediaControllerExtensions on MediaController {
  /// if you want tutorial please check [Youtube](https://youtube.com/@azkadev)
  Duration getDurationMax() {
    if (!is_init) {
      return Duration();
    }
    return desktop_player.state.duration;
  }

  /// if you want tutorial please check [Youtube](https://youtube.com/@azkadev)
  Duration getDurationPosition() {
    if (!is_init) {
      return Duration();
    }
    return desktop_player.state.position;
    // return desktop_player.position.position ?? Duration();
  }

  /// if you want tutorial please check [Youtube](https://youtube.com/@azkadev)
  Future<Duration> position() async {
    if (!is_init) {
      return Duration();
    }
    return desktop_player.streams.position.last;
  }

  /// if you want tutorial please check [Youtube](https://youtube.com/@azkadev)
  Stream? streamDurationPosition() {
    if (!is_init) {
      return Stream.value(Duration(milliseconds: 1));
    }
    return desktop_player.streams.position;
  }

  /// if you want tutorial please check [Youtube](https://youtube.com/@azkadev)
  Future<void> seek(Duration duration) async {
    if (!is_init) {
      return;
    }
    await desktop_player.seek(duration);
  }

  /// if you want tutorial please check [Youtube](https://youtube.com/@azkadev)
  Future<void> playOrPause() async {
    if (!is_init) {
      return;
    }

    await desktop_player.playOrPause();
  }

  /// if you want tutorial please check [Youtube](https://youtube.com/@azkadev)
  bool get isPlaying {
    if (!is_init) {
      return false;
    }
    return false;
  }

  /// if you want tutorial please check [Youtube](https://youtube.com/@azkadev)
  Future<void> play() async {
    if (!is_init) {
      return;
    }
    await desktop_player.play();
  }

  /// if you want tutorial please check [Youtube](https://youtube.com/@azkadev)
  Future<void> pause() async {
    if (!is_init) {
      return;
    }

    await desktop_player.pause();
  }

  /// if you want tutorial please check [Youtube](https://youtube.com/@azkadev)
  Size get size {
    if (!is_init) {
      return Size(0, 0);
    }

    return Size(0, 0);
  }

  /// if you want tutorial please check [Youtube](https://youtube.com/@azkadev)
  double get aspectRatio {
    if (!is_init) {
      return 1.0;
    }
    if (size.width == 0 || size.height == 0) {
      return 1.0;
    }
    final double aspectRatios = size.width / size.height;
    if (aspectRatios <= 0) {
      return 1.0;
    }
    return aspectRatios;
  }

  /// if you want tutorial please check [Youtube](https://youtube.com/@azkadev)
  Future<void> setPlaybackSpeed(double speed) async {
    if (!is_init) {
      return;
    }
  }

  /// if you want tutorial please check [Youtube](https://youtube.com/@azkadev)
  Future<void> setVolume(double volume) async {
    if (!is_init) {
      return;
    }
  }
}
