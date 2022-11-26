import 'package:flutter/widgets.dart';
import 'package:audioplayers/audioplayers.dart' as audio_player;
import 'package:universal_io/io.dart';

enum AudioFromType {
  asset,
  file,
  network,
}

class AudioData {
  final AudioFromType audioFromType;
  final String path;
  AudioData({
    required this.audioFromType,
    required this.path,
  });
  factory AudioData.asset({
    required String path,
  }) {
    return AudioData(
      path: path,
      audioFromType: AudioFromType.asset,
    );
  }
  factory AudioData.file({
    required File file,
  }) {
    return AudioData(
      path: file.path,
      audioFromType: AudioFromType.file,
    );
  }
  factory AudioData.network({
    required String url,
  }) {
    return AudioData(
      path: url,
      audioFromType: AudioFromType.network,
    );
  }
}

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
  final int id;
  final AudioData audioData;
  final bool isAutoStart;
  final Widget Function(Widget child, Audio audio, AudioState audioState)
      audioViewBuilder;
  Audio({
    super.key,
    this.id = 0,
    this.isAutoStart = false,
    required this.audioData,
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
