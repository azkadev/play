// ignore_for_file: unused_local_variable

import 'dart:convert';

import "package:play/play_dart.dart";
import 'package:galaxeus_lib/galaxeus_lib.dart';
import 'package:universal_io/io.dart';

void main(List<String> arguments) async {
  Args args = Args(arguments);
  String help_play = """
Play any audio and video on cli

Example:

play ./audio.mp3

""";

  print("slebew");
  Play play = Play(
    gui: false,
  );

  await play.open(
    medias: [
      // "/home/hexaminate/Documents/hexaminate/app/play/audio.mp3",
      "C:\Users\Glx\Downloads\K-Pop\video.mp4"
    ],
  );
  double volume = await play.player.streams.volume.first;
  play.player.streams.error.listen((event) {
    print(event.message);
  });
  play.player.streams.completed.listen(
    (event) {
      if (event) {
        exit(0);
      }
    },
    onDone: () {
      exit(0);
    },
  );
  stdin.listen(
    (event) {
      String command = utf8.decode(event).replaceAll(RegExp(r"\n$"), "");

      if (RegExp(r"^(volume (down|up))$", caseSensitive: false)
          .hashData(command)) {
        if (RegExp(r"^(volume (up))$", caseSensitive: false)
            .hashData(command)) {
          volume += 10;
          play.volume(volume);
        } else {
          volume -= 10;
          play.volume(volume);
        }
      }
    },
  );
}
