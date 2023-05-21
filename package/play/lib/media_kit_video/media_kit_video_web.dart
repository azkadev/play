import 'package:flutter/material.dart';
import 'package:play/media_kit/media_kit_web.dart';

class VideoController {
  VideoController();
  static Future<VideoController> create(Player handle) async {
    return VideoController();
  }

  dispose() async {}
}

class Video extends StatelessWidget {
  final VideoController controller;
  const Video({
    super.key,
    required this.controller,
  });
  @override
  Widget build(BuildContext context) {
    return SizedBox.shrink();
  }
}
