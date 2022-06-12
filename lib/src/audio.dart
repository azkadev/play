import 'package:flutter/widgets.dart';

class Audio {
  static assets(
    String path, {
    required void Function(UpdateAudio res) callback,
    AudioController? controller,
    void Function()? onTap,
    Widget? child
  }) {
    return callback(UpdateAudio());
  }

  static url(String url) {}
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
