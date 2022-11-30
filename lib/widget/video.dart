part of play;

/// if you want tutorial please chek [Youtube](https://youtube.com/@azkadev)
class Video extends StatefulWidget {
  final int id;
  final VideoData videoData;
  final bool isAutoStart;
  final Widget Function(BuildContext context, Widget child, Video video,
      VideoState videoState, VideoController videoController) builder;
  Video({
    super.key,
    this.id = 0,
    this.isAutoStart = false,
    required this.videoData,
    required this.builder,
  });
  @override
  State<Video> createState() => VideoState();
}

/// if you want tutorial please chek [Youtube](https://youtube.com/@azkadev)
class VideoState extends State<Video> {
  late final VideoController videoController = VideoController(
    id: widget.id,
    isAutoStart: widget.isAutoStart,
  );

  late bool isInit = false;

  @override
  void initState() {
    super.initState();
    videoController.initialize(
      setState: setState,
      videoData: widget.videoData,
      onReady: (bool isReady) {
        isInit = isReady;
      },
    );
  }

  @override
  void dispose() {
    videoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (Platform.isWindows || Platform.isLinux) {
      return Visibility(
        visible: isInit,
        replacement: frame(Container()),
        child: frame(
          dart_vlc.Video(
            player: videoController.desktopPlayer,
            width: videoController.size.width,
            height: videoController.size.height,
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
          video_player.VideoPlayer(videoController.mobilePlayer),
        ),
      );
    }
  }

  Widget frame(Widget child) {
    return widget.builder(context, child, widget, this, videoController);
  }
}
