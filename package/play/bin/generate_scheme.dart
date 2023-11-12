import 'dart:io';

import 'package:general_lib/general_lib.dart';
import "package:path/path.dart" as path;

void main(List<String> args) async {
  Directory directory =
      Directory(path.join(Directory.current.path, "lib", "scheme"));
  List<Map> datas = [
    {
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
          "https://rr2---sn-uxa3vhnxa-q2nl.googlevideo.com/videoplayback?expire=1684795192&ei=2JprZIGKEYaowgOzxo6gBQ&ip=114.125.93.164&id=o-AOk45c2RfQrDpEFD3V0gLdOj8k0wL_iwvVgTXyUlyUKh&itag=22&source=youtube&requiressl=yes&mh=lX&mm=31%2C29&mn=sn-uxa3vhnxa-q2nl%2Csn-uxa3vhnxa-jb3e7&ms=au%2Crdu&mv=m&mvi=2&pcm2cms=yes&pl=22&initcwndbps=466250&spc=qEK7BzHFGDhAUMFviYvgZvY7qgrYdKA&vprv=1&svpuc=1&mime=video%2Fmp4&cnr=14&ratebypass=yes&dur=162.446&lmt=1683123574013709&mt=1684773185&fvip=5&fexp=24007246&c=ANDROID&txp=6218224&sparams=expire%2Cei%2Cip%2Cid%2Citag%2Csource%2Crequiressl%2Cspc%2Cvprv%2Csvpuc%2Cmime%2Ccnr%2Cratebypass%2Cdur%2Clmt&sig=AOq0QJ8wRAIgJ2AOYSx-qByFQpvSuLzgiNpL56WpmTJQep1Dmf_6argCIBDCGTJWTx_1R-DsZXIfRNpJIk8fYFK8DcL1aAybdO6E&lsparams=mh%2Cmm%2Cmn%2Cms%2Cmv%2Cmvi%2Cpcm2cms%2Cpl%2Cinitcwndbps&lsig=AG3C_xAwRgIhAJYhsUuGY3_07V2eKy0KZ9qNs_C5sbfE7aa2EoznuYHlAiEAnCieP_31eV0OXxuI_hp1KUas-KaT6RsjDfWjDB5qLpA%3D",
    },
  ];

  await jsonToScripts(datas, directory: directory);
}
