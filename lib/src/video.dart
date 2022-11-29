part of play;

/// if you want tutorial please chek [Youtube](https://youtube.com/@azkadev)
enum VideoFromType {
  asset,
  file,
  network,
}

/// if you want tutorial please chek [Youtube](https://youtube.com/@azkadev)
class VideoData {
  final VideoFromType videoFromType;
  final String path;
  VideoData({
    required this.videoFromType,
    required this.path,
  });
  factory VideoData.asset({
    required String path,
  }) {
    return VideoData(
      path: path,
      videoFromType: VideoFromType.asset,
    );
  }
  factory VideoData.file({
    required File file,
  }) {
    return VideoData(
      path: file.path,
      videoFromType: VideoFromType.file,
    );
  }
  factory VideoData.network({
    required String url,
  }) {
    return VideoData(
      path: url,
      videoFromType: VideoFromType.network,
    );
  }
}
