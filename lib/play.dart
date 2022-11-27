library play;

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:universal_io/io.dart';
import 'package:dart_vlc/dart_vlc.dart' as dart_vlc;
import "package:video_player/video_player.dart" as video_player;
export 'src/audio.dart';
export 'src/progress_bar.dart';
part 'src/video.dart';

/// init library for desktop
Future<void> playInitialize() async {
  if (Platform.isWindows || Platform.isLinux) {
    await dart_vlc.DartVLC.initialize(useFlutterNativeView: true);
  }
}
