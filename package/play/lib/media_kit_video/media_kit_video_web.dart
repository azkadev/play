import 'package:flutter/material.dart';

class VideoController {
  VideoController();
  static Future<VideoController> create(Future<int> handle) async {
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
