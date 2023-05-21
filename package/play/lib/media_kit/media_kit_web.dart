class Player {
  Player();

  open(
    Playlist playlist, {
    bool play = false,
  }) {}
  dispose() {}

  Future<int> get handle async {
    return 0;
  }

  seek(Duration) async {}
  pause() async {}
  play() async {}
  playOrPause() async {}
}

class Playlist {
  Playlist(List medias);
}

class Media {
  Media(String path);
}


class MediaKit {
  
  static void ensureInitialized({String? libmpv}) {
    
  }
}