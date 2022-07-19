// ignore_for_file: depend_on_referenced_packages

import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:play/play.dart';
import 'package:simulate/simulate.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:miniplayer/miniplayer.dart';

void main() {
  return runSimulate(home: MainPage());
}

class MainPage extends StatefulWidget {
  MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return ScaffoldSimulate(
      body: Center(
        child: Row(
          children: [
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return MusicPage();
                    },
                  ),
                );
              },
              child: Text("Music Page"),
            ),
          ],
        ),
      ),
    );
  }
}

class MusicPage extends StatefulWidget {
  MusicPage({Key? key}) : super(key: key);

  @override
  State<MusicPage> createState() => _MusicPageState();
}

class _MusicPageState extends State<MusicPage> {
  Audio player = Audio();
  late StateData state_data = StateData(type: "music_page", isShuffle: false, isLoop: false);
  late Duration onChanged = Duration();
  late Duration maxDuration = Duration();
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
        final _random = Random();
        var element = _random.nextInt(files.length);
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
      return ScaffoldSimulate(
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
            child: Text("select directory music"),
          ),
        ),
      );
    }
    return ScaffoldSimulate(
      body: Stack(
        fit: StackFit.expand,
        children: [
          ListView.builder(
            itemCount: files.length,
            itemBuilder: (ctx, index) {
              return ListTile(
                contentPadding: EdgeInsets.all(15),
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
                  child: Center(
                    child: Text(
                      "s",
                      style: const TextStyle(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
                title: Padding(
                  padding: EdgeInsets.symmetric(vertical: 2),
                  child: Text(
                    files[index].path,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                subtitle: Padding(
                  padding: EdgeInsets.symmetric(vertical: 2),
                  child: Text("<unknown>"),
                ),
                trailing: InkWell(
                  onTap: () async {},
                  child: Icon(Icons.menu),
                ),
              );
            },
          ),
          Miniplayer(
            minHeight: 70,
            maxHeight: MediaQuery.of(context).size.height,
            builder: (height, percentage) {
              if (height == 70) {
                return Center();
              }
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 2, horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
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
                        child: Center(
                          child: Text(
                            "s",
                            style: const TextStyle(
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
                          child: Icon(
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
                          child: Icon(
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
