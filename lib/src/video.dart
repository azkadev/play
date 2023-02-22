part of play;

/// if you want tutorial please check [Youtube](https://youtube.com/@azkadev)
enum VideoFromType {
  asset,
  file,
  network,
}

/// if you want tutorial please check [Youtube](https://youtube.com/@azkadev)
class VideoData {
  final VideoFromType videoFromType;
  final String path;

  /// if you want tutorial please check [Youtube](https://youtube.com/@azkadev)
  VideoData({
    required this.videoFromType,
    required this.path,
  });

  /// if you want tutorial please check [Youtube](https://youtube.com/@azkadev)
  factory VideoData.asset({
    required String path,
  }) {
    return VideoData(
      path: path,
      videoFromType: VideoFromType.asset,
    );
  }

  /// if you want tutorial please check [Youtube](https://youtube.com/@azkadev)
  factory VideoData.file({
    required File file,
  }) {
    return VideoData(
      path: file.path,
      videoFromType: VideoFromType.file,
    );
  }

  /// if you want tutorial please check [Youtube](https://youtube.com/@azkadev)
  factory VideoData.network({
    required String url,
  }) {
    return VideoData(
      path: url,
      videoFromType: VideoFromType.network,
    );
  }
}

/// if you want tutorial please check [Youtube](https://youtube.com/@azkadev)
class VideoController {
  late dart_vlc.Player desktopPlayer;
  late video_player.VideoPlayerController mobilePlayer;
  final int id;
  final bool isAutoStart;

  /// if you want tutorial please check [Youtube](https://youtube.com/@azkadev)
  VideoController({
    this.id = 0,
    this.isAutoStart = false,
  });

  /// if you want tutorial please check [Youtube](https://youtube.com/@azkadev)
  void dispose() {
    if (Platform.isWindows || Platform.isLinux) {
      desktopPlayer.dispose();
    } else {
      mobilePlayer.dispose();
    }
  }

  /// if you want tutorial please check [Youtube](https://youtube.com/@azkadev)
  Future<void> initialize(
      {required void Function(void Function() callback) setState,
      required VideoData videoData,
      required void Function(bool isInit) onReady}) async {
    if (Platform.isWindows || Platform.isLinux) {
      setState(() {
        desktopPlayer = dart_vlc.Player(
          id: id,
        );
      });
      onReady.call(true);
      setState(() {});
      if (videoData.videoFromType == VideoFromType.asset) {
        desktopPlayer.open(
          dart_vlc.Playlist(
            medias: [
              dart_vlc.Media.asset(videoData.path),
            ],
          ),
          autoStart: isAutoStart,
        );
      } else if (videoData.videoFromType == VideoFromType.file) {
        desktopPlayer.open(
          dart_vlc.Playlist(
            medias: [
              dart_vlc.Media.file(File(videoData.path)),
            ],
          ),
          autoStart: isAutoStart,
        );
      } else if (videoData.videoFromType == VideoFromType.network) {
        desktopPlayer.open(
          dart_vlc.Playlist(
            medias: [
              dart_vlc.Media.network(videoData.path),
            ],
          ),
          autoStart: isAutoStart,
        );
      }
    } else if (Platform.isAndroid || Platform.isIOS) {
      if (videoData.videoFromType == VideoFromType.asset) {
        setState(() {
          mobilePlayer = video_player.VideoPlayerController.asset(videoData.path);
        });
      } else if (videoData.videoFromType == VideoFromType.file) {
        setState(() {
          mobilePlayer = video_player.VideoPlayerController.file(File(videoData.path));
        });
      } else if (videoData.videoFromType == VideoFromType.network) {
        setState(() {
          mobilePlayer = video_player.VideoPlayerController.network(videoData.path);
        });
      }
      await mobilePlayer.initialize();
      if (isAutoStart) {
        await mobilePlayer.play();
      }
      setState(() {});
      onReady.call(true);
      setState(() {});
      mobilePlayer.addListener(() {
        setState(() {});
      });
    }
  }

  /// if you want tutorial please check [Youtube](https://youtube.com/@azkadev)
  void playFromFile(File file) {
    if (Platform.isWindows || Platform.isLinux) {
      desktopPlayer.open(
        dart_vlc.Playlist(
          medias: [
            dart_vlc.Media.file(file),
          ],
        ),
      );
    }
  }

  /// if you want tutorial please check [Youtube](https://youtube.com/@azkadev)
  FutureOr<bool> openNetwork(String url) async {
    if (Platform.isWindows || Platform.isLinux) {
      desktopPlayer.open(
        dart_vlc.Playlist(
          medias: [
            dart_vlc.Media.network(url),
          ],
        ),
      );
    } else if (Platform.isAndroid || Platform.isIOS) {
      mobilePlayer = video_player.VideoPlayerController.network(url);
      await mobilePlayer.initialize();
    }
    return false;
  }

  /// if you want tutorial please check [Youtube](https://youtube.com/@azkadev)
  FutureOr<bool> openFile(File file) async {
    if (Platform.isWindows || Platform.isLinux) {
      desktopPlayer.open(
        dart_vlc.Playlist(
          medias: [
            dart_vlc.Media.file(file),
          ],
          // playlistMode: dart_vlc.PlaylistMode.single,
        ),
      );
    } else if (Platform.isAndroid || Platform.isIOS) {
      mobilePlayer = video_player.VideoPlayerController.file(file);
      await mobilePlayer.initialize();
    }
    return false;
  }

  /// if you want tutorial please check [Youtube](https://youtube.com/@azkadev)
  Duration getDurationMax() {
    if (Platform.isWindows || Platform.isLinux) {
      return desktopPlayer.position.duration ?? Duration();
    } else {
      return mobilePlayer.value.duration;
    }
  }

  /// if you want tutorial please check [Youtube](https://youtube.com/@azkadev)
  Duration getDurationPosition() {
    if (Platform.isWindows || Platform.isLinux) {
      return desktopPlayer.position.position ?? Duration();
    } else {
      return mobilePlayer.value.position;
    }
  }

  /// if you want tutorial please check [Youtube](https://youtube.com/@azkadev)
  Stream? streamDurationPosition() {
    if (Platform.isWindows || Platform.isLinux) {
      return desktopPlayer.positionStream;
    } else if (Platform.isAndroid || Platform.isIOS) {}
    return Stream.value("ok");
  }

  /// if you want tutorial please check [Youtube](https://youtube.com/@azkadev)
  seek(Duration duration) {
    if (Platform.isWindows || Platform.isLinux) {
      desktopPlayer.seek(duration);
    } else {
      mobilePlayer.seekTo(duration);
    }
  }

  /// if you want tutorial please check [Youtube](https://youtube.com/@azkadev)
  void playOrPause() {
    if (Platform.isWindows || Platform.isLinux) {
      desktopPlayer.playOrPause();
    } else {
      (mobilePlayer.value.isPlaying == true) ? mobilePlayer.pause() : mobilePlayer.play();
    }
  }

  /// if you want tutorial please check [Youtube](https://youtube.com/@azkadev)
  bool get isPlaying {
    if (Platform.isWindows || Platform.isLinux) {
      return desktopPlayer.playback.isPlaying;
    } else {
      return mobilePlayer.value.isPlaying;
    }
  }

  /// if you want tutorial please check [Youtube](https://youtube.com/@azkadev)
  void play() {
    if (Platform.isWindows || Platform.isLinux) {
      desktopPlayer.play();
    } else {
      mobilePlayer.play();
    }
  }

  /// if you want tutorial please check [Youtube](https://youtube.com/@azkadev)
  void pause() {
    if (Platform.isWindows || Platform.isLinux) {
      desktopPlayer.pause();
    } else {
      mobilePlayer.pause();
    }
  }

  /// if you want tutorial please check [Youtube](https://youtube.com/@azkadev)
  Size get size {
    if (Platform.isWindows || Platform.isLinux) {
      return Size(desktopPlayer.videoDimensions.width.toDouble(),
          desktopPlayer.videoDimensions.height.toDouble());
    } else {
      return mobilePlayer.value.size;
    }
  }

  /// if you want tutorial please check [Youtube](https://youtube.com/@azkadev)
  double get aspectRatio {
    if (Platform.isWindows || Platform.isLinux) {
      if (size.width == 0 || size.height == 0) {
        return 1.0;
      }
      final double aspectRatios = size.width / size.height;
      if (aspectRatios <= 0) {
        return 1.0;
      }
      return aspectRatios;
    } else {
      return mobilePlayer.value.aspectRatio;
    }
  }

  /// if you want tutorial please check [Youtube](https://youtube.com/@azkadev)
  void setPlaybackSpeed(double speed) {
    if (Platform.isWindows || Platform.isLinux) {
      desktopPlayer.setRate(speed);
    } else {
      mobilePlayer.setPlaybackSpeed(speed);
    }
  }

  /// if you want tutorial please check [Youtube](https://youtube.com/@azkadev)
  void setVolume(double volume) {
    if (Platform.isWindows || Platform.isLinux) {
      desktopPlayer.setVolume(volume);
    } else {
      mobilePlayer.setVolume(volume);
    }
  }
}
