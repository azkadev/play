part of play;

/// if you want tutorial please chek [Youtube](https://youtube.com/@azkadev)
class Video extends StatefulWidget {
  final int id;
  final VideoData videoData;
  final bool isAutoStart;
  final Widget Function(BuildContext context, Widget child, Video video,
      VideoState videoState) videoViewBuilder;
  Video({
    super.key,
    this.id = 0,
    this.isAutoStart = false,
    required this.videoData,
    required this.videoViewBuilder,
  });

  @override
  State<Video> createState() => VideoState();
}

/// if you want tutorial please chek [Youtube](https://youtube.com/@azkadev)
class VideoState extends State<Video> {
  late dart_vlc.Player desktopPlayer;
  late video_player.VideoPlayerController mobilePlayer;
  late bool isInit = false;

  @override
  void initState() {
    super.initState();
    initialize();
  }

  @override
  void dispose() {
    if (Platform.isWindows || Platform.isLinux) {
      desktopPlayer.dispose();
    } else {
      mobilePlayer.dispose();
    }
    super.dispose();
  }

  Future<void> initialize() async {
    if (Platform.isWindows || Platform.isLinux) {
      setState(() {
        desktopPlayer = dart_vlc.Player(
            id: widget.id, registerTexture: !Platform.isWindows);
      });
      isInit = true;
      setState(() {});
      if (widget.videoData.videoFromType == VideoFromType.asset) {
        desktopPlayer.open(
          dart_vlc.Playlist(
            medias: [
              dart_vlc.Media.asset(widget.videoData.path),
            ],
            playlistMode: dart_vlc.PlaylistMode.single,
          ),
          autoStart: widget.isAutoStart,
        );
      } else if (widget.videoData.videoFromType == VideoFromType.file) {
        desktopPlayer.open(
          dart_vlc.Playlist(
            medias: [
              dart_vlc.Media.file(File(widget.videoData.path)),
            ],
            playlistMode: dart_vlc.PlaylistMode.single,
          ),
          autoStart: widget.isAutoStart,
        );
      } else if (widget.videoData.videoFromType == VideoFromType.network) {
        desktopPlayer.open(
          dart_vlc.Playlist(
            medias: [
              dart_vlc.Media.network(widget.videoData.path),
            ],
            playlistMode: dart_vlc.PlaylistMode.single,
          ),
          autoStart: widget.isAutoStart,
        );
      }
    } else if (Platform.isAndroid || Platform.isIOS) {
      if (widget.videoData.videoFromType == VideoFromType.asset) {
        setState(() {
          mobilePlayer =
              video_player.VideoPlayerController.asset(widget.videoData.path);
        });
      } else if (widget.videoData.videoFromType == VideoFromType.file) {
        setState(() {
          mobilePlayer = video_player.VideoPlayerController.file(
              File(widget.videoData.path));
        });
      } else if (widget.videoData.videoFromType == VideoFromType.network) {
        setState(() {
          mobilePlayer =
              video_player.VideoPlayerController.network(widget.videoData.path);
        });
      }
      await mobilePlayer.initialize();
      if (widget.isAutoStart) {
        await mobilePlayer.play();
      }
      setState(() {});
      isInit = true;
      setState(() {});
      mobilePlayer.addListener(() {
        setState(() {});
      });
    }
  }

  void playFromFile(File file) {
    if (Platform.isWindows || Platform.isLinux) {
      desktopPlayer.open(
        dart_vlc.Playlist(
          medias: [
            dart_vlc.Media.file(file),
          ],
          playlistMode: dart_vlc.PlaylistMode.single,
        ),
      );
    }
  }

  FutureOr<bool> openNetwork(String url) async {
    if (Platform.isWindows || Platform.isLinux) {
      desktopPlayer.open(
        dart_vlc.Playlist(
          medias: [
            dart_vlc.Media.network(url),
          ],
          playlistMode: dart_vlc.PlaylistMode.single,
        ),
      );
    } else if (Platform.isAndroid || Platform.isIOS) {
      mobilePlayer = video_player.VideoPlayerController.network(url);
      await mobilePlayer.initialize();
    }
    return false;
  }

  FutureOr<bool> openFile(File file) async {
    if (Platform.isWindows || Platform.isLinux) {
      desktopPlayer.open(
        dart_vlc.Playlist(
          medias: [
            dart_vlc.Media.file(file),
          ],
          playlistMode: dart_vlc.PlaylistMode.single,
        ),
      );
    } else if (Platform.isAndroid || Platform.isIOS) {
      mobilePlayer = video_player.VideoPlayerController.file(file);
      await mobilePlayer.initialize();
    }
    return false;
  }

  Duration getDurationMax() {
    if (Platform.isWindows || Platform.isLinux) {
      return desktopPlayer.position.duration ?? Duration();
    } else {
      return mobilePlayer.value.duration;
    }
  }

  Duration getDurationPosition() {
    if (Platform.isWindows || Platform.isLinux) {
      return desktopPlayer.position.position ?? Duration();
    } else {
      return mobilePlayer.value.position;
    }
  }

  Stream? streamDurationPosition() {
    if (Platform.isWindows || Platform.isLinux) {
      return desktopPlayer.positionStream;
    } else if (Platform.isAndroid || Platform.isIOS) {}
    return Stream.value("ok");
  }

  seek(Duration duration) {
    if (Platform.isWindows || Platform.isLinux) {
      desktopPlayer.seek(duration);
    } else {
      mobilePlayer.seekTo(duration);
    }
  }

  void playOrPause() {
    if (Platform.isWindows || Platform.isLinux) {
      desktopPlayer.playOrPause();
    } else {
      (mobilePlayer.value.isPlaying == true)
          ? mobilePlayer.pause()
          : mobilePlayer.play();
    }
  }

  bool get isPlaying {
    if (Platform.isWindows || Platform.isLinux) {
      return desktopPlayer.playback.isPlaying;
    } else {
      return mobilePlayer.value.isPlaying;
    }
  }

  void play() {
    if (Platform.isWindows || Platform.isLinux) {
      desktopPlayer.play();
    } else {
      mobilePlayer.play();
    }
  }

  void pause() {
    if (Platform.isWindows || Platform.isLinux) {
      desktopPlayer.pause();
    } else {
      mobilePlayer.pause();
    }
  }

  Size get size {
    if (Platform.isWindows || Platform.isLinux) {
      return Size(desktopPlayer.videoDimensions.width.toDouble(),
          desktopPlayer.videoDimensions.height.toDouble());
    } else {
      return mobilePlayer.value.size;
    }
  }

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

  void setPlaybackSpeed(double speed) {
    if (Platform.isWindows || Platform.isLinux) {
      desktopPlayer.setRate(speed);
    } else {
      mobilePlayer.setPlaybackSpeed(speed);
    }
  }

  void setVolume(double volume) {
    if (Platform.isWindows || Platform.isLinux) {
      desktopPlayer.setVolume(volume);
    } else {
      mobilePlayer.setVolume(volume);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (Platform.isWindows || Platform.isLinux) {
      return Visibility(
        visible: isInit,
        replacement: frame(Container()),
        child: frame(
          dart_vlc.Video(
            player: desktopPlayer,
            width: size.width,
            height: size.height,
            volumeThumbColor: Colors.blue,
            volumeActiveColor: Colors.blue,
            showControls: false,
            showFullscreenButton: true,
            showTimeLeft: true,
            fillColor: Colors.black,
          ),
        ),
      );
    } else {
      return Visibility(
        visible: isInit,
        replacement: frame(Container()),
        child: frame(
          video_player.VideoPlayer(mobilePlayer),
        ),
      );
    }
  }

  Widget frame(Widget child) {
    return widget.videoViewBuilder(context, child, widget, this);
  }
}
