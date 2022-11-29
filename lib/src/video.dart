part of play;

enum VideoFromType {
  asset,
  file,
  network,
}

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
