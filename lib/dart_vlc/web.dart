import 'package:flutter/material.dart';
import 'package:universal_io/io.dart';

class DartVLC {
  static initialize({
    bool useFlutterNativeView = false,
  }) {}
}

class Player {
  Player({
    int id = 0,
    bool registerTexture = false,
  });

  open(
    Playlist playlist, {
    bool autoStart = false,
  }) {}
  dispose() {}
  get position {}
  setVolume(double volume) {}
  setRate(double rate) {}

  play() {}

  pause() {}
  playOrPause() {}
  seek(Duration duration) {}

  Stream get positionStream {
    return Stream.value("value");
  }

  get playback {}
  get videoDimensions {}
}

class Playlist {
  Playlist({
    required List medias,
  });
}

enum PlaylistMode {
  single,
}

class Media {
  Media();
  factory Media.asset(String source) {
    return Media();
  }
  factory Media.file(File source) {
    return Media();
  }

  factory Media.network(String source) {
    return Media();
  }
}

class Video extends StatelessWidget {
  /// The [Player] whose [Video] output should be shown.
  final Player player;

  /// Width of the viewport.
  /// Defaults to the width of the parent.
  final double? width;

  /// Height of the viewport.
  /// Defaults to the height of the parent.
  final double? height;

  /// How to inscribe the picture box into the player viewport.
  /// Defaults to [BoxFit.contain].
  final BoxFit fit;

  /// How to align the picture box within the player viewport.
  /// Defaults to [Alignment.center]
  final AlignmentGeometry alignment;

  /// Scale.
  final double scale;

  /// Filter quality.
  final FilterQuality filterQuality;

  /// Built-In video controls.
  final bool showControls;

  /// Radius of the progressbar's thumb
  final double? progressBarThumbRadius;

  /// Radius of the progressbar's glow of the thumb
  final double? progressBarThumbGlowRadius;

  /// Active color of the progress bar
  final Color? progressBarActiveColor;

  /// Inactive color of the progress bar
  final Color? progressBarInactiveColor;

  /// Thumb color of the progress bar
  final Color? progressBarThumbColor;

  /// Thumb's glow color of the progress bar
  final Color? progressBarThumbGlowColor;

  /// TextStyle for the Progress Bar
  final TextStyle progressBarTextStyle;

  /// Active color of the volume slider
  final Color? volumeActiveColor;

  /// Inactive color of the volume slider
  final Color? volumeInactiveColor;

  /// Background color of the volume slider
  final Color volumeBackgroundColor;

  /// Thumb color of the volume slider
  final Color? volumeThumbColor;

  /// If you want the progress bar to display the time left while playing
  /// instead of the total time, set this to true
  final bool showTimeLeft;

  /// Whether to show the fullscreen button.
  final bool showFullscreenButton;

  /// Fill color.
  final Color fillColor;

  const Video({
    super.key,
    required this.player,
    this.width,
    this.height,
    this.fit = BoxFit.contain,
    this.alignment = Alignment.center,
    this.scale = 1.0,
    this.showControls = true,
    this.progressBarActiveColor,
    this.progressBarInactiveColor = Colors.white24,
    this.progressBarThumbColor,
    this.progressBarThumbGlowColor = const Color.fromRGBO(0, 161, 214, .2),
    this.volumeActiveColor,
    this.volumeInactiveColor = Colors.grey,
    this.volumeBackgroundColor = const Color(0xff424242),
    this.volumeThumbColor,
    this.progressBarThumbRadius = 10.0,
    this.progressBarThumbGlowRadius = 15.0,
    this.showTimeLeft = false,
    this.progressBarTextStyle = const TextStyle(),
    this.filterQuality = FilterQuality.low,
    this.showFullscreenButton = false,
    required this.fillColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
