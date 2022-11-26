import 'package:flutter/widgets.dart';
import 'package:audioplayers/audioplayers.dart' as audio_player;

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
class AudioRaw {
  final player = audio_player.AudioPlayer();

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
  static asset(String path,
      {required void Function(UpdateAudioRaw res) callback,
      AudioControllerRaw? controller,
      void Function()? onTap,
      Widget? child}) {
    return callback(UpdateAudioRaw());
  }

  Future<void> play(
    audio_player.Source source, {
    double? volume,
    audio_player.AudioContext? ctx,
    Duration? position,
    audio_player.PlayerMode? mode,
  }) async {
    await player.play(source,
        volume: volume, ctx: ctx, position: position, mode: mode);
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

class AudioControllerRaw {
  AudioControllerRaw();

  setOffset(int offset) {}

  void get play {}
}

class UpdateAudioRaw {
  UpdateAudioRaw();
  get raw {}
}

class Audio extends StatefulWidget {
  final Widget Function(Widget child, Audio audio, AudioState audioState)
      audioViewBuilder;
  Audio({
    super.key,
    required this.audioViewBuilder,
  });

  @override
  State<Audio> createState() => AudioState();
}

class AudioState extends State<Audio> {
  final audio_player.AudioPlayer audio = audio_player.AudioPlayer();
  static asset(String path,
      {required void Function(UpdateAudioRaw res) callback,
      AudioControllerRaw? controller,
      void Function()? onTap,
      Widget? child}) {
    return callback(UpdateAudioRaw());
  }

  Future<void> play(
    audio_player.Source source, {
    double? volume,
    audio_player.AudioContext? ctx,
    Duration? position,
    audio_player.PlayerMode? mode,
  }) async {
    await audio.play(source,
        volume: volume, ctx: ctx, position: position, mode: mode);
  }

  Future<void> pause() async {
    await audio.pause();
  }

  Future<void> resume() async {
    await audio.resume();
  }

  Future<void> stop() async {
    await audio.stop();
  }

  @override
  Widget build(BuildContext context) {
    return widget.audioViewBuilder(Container(), widget, this);
  }
}
