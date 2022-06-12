class Video {
  static assets(
    String path, {
    required void Function(UpdateVideo res) callback,
    VideoController? controller,
    void Function()? onTap,
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
