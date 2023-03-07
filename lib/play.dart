library play;

import 'dart:async'; 
import 'package:flutter/material.dart';
import 'package:universal_io/io.dart';
import 'package:dart_vlc/dart_vlc.dart' if (dart.library.html) 'dart_vlc/web.dart' as dart_vlc;
// import  'dart_vlc/web.dart' as dart_vlc; 

import 'package:audioplayers/audioplayers.dart' as audio_player;

export 'src/progress_bar.dart';
export "src/video.dart" if (dart.library.html)  "src/video_web.dart";

export "widget/video.dart";

part "src/audio.dart";
// part 'src/video.dart';
part "widget/audio.dart";

/// init library for desktop
Future<void> playInitialize() async {
  if (Platform.isWindows || Platform.isLinux) {
    dart_vlc.DartVLC.initialize();
    
  }
}
