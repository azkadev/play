import 'package:media_kit/media_kit.dart';

void main() async {
  /// Create a new [Player] instance.
  final player = Player();

  /// Open some [Media] for playback.
  await player.open(
    Playlist(
      [
        // Media("/home/hexaminate/Downloads/Video/pagdito.mp4"),
        Media("http://0.0.0.0:4456/pagdito.mp4")
        // Media('file:///C:/Users/Hitesh/Video/Sample.MKV'),
        // Media('https://www.example.com/sample.mp4'),
        // Media('rtsp://www.example.com/live'),
      ],
    ),
  );

  await player.play();
  // await player.playOrPause();
}
