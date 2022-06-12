import 'package:flutter/widgets.dart';

class Video {
  static assets(
    String path, {
    required void Function(UpdateVideo res) callback,
    VideoController? controller,
    void Function()? onTap,
    Widget? child
  }) {
    return callback(UpdateVideo());
  }

  static url(String url) {}
}

class VideoController {
  VideoController();

  setOffset(int offset) {}

  void get play {}
}

class UpdateVideo {
  UpdateVideo();
  get raw {}
}
