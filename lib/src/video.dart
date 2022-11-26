part of play;

class Video extends StatefulWidget {
  final int id;
  final File file;
  final Widget Function(Widget child, Video video, VideoState videoState) videoViewBuilder;
  Video({
    super.key,
    this.id = 0,
    required this.file,
    required this.videoViewBuilder,
  });

  @override
  State<Video> createState() => VideoState();
}

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
    print("dispose");
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
        desktopPlayer = dart_vlc.Player(id: widget.id, videoDimensions: const dart_vlc.VideoDimensions(640, 460), registerTexture: !Platform.isWindows);
      });
      isInit = true;
      desktopPlayer.open(
        dart_vlc.Playlist(
          medias: [
            dart_vlc.Media.file(widget.file),
          ],
          playlistMode: dart_vlc.PlaylistMode.single,
        ),
        autoStart: false,
      );
    } else if (Platform.isAndroid || Platform.isIOS) {
      setState(() {
        mobilePlayer = video_player.VideoPlayerController.file(widget.file);
      });
      await mobilePlayer.initialize();
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
      (mobilePlayer.value.isPlaying == true) ? mobilePlayer.pause() : mobilePlayer.play();
    }
  }

  get isPlaying {
    if (Platform.isWindows || Platform.isLinux) {
    } else {
      return mobilePlayer.value.isPlaying;
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
            width: desktopPlayer.videoDimensions.width.toDouble(),
            height: desktopPlayer.videoDimensions.height.toDouble(),
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
          AspectRatio(
            aspectRatio: mobilePlayer.value.aspectRatio,
            child: video_player.VideoPlayer(mobilePlayer),
          ),
        ),
      );
    }
  }

  Widget frame(Widget child) {
    return widget.videoViewBuilder(child, widget, this);
  }
}
