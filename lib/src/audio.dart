part of play;

/// if you want tutorial please chek [Youtube](https://youtube.com/@azkadev)
enum AudioFromType {
  asset,
  file,
  network,
}

/// if you want tutorial please chek [Youtube](https://youtube.com/@azkadev)
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
///
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

/// if you want tutorial please chek [Youtube](https://youtube.com/@azkadev)
class AudioControllerRaw {
  /// if you want tutorial please chek [Youtube](https://youtube.com/@azkadev)
  AudioControllerRaw();

  /// if you want tutorial please chek [Youtube](https://youtube.com/@azkadev)
  setOffset(int offset) {}

  /// if you want tutorial please chek [Youtube](https://youtube.com/@azkadev)
  void get play {}
}

/// if you want tutorial please chek [Youtube](https://youtube.com/@azkadev)
class UpdateAudioRaw {
  /// if you want tutorial please chek [Youtube](https://youtube.com/@azkadev)
  UpdateAudioRaw();

  /// if you want tutorial please chek [Youtube](https://youtube.com/@azkadev)
  get raw {}
}
