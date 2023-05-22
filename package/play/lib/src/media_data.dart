import 'dart:convert';

import 'package:googleapis_client/googleapis_client.dart';
import 'package:play/scheme/media_data_manifest.dart';
import 'package:play/src/media_from_type.dart';
import 'package:universal_io/io.dart';

/// if you want tutorial please check [Youtube](https://youtube.com/@azkadev)
class MediaData extends MediaDataManifest {
  /// if you want tutorial please check [Youtube](https://youtube.com/@azkadev)
  MediaData(super.rawData);

  String get path {
    if (video_data != null) {
      return video_data ?? "";
    }
    if (url != null) {
      return url ?? "";
    }

    return "";
  }

  MediaFromType get videoFromType {
    if (video_from == MediaFromType.file.name) {
      return MediaFromType.file;
    }
    if (video_from == MediaFromType.asset.name) {
      return MediaFromType.asset;
    }
    if (video_from == MediaFromType.network.name) {
      return MediaFromType.network;
    }
    return MediaFromType.network;
  }

  /// if you want tutorial please check [Youtube](https://youtube.com/@azkadev)
  static MediaData asset({
    required String path,
  }) {
    return MediaData.create(
      special_type: "mediaDataManifest",
      video_from: MediaFromType.asset.name,
      video_data: path,
    );
  }

  /// if you want tutorial please check [Youtube](https://youtube.com/@azkadev)
  static MediaData file({
    required File file,
  }) {
    return MediaData.create(
      special_type: "mediaDataManifest",
      video_from: MediaFromType.file.name,
      video_data: file.path,
    );
  }

  /// if you want tutorial please check [Youtube](https://youtube.com/@azkadev)
  static MediaData network({
    required String url,
  }) {
    return MediaData.create(
      special_type: "mediaDataManifest",
      video_from: MediaFromType.network.name,
      video_data: url,
    );
  }

  /// if you want tutorial please check [Youtube](https://youtube.com/@azkadev)
  static Future<MediaData?> youtube({
    required String url,
  }) async {
    void prettyPrintData(dynamic data) {
      if (data is Map || data is List) {
        print(JsonEncoder.withIndent(" " * 2).convert(data));
      } else {
        print("${data.toString()}");
      }
    }

    GoogleApisClient googleApisClient =
        GoogleApisClient(googleApisClientApiKey: GoogleApisClientApiKey({}));

    YoutubeVideoManifest youtubeVideoManifest =
        await googleApisClient.youtube_no_auth.getVideoManifest(
      video_id: url,
    );
    List<YoutubeVideoManifestMuxed> youtubeVideoManifestVideos =
        youtubeVideoManifest.muxeds;
    List<int> yts = youtubeVideoManifestVideos
        .where((element) => element.quality != null)
        .map((e) {
      int parse_quality = () {
        try {
          return int.tryParse(RegExp(r"([0-9]+)", caseSensitive: false)
                      .stringMatch(e.quality ?? "") ??
                  "0") ??
              0;
        } catch (e) {}
        return 0;
      }.call();
      return parse_quality;
    }).toList();
    yts.sort();
    yts = yts.reversed.toSet().toList();
    if (yts.isEmpty) {
      return null;
    }
    for (var i = 0; i < yts.length; i++) {
      int resolution = yts[i];
      for (var index = 0; index < youtubeVideoManifestVideos.length; index++) {
        YoutubeVideoManifestMuxed youtubeVideoManifestVideo =
            youtubeVideoManifestVideos[index];

        int parse_quality = () {
          try {
            return int.tryParse(RegExp(r"([0-9]+)", caseSensitive: false)
                        .stringMatch(youtubeVideoManifestVideo.quality ?? "") ??
                    "0") ??
                0;
          } catch (e) {}
          return 0;
        }.call();

        if (parse_quality == resolution) {
          youtubeVideoManifestVideo["video_from"] = MediaFromType.network.name;
          youtubeVideoManifestVideo["video_data"] =
              youtubeVideoManifestVideo.url;
          return MediaData(
            youtubeVideoManifestVideo.toJson(),
          );
        }
      }
    }
    return null;
  }

  static MediaData create({
    String? special_type,
    String? audio_codec,
    int? framerate,
    String? video_codec,
    String? video_quality,
    int? height,
    int? width,
    int? bitrate,
    String? mime_type,
    String? container_name,
    bool? is_throttled,
    String? quality,
    int? size,
    int? tag,
    String? video_from,
    String? video_data,
    String? url,
  }) {
    MediaData mediaDataManifest = MediaData({
      "@type": special_type,
      "audio_codec": audio_codec,
      "framerate": framerate,
      "video_codec": video_codec,
      "video_quality": video_quality,
      "height": height,
      "width": width,
      "bitrate": bitrate,
      "mime_type": mime_type,
      "container_name": container_name,
      "is_throttled": is_throttled,
      "quality": quality,
      "size": size,
      "tag": tag,
      "video_from": video_from,
      "video_data": video_data,
      "url": url,
    });

    return mediaDataManifest;
  }
}
