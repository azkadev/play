library play;

import 'package:universal_io/io.dart';
import 'package:dart_vlc/dart_vlc.dart'
    if (dart.library.html) 'dart_vlc/web.dart' as dart_vlc;
export 'src/progress_bar.dart';
export "src/audio.dart";
export "src/media.dart";
export "widget/audio.dart";
export "widget/media.dart";
export "widget/video.dart";

/// ganti ke ini ya makasi
///  ```dart
///  Play.init();
///  ```
@Deprecated("""silahkan menggunakan code ini ya""")
void playInitialize() {
  if (Platform.isWindows || Platform.isLinux) {
    dart_vlc.DartVLC.initialize();
  }
}

class Play {
  static init() {
    if (Platform.isWindows || Platform.isLinux) {
      dart_vlc.DartVLC.initialize();
    }
  }
}
