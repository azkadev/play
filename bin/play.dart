import "package:play/play_dart.dart";

void main() async {
  Play play = Play(
    gui: false,
  );

  await play.open(medias: ["/home/hexaminate/Documents/hexaminate/app/play/audio.mp3"]);
 
  await Future.delayed(Duration(seconds: 10));
  await play.pause();
}
