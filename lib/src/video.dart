import 'package:flutter/widgets.dart';
/// Load Video
/// 
/// 
/// load video from assets path
/// example
/// ```dart
/// Video.asset(
///   "/path_video.mp4",
///   controller: VideoController(),
///   callback: (UpdateVideo res) {
///     print(res.raw);
///   },
///   onTap: () {
///     print("oke");
///   },
///   child: Padding(padding: EdgeInsets.all(20), child: Image.asset("/path_image.jpg")),
/// );
class Video {
  /// load video from assets path
  /// example
  /// ```dart
  /// Video.asset(
  ///   "/path_video.mp4",
  ///   controller: VideoController(),
  ///   callback: (UpdateVideo res) {
  ///     print(res.raw);
  ///   },
  ///   onTap: () {
  ///     print("oke");
  ///   },
  ///   child: Padding(padding: EdgeInsets.all(20), child: Image.asset("/path_image.jpg")),
  /// );
  /// ```
  static asset(String path, {required void Function(UpdateVideo res) callback, VideoController? controller, void Function()? onTap, Widget? child}) {
    return callback(UpdateVideo());
  }
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
