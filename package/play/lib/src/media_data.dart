
import 'package:googleapis_client/googleapis_client.dart';
import 'package:play/src/media_from_type.dart';
import 'package:universal_io/io.dart';

/// if you want tutorial please check [Youtube](https://youtube.com/@azkadev)
class MediaData {
  final MediaFromType videoFromType;
  final String path;

  /// if you want tutorial please check [Youtube](https://youtube.com/@azkadev)
  MediaData({
    required this.videoFromType,
    required this.path,
  });

  /// if you want tutorial please check [Youtube](https://youtube.com/@azkadev)
  factory MediaData.asset({
    required String path,
  }) {
    return MediaData(
      path: path,
      videoFromType: MediaFromType.asset,
    );
  }

  /// if you want tutorial please check [Youtube](https://youtube.com/@azkadev)
  factory MediaData.file({
    required File file,
  }) {
    return MediaData(
      path: file.path,
      videoFromType: MediaFromType.file,
    );
  }

  /// if you want tutorial please check [Youtube](https://youtube.com/@azkadev)
  factory MediaData.network({
    required String url,
  }) {
    return MediaData(
      path: url,
      videoFromType: MediaFromType.network,
    );
  }

  /// if you want tutorial please check [Youtube](https://youtube.com/@azkadev)
  static Future<MediaData?> youtube({
    required String url,
  }) async {
    GoogleApisClient googleApisClient = GoogleApisClient(googleApisClientApiKey: GoogleApisClientApiKey({}));

    YoutubeVideoManifest youtubeVideoManifest = await googleApisClient.youtube_no_auth.getVideoManifest(
      video_id: url,
    );
    youtubeVideoManifest.videos.where((element) => element.quality != null).map((e) {
      int parse_quality = 0;
      return parse_quality;
    }).toList().sort();
    return MediaData(
      path:url,
      videoFromType: MediaFromType.network,
    );
  }
}
