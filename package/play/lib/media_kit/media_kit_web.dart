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

  PlayerState get state {
    return PlayerState();
  }

  PlayerStreams get streams {
    return PlayerStreams();
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
  static void ensureInitialized({String? libmpv}) {}
}

class PlayerState {
  Duration get duration {
    return Duration();
  }
  Duration get position {
    return Duration();
  }
}

class PlayerStreams {
  Duration get duration {
    return Duration();
  }
  Stream<Duration> get position {
    return Future(() => Duration()).asStream();
  }
}
