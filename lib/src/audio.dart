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
class AudioController {
  final audio_player.AudioPlayer audio = audio_player.AudioPlayer();
  final bool isAutoStart;
  AudioController({
    this.isAutoStart = false,
  });
  void initState({required AudioData audioData}) {
    if (audioData.audioFromType == AudioFromType.asset) {
      open(audio_player.AssetSource(audioData.path));
    } else if (audioData.audioFromType == AudioFromType.file) {
      open(audio_player.DeviceFileSource(audioData.path));
    } else if (audioData.audioFromType == AudioFromType.network) {
      open(audio_player.UrlSource(audioData.path));
    }
  }

  void dispose() {
    audio.dispose();
  }

  Future<void> open(
    audio_player.Source source, {
    double? volume,
    audio_player.AudioContext? ctx,
    Duration? position,
    audio_player.PlayerMode? mode,
  }) async {
    await audio.play(source, volume: volume, ctx: ctx, position: position, mode: mode);
    if (isAutoStart) {
      await play();
    } else {
      await pause();
    }
  }

  Future<void> pause() async {
    await audio.pause();
  }

  Future<void> play() async {
    await audio.resume();
  }

  Future<void> stop() async {
    await audio.stop();
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
class UpdateAudioController {
  /// if you want tutorial please chek [Youtube](https://youtube.com/@azkadev)
  UpdateAudioController();

  /// if you want tutorial please chek [Youtube](https://youtube.com/@azkadev)
  get raw {}
}
