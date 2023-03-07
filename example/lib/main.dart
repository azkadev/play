// ignore_for_file: depend_on_referenced_packages

import "package:universal_io/io.dart";
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:play/play.dart';

void main() async {
  await playInitialize();
  return runApp(const MaterialApp(home: MainPage()));
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          children: [
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const MusicPage();
                    },
                  ),
                );
              },
              child: const Text("Music Pages"),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const VideoPages();
                    },
                  ),
                );
              },
              child: const Text("Video Pages"),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const MusicPage();
                    },
                  ),
                );
              },
              child: const Text("Music Page"),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const VideoPage();
                    },
                  ),
                );
              },
              child: const Text("Video Page"),
            ),
          ],
        ),
      ),
    );
  }
}

class VideoPages extends StatefulWidget {
  const VideoPages({super.key});

  @override
  State<VideoPages> createState() => _VideoPagesState();
}

class _VideoPagesState extends State<VideoPages> {
  List<FileSystemEntity> files = [];
  PageController pageController = PageController();
  late int index = 0;
  late bool isPlay = true;
  @override
  Widget build(BuildContext context) {
    if (files.isEmpty) {
      return Scaffold(
        body: Center(
          child: TextButton(
            onPressed: () async {
              String? dir = await FilePicker.platform.getDirectoryPath();
              if (dir != null) {
                var directory = Directory(dir);
                setState(() {
                  files = directory.listSync(recursive: true);
                });
              }
            },
            child: const Text("select directory video"),
          ),
        ),
      );
    }
    return Scaffold(
      body: PageView.builder(
        scrollDirection: Axis.vertical,
        itemCount: files.length,
        controller: pageController,
        onPageChanged: (value) {
          setState(() {
            index = value;
          });
        },
        itemBuilder: (context, i) {
          return Video(
            videoData: VideoData.file(file: File(files[i].path)),
            id: i,
            builder: (BuildContext context, Widget child, Video video, VideoState videoState, VideoController videoController) {
              if (index != i) {
                videoState.videoController.pause();
              } else {
                if (isPlay) {
                  videoState.videoController.play();
                } else {
                  videoState.videoController.pause();
                }
              }
              return Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: const BoxDecoration(
                  color: Colors.black,
                ),
                child: Stack(
                  fit: StackFit.passthrough,
                  children: [
                    Center(
                      child: AspectRatio(
                        aspectRatio: videoState.videoController.aspectRatio,
                        child: child,
                      ),
                    ),
                    Positioned(
                      bottom: 5,
                      left: 0,
                      right: 0,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 0),
                        child: Row(
                          children: [
                            InkWell(
                              onTap: () {
                                videoState.videoController.pause();
                                pageController.jumpToPage(i - 1);
                              },
                              child: const RotatedBox(
                                quarterTurns: 2,
                                child: Icon(
                                  Icons.skip_next,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                videoState.videoController.playOrPause();
                                setState(() {
                                  isPlay = !videoState.videoController.isPlaying;
                                });
                              },
                              child: Icon(
                                (isPlay) ? Icons.pause : Icons.play_arrow,
                                color: Colors.white,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                videoState.videoController.pause();

                                pageController.jumpToPage(i + 1);
                              },
                              child: const Icon(
                                Icons.skip_next,
                                color: Colors.white,
                              ),
                            ),
                            Expanded(
                              child: StreamBuilder(
                                stream: videoState.videoController.streamDurationPosition(),
                                builder: (BuildContext context, AsyncSnapshot snapshot) {
                                  return Slider(
                                    min: 0,
                                    max: videoState.videoController.getDurationMax().inMilliseconds.toDouble(),
                                    value: videoState.videoController.getDurationPosition().inMilliseconds.toDouble(),
                                    onChanged: (double value) {
                                      setState(() {
                                        videoState.videoController.seek(Duration(milliseconds: value.toInt()));
                                      });
                                    },
                                  );
                                },
                              ),
                            ),
                            InkWell(
                              onTap: () {},
                              child: const Icon(
                                Icons.fullscreen,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class VideoPage extends StatefulWidget {
  const VideoPage({Key? key}) : super(key: key);

  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  String path = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(
            onPressed: () async {
              setState(() {});
            },
            child: const Text("Refresh"),
          ),
          TextButton(
            onPressed: () async {
              FilePickerResult? filePickerResult = await FilePicker.platform.pickFiles();
              if (filePickerResult == null) {
                return;
              }
              setState(() {
                path = filePickerResult.files.first.path!;
              });
            },
            child: const Text("select video file"),
          ),
          Flexible(
            child: Visibility(
              visible: path.isNotEmpty,
              child: Video(
                videoData: VideoData.file(
                  file: File(path),
                ),
                builder: (BuildContext context, Widget child, Video video, VideoState videoState, VideoController videoController) {
                  return Container(
                    decoration: const BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    child: Stack(
                      fit: StackFit.passthrough,
                      children: [
                        child,
                        Positioned(
                          bottom: 5,
                          left: 0,
                          right: 0,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    videoState.videoController.playOrPause();
                                    videoState.setState(() {});
                                  },
                                  child: const Icon(
                                    Icons.pause,
                                    color: Colors.white,
                                  ),
                                ),
                                InkWell(
                                  onTap: () {},
                                  child: const Icon(
                                    Icons.skip_next,
                                    color: Colors.white,
                                  ),
                                ),
                                Expanded(
                                  child: StreamBuilder(
                                    stream: videoState.videoController.streamDurationPosition(),
                                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                                      return Slider(
                                        min: 0,
                                        max: videoState.videoController.getDurationMax().inMilliseconds.toDouble(),
                                        value: videoState.videoController.getDurationPosition().inMilliseconds.toDouble(),
                                        onChanged: (double value) {
                                          setState(() {
                                            videoState.videoController.seek(Duration(milliseconds: value.toInt()));
                                          });
                                        },
                                      );
                                    },
                                  ),
                                ),
                                InkWell(
                                  onTap: () {},
                                  child: const Icon(
                                    Icons.fullscreen,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MusicPage extends StatefulWidget {
  const MusicPage({Key? key}) : super(key: key);

  @override
  State<MusicPage> createState() => _MusicPageState();
}

class _MusicPageState extends State<MusicPage> {
  String path = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(
            onPressed: () async {
              setState(() {});
            },
            child: const Text("Refresh"),
          ),
          TextButton(
            onPressed: () async {
              FilePickerResult? filePickerResult = await FilePicker.platform.pickFiles();
              if (filePickerResult == null) {
                return;
              }
              setState(() {
                path = filePickerResult.files.first.path!;
              });
            },
            child: const Text("select music file"),
          ),
          Flexible(
            child: Visibility(
              visible: path.isNotEmpty,
              child: Audio(
                audioData: AudioData.file(
                  file: File(path),
                ),
                builder: (BuildContext context, Widget child, Audio audio, AudioState audioState, AudioController audioController) {
                  return Container(
                    decoration: const BoxDecoration(
                      color: Colors.black,
                    ),
                    child: Stack(
                      fit: StackFit.passthrough,
                      children: [
                        child,
                        Positioned(
                          bottom: 5,
                          left: 0,
                          right: 0,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    audioController.play();
                                    // videoState.videoController.playOrPause();
                                    // videoState.videoController.setState(() {});
                                  },
                                  child: const Icon(
                                    Icons.pause,
                                    color: Colors.white,
                                  ),
                                ),
                                InkWell(
                                  onTap: () {},
                                  child: const Icon(
                                    Icons.skip_next,
                                    color: Colors.white,
                                  ),
                                ),
                                // Expanded(
                                //   child: StreamBuilder(
                                //     stream: videoState.videoController.streamDurationPosition(),
                                //     builder: (BuildContext context, AsyncSnapshot snapshot) {
                                //       return Slider(
                                //         min: 0,
                                //         max: videoState.videoController.getDurationMax().inMilliseconds.toDouble(),
                                //         value: videoState.videoController.getDurationPosition().inMilliseconds.toDouble(),
                                //         onChanged: (double value) {
                                //           setState(() {
                                //             videoState.videoController.seek(Duration(milliseconds: value.toInt()));
                                //           });
                                //         },
                                //       );
                                //     },
                                //   ),
                                // ),
                                InkWell(
                                  onTap: () {},
                                  child: const Icon(
                                    Icons.fullscreen,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class StateData {
  late String type = "";
  late bool isShuffle = false;
  late bool isLoop = false;
  StateData({
    required this.type,
    required this.isShuffle,
    required this.isLoop,
  });
}
