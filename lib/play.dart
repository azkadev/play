library play;

import 'dart:async';
import 'package:universal_io/io.dart';
import 'package:dart_vlc/dart_vlc.dart' if (dart.library.html) 'dart_vlc/web.dart' as dart_vlc;
export 'src/progress_bar.dart';
export "src/audio.dart";
export "src/video.dart" if (dart.library.html) "src/video_web.dart";
export "widget/video.dart";
export "widget/audio.dart";

/// init library for desktop
Future<void> playInitialize() async {
  if (Platform.isWindows || Platform.isLinux) {
    dart_vlc.DartVLC.initialize();
  }
}
