part of play;

/// if you want tutorial please chek [Youtube](https://youtube.com/@azkadev)
class Audio extends StatefulWidget {
  final int id;
  final AudioData audioData;
  final bool isAutoStart;
  final Widget Function(BuildContext context, Widget child, Audio audio,
      AudioState audioState) audioViewBuilder;
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

/// if you want tutorial please chek [Youtube](https://youtube.com/@azkadev)
class AudioState extends State<Audio> {
  final audio_player.AudioPlayer audio = audio_player.AudioPlayer();
  @override
  void initState() {
    super.initState();
    if (widget.audioData.audioFromType == AudioFromType.asset) {
      open(audio_player.AssetSource(widget.audioData.path));
    } else if (widget.audioData.audioFromType == AudioFromType.file) {
      open(audio_player.DeviceFileSource(widget.audioData.path));
    } else if (widget.audioData.audioFromType == AudioFromType.network) {
      open(audio_player.UrlSource(widget.audioData.path));
    }
  }

  @override
  void dispose() {
    audio.dispose();
    super.dispose();
  }

  Future<void> open(
    audio_player.Source source, {
    double? volume,
    audio_player.AudioContext? ctx,
    Duration? position,
    audio_player.PlayerMode? mode,
  }) async {
    await audio.play(source,
        volume: volume, ctx: ctx, position: position, mode: mode);
    if (widget.isAutoStart) {
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

  @override
  Widget build(BuildContext context) {
    return widget.audioViewBuilder(context, Container(), widget, this);
  }
}
