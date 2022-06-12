import 'package:flutter/widgets.dart';
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
