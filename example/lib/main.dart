// ignore_for_file: depend_on_referenced_packages

import 'dart:io';
import 'dart:math';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:play/play.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:miniplayer/miniplayer.dart';

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
        itemBuilder: (context, index) {
          return Video(
            id: index,
            file: File(files[index].path),
            videoViewBuilder: (Widget child, Video video, VideoState videoState) {
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
                                videoState.playOrPause();
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
                                stream: videoState.streamDurationPosition(),
                                builder: (BuildContext context, AsyncSnapshot snapshot) {
                                  return Slider(
                                    min: 0,
                                    max: videoState.getDurationMax().inMilliseconds.toDouble(),
                                    value: videoState.getDurationPosition().inMilliseconds.toDouble(),
                                    onChanged: (double value) {
                                      setState(() {
                                        videoState.seek(Duration(milliseconds: value.toInt()));
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
                file: File(path),
                videoViewBuilder: (Widget child, Video video, VideoState videoState) {
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
                                    videoState.playOrPause();
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
                                    stream: videoState.streamDurationPosition(),
                                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                                      return Slider(
                                        min: 0,
                                        max: videoState.getDurationMax().inMilliseconds.toDouble(),
                                        value: videoState.getDurationPosition().inMilliseconds.toDouble(),
                                        onChanged: (double value) {
                                          setState(() {
                                            videoState.seek(Duration(milliseconds: value.toInt()));
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
  AudioRaw player = AudioRaw();
  late StateData state_data = StateData(type: "music_page", isShuffle: false, isLoop: false);
  late Duration onChanged = const Duration();
  late Duration maxDuration = const Duration();
  late bool isPlay = false;
  List<FileSystemEntity> files = [];
  late int indexFiles = 0;
  @override
  Widget build(BuildContext context) {
    player.player.onPositionChanged.listen((Duration event) {
      setState(() {
        onChanged = event;
      });
    });
    player.player.onDurationChanged.listen((Duration d) async {
      setState(() {
        isPlay = true;
        maxDuration = d;
      });
    });
    player.player.onPlayerComplete.listen((event) async {
      if (state_data.isShuffle) {
        final random = Random();
        var element = random.nextInt(files.length);
        await playIndex(element);
      } else {
        if (state_data.isLoop) {
          await player.resume();
        } else {
          await playNext();
        }
      }
    });
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
            child: const Text("select directory music"),
          ),
        ),
      );
    }
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          ListView.builder(
            itemCount: files.length,
            itemBuilder: (ctx, index) {
              return ListTile(
                contentPadding: const EdgeInsets.all(15),
                onTap: () async {
                  await playIndex(index);
                },
                leading: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    color: Colors.yellow,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(1),
                        spreadRadius: 1,
                        blurRadius: 7,
                        offset: const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: const Center(
                    child: Text(
                      "s",
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
                title: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: Text(
                    files[index].path,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                subtitle: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 2),
                  child: Text("<unknown>"),
                ),
                trailing: InkWell(
                  onTap: () async {},
                  child: const Icon(Icons.menu),
                ),
              );
            },
          ),
          Miniplayer(
            minHeight: 70,
            maxHeight: MediaQuery.of(context).size.height,
            builder: (height, percentage) {
              if (height == 70) {
                return const Center();
              }
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * .5,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(Radius.circular(10)),
                          color: Colors.yellow,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(1),
                              spreadRadius: 1,
                              blurRadius: 7,
                              offset: const Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: const Center(
                          child: Text(
                            "s",
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ),
                    ),
                    ProgressBar(
                      progress: onChanged,
                      total: maxDuration,
                      onSeek: (Duration duration) async {
                        await player.player.seek(duration);
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () async {
                            setState(() {
                              state_data.isLoop = !state_data.isLoop;
                            });
                          },
                          child: Icon(
                            Icons.loop,
                            size: 50,
                            color: (state_data.isLoop) ? Colors.blue : Colors.black,
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            await playPrev();
                          },
                          child: const Icon(
                            Icons.arrow_left,
                            size: 50,
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            if (isPlay) {
                              setState(() {
                                isPlay = false;
                              });
                              await player.pause();
                            } else {
                              setState(() {
                                isPlay = true;
                              });
                              await player.resume();
                            }
                          },
                          child: Icon(
                            (isPlay) ? Icons.pause : Icons.play_circle_fill,
                            size: 50,
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            await playNext();
                          },
                          child: const Icon(
                            Icons.arrow_right,
                            size: 50,
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            setState(() {
                              state_data.isShuffle = !state_data.isShuffle;
                            });
                          },
                          child: Icon(
                            Icons.shuffle,
                            size: 50,
                            color: (state_data.isShuffle) ? Colors.blue : Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Future<void> playIndex(int index) async {
    if (files[index].existsSync()) {
      setState(() {
        indexFiles = index;
      });
      await player.play(DeviceFileSource(files[index].path));
    } else {
      setState(() {
        files.removeAt(index);
      });
    }
  }

  Future<void> playPrev() async {
    indexFiles--;
    if (indexFiles < 0) {
      indexFiles = files.length - 1;
    }

    await playIndex(indexFiles);
  }

  Future<void> playNext() async {
    indexFiles++;
    if (indexFiles >= files.length) {
      indexFiles = 0;
    }

    await playIndex(indexFiles);
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
