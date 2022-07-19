import 'package:flutter/widgets.dart';
import 'package:audioplayers/audioplayers.dart';

/// Load Audio
///
///
///
/// Load audio fromm asset
/// example:
/// ```dart
/// Audio.asset(
///   "/home/azkadev/Music/audio.mp3",
///   controller: AudioController(),
///   callback: (UpdateAudio res) {
///     var update = res.raw;
///     if (update is Map) {
///       if (update["@type"] == "audio") {}
///     }
///   },
///   onTap: () {},
///   child: Padding(
///     padding: const EdgeInsets.all(10),
///     child: Image.asset("/path/thumnail"),
///   ),
/// )
/// ```
class Audio {
  final player = AudioPlayer();

  /// Load audio fromm asset
  /// example:
  /// ```dart
  /// Audio.asset(
  ///   "/home/azkadev/Music/audio.mp3",
  ///   controller: AudioController(),
  ///   callback: (UpdateAudio res) {
  ///     var update = res.raw;
  ///     if (update is Map) {
  ///       if (update["@type"] == "audio") {}
  ///     }
  ///   },
  ///   onTap: () {},
  ///   child: Padding(
  ///     padding: const EdgeInsets.all(10),
  ///     child: Image.asset("/path/thumnail"),
  ///   ),
  /// )
  /// ```
  static asset(String path, {required void Function(UpdateAudio res) callback, AudioController? controller, void Function()? onTap, Widget? child}) {
    return callback(UpdateAudio());
  }

  Future<void> play(
    Source source, {
    double? volume,
    AudioContext? ctx,
    Duration? position,
    PlayerMode? mode,
  }) async {
    await player.play(source, volume: volume, ctx: ctx, position: position, mode: mode);
    ;
  }

  Future<void> pause() async {
    await player.pause();
  }

  Future<void> resume() async {
    await player.resume();
  }

  Future<void> stop() async {
    await player.stop();
  }

}

class AudioController {
  AudioController();

  setOffset(int offset) {}

  void get play {}
}

class UpdateAudio {
  UpdateAudio();
  get raw {}
}
