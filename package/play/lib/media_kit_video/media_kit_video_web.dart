import 'package:flutter/material.dart';
import 'package:play/media_kit/media_kit.dart';

class VideoController {
  VideoController(Player handle);
  // static Future<VideoController> create(Player handle) async {
  //   return VideoController();
  // }

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
