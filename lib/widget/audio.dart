

import 'package:flutter/material.dart';
import 'package:play/play.dart';

/// if you want tutorial please chek [Youtube](https://youtube.com/@azkadev)
class Audio extends StatefulWidget {
  final int id;
  final AudioData audioData;
  final bool isAutoStart;
  final Widget Function(BuildContext context, Widget child, Audio audio,
      AudioState audioState, AudioController audioController) builder;
  Audio({
    super.key,
    this.id = 0,
    this.isAutoStart = false,
    required this.audioData,
    required this.builder,
  });

  @override
  State<Audio> createState() => AudioState();
}

/// if you want tutorial please chek [Youtube](https://youtube.com/@azkadev)
class AudioState extends State<Audio> {
  late final AudioController audioController =
      AudioController(isAutoStart: widget.isAutoStart);
  @override
  void initState() {
    super.initState();
    audioController.initState(audioData: widget.audioData);
  }

  @override
  void dispose() {
    audioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, Container(), widget, this, audioController);
  }
}
