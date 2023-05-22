// ignore_for_file: non_constant_identifier_names
import "json_dart.dart";
// import "dart:convert";

class MediaDataManifest extends JsonScheme {
  MediaDataManifest(super.rawData);

  static Map get defaultData {
    return {
      "@type": "mediaDataManifest",
      "audio_codec": "mp4a.40.2",
      "framerate": 30,
      "video_codec": "avc1.64001f",
      "video_quality": "high720",
      "height": 720,
      "width": 1280,
      "bitrate": 848950,
      "mime_type": "video/mp4",
      "container_name": "mp4",
      "is_throttled": false,
      "quality": "720p",
      "size": 17233060,
      "tag": 22,
      "video_from": "file",
      "video_data": "",
      "url":
          "https://rr2---sn-uxa3vhnxa-q2nl.googlevideo.com/videoplayback?expire=1684795192&ei=2JprZIGKEYaowgOzxo6gBQ&ip=114.125.93.164&id=o-AOk45c2RfQrDpEFD3V0gLdOj8k0wL_iwvVgTXyUlyUKh&itag=22&source=youtube&requiressl=yes&mh=lX&mm=31%2C29&mn=sn-uxa3vhnxa-q2nl%2Csn-uxa3vhnxa-jb3e7&ms=au%2Crdu&mv=m&mvi=2&pcm2cms=yes&pl=22&initcwndbps=466250&spc=qEK7BzHFGDhAUMFviYvgZvY7qgrYdKA&vprv=1&svpuc=1&mime=video%2Fmp4&cnr=14&ratebypass=yes&dur=162.446&lmt=1683123574013709&mt=1684773185&fvip=5&fexp=24007246&c=ANDROID&txp=6218224&sparams=expire%2Cei%2Cip%2Cid%2Citag%2Csource%2Crequiressl%2Cspc%2Cvprv%2Csvpuc%2Cmime%2Ccnr%2Cratebypass%2Cdur%2Clmt&sig=AOq0QJ8wRAIgJ2AOYSx-qByFQpvSuLzgiNpL56WpmTJQep1Dmf_6argCIBDCGTJWTx_1R-DsZXIfRNpJIk8fYFK8DcL1aAybdO6E&lsparams=mh%2Cmm%2Cmn%2Cms%2Cmv%2Cmvi%2Cpcm2cms%2Cpl%2Cinitcwndbps&lsig=AG3C_xAwRgIhAJYhsUuGY3_07V2eKy0KZ9qNs_C5sbfE7aa2EoznuYHlAiEAnCieP_31eV0OXxuI_hp1KUas-KaT6RsjDfWjDB5qLpA%3D"
    };
  }

  String? get special_type {
    try {
      if (rawData["@type"] is String == false) {
        return null;
      }
      return rawData["@type"] as String;
    } catch (e) {
      return null;
    }
  }

  String? get audio_codec {
    try {
      if (rawData["audio_codec"] is String == false) {
        return null;
      }
      return rawData["audio_codec"] as String;
    } catch (e) {
      return null;
    }
  }

  int? get framerate {
    try {
      if (rawData["framerate"] is int == false) {
        return null;
      }
      return rawData["framerate"] as int;
    } catch (e) {
      return null;
    }
  }

  String? get video_codec {
    try {
      if (rawData["video_codec"] is String == false) {
        return null;
      }
      return rawData["video_codec"] as String;
    } catch (e) {
      return null;
    }
  }

  String? get video_quality {
    try {
      if (rawData["video_quality"] is String == false) {
        return null;
      }
      return rawData["video_quality"] as String;
    } catch (e) {
      return null;
    }
  }

  int? get height {
    try {
      if (rawData["height"] is int == false) {
        return null;
      }
      return rawData["height"] as int;
    } catch (e) {
      return null;
    }
  }

  int? get width {
    try {
      if (rawData["width"] is int == false) {
        return null;
      }
      return rawData["width"] as int;
    } catch (e) {
      return null;
    }
  }

  int? get bitrate {
    try {
      if (rawData["bitrate"] is int == false) {
        return null;
      }
      return rawData["bitrate"] as int;
    } catch (e) {
      return null;
    }
  }

  String? get mime_type {
    try {
      if (rawData["mime_type"] is String == false) {
        return null;
      }
      return rawData["mime_type"] as String;
    } catch (e) {
      return null;
    }
  }

  String? get container_name {
    try {
      if (rawData["container_name"] is String == false) {
        return null;
      }
      return rawData["container_name"] as String;
    } catch (e) {
      return null;
    }
  }

  bool? get is_throttled {
    try {
      if (rawData["is_throttled"] is bool == false) {
        return null;
      }
      return rawData["is_throttled"] as bool;
    } catch (e) {
      return null;
    }
  }

  String? get quality {
    try {
      if (rawData["quality"] is String == false) {
        return null;
      }
      return rawData["quality"] as String;
    } catch (e) {
      return null;
    }
  }

  int? get size {
    try {
      if (rawData["size"] is int == false) {
        return null;
      }
      return rawData["size"] as int;
    } catch (e) {
      return null;
    }
  }

  int? get tag {
    try {
      if (rawData["tag"] is int == false) {
        return null;
      }
      return rawData["tag"] as int;
    } catch (e) {
      return null;
    }
  }

  String? get video_from {
    try {
      if (rawData["video_from"] is String == false) {
        return null;
      }
      return rawData["video_from"] as String;
    } catch (e) {
      return null;
    }
  }

  String? get video_data {
    try {
      if (rawData["video_data"] is String == false) {
        return null;
      }
      return rawData["video_data"] as String;
    } catch (e) {
      return null;
    }
  }

  String? get url {
    try {
      if (rawData["url"] is String == false) {
        return null;
      }
      return rawData["url"] as String;
    } catch (e) {
      return null;
    }
  }

  static MediaDataManifest create({
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
    MediaDataManifest mediaDataManifest = MediaDataManifest({
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
