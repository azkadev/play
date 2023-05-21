library play_dart;

import 'package:media_kit/media_kit.dart';
import "play_core.dart" as play_core;

class Play {
  late Player player;
  Play({
    bool events = true,
    bool osc = false,
    bool gui = false,
    String? vo,
    bool pitch = false,
    String? libmpv,
    String? title,
    void Function()? ready,
  }) {
    play_core.Play.ensureInitialized();
    player = Player(
      configuration: PlayerConfiguration(
        // events: events,
        osc: osc,
        vid: gui,
        vo: vo,
        pitch: pitch,
        // libmpv: libmpv,
        title: title,
        ready: ready,
      ),
    );
  }

  Future<void> open({
    required List<String> medias,
    bool play = true,
    bool evictCache = true,
  }) async {
    await player.open(
      Playlist(
        medias.map((e) => Media(e)).toList().cast<Media>(),
      ),
      play: play,
      // evictExtrasCache: evictCache,
    );
    return;
  }

  Future<void> template() async {
    await player.play();
    return;
  }

  Future<void> play() async {
    await player.play();
    return;
  }

  Future<void> playOrPause() async {
    await player.playOrPause();
    return;
  }

  Future<void> seek(Duration duration) async {
    await player.seek(duration);
    return;
  }

  Future<void> remove(int index) async {
    await player.remove(index);
    return;
  }

  Future<void> pause() async {
    await player.pause();
    return;
  }

  Future<void> previous() async {
    await player.previous();
    return;
  }

  Future<void> next() async {
    await player.next();
    return;
  }

  Future<void> move(int from, int to) async {
    await player.move(from, to);
    return;
  }

  Future<void> jump(int index, {bool open = false}) async {
    await player.jump(index);
    return;
  }

  Future<void> add(String media) async {
    await player.add(Media(media));
    return;
  }

  void volume(double volum) {
    player.setVolume(volum);
    return;
  }

  void shuffle(bool shuffle) {
    player.setShuffle(shuffle);

    return;
  }

  void rate(double rate) {
    player.setRate(rate);
    return;
  }

  void pitch(double pitch) {
    player.setPitch(pitch);
    return;
  }
}
