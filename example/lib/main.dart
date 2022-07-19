// ignore_for_file: depend_on_referenced_packages

import 'dart:io';
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
  final player = Audio();
  late Duration onChanged = Duration();
  late Duration maxDuration = Duration();
  List<FileSystemEntity> files = [];
  late int indexFiles = 0;
  @override
  Widget build(BuildContext context) {
    player.player.onPositionChanged.listen((Duration event) {
      setState(() {
        onChanged = event;
      });
    });
    player.player.onDurationChanged.listen((Duration d) {
      print('Max duration: $d');
      setState(() {
        maxDuration = d;
      });
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
        children: [
          ListView.builder(
            itemCount: files.length,
            itemBuilder: (ctx, index) {
              return ListTile(
                contentPadding: EdgeInsets.all(15),
                onTap: () async {
                  if (files[index].existsSync()) {
                    await player.play(DeviceFileSource(files[index].path));
                    setState(() {
                      indexFiles = index;
                    });
                  } else {
                    setState(() {
                      files.removeAt(index);
                    });
                  }
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ProgressBar(
                      progress: onChanged,
                      total: maxDuration,
                      onSeek: (Duration duration) async {
                        print(duration);

                        await player.player.seek(duration);
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () async {
                            try {
                              indexFiles--;
                              if (indexFiles < 0) {
                                indexFiles = files.length - 1;
                              }
                              if (files[indexFiles] != null) {
                                if (files[indexFiles].existsSync()) {
                                  await player.play(DeviceFileSource(files[indexFiles].path));
                                  setState(() {
                                    indexFiles = indexFiles;
                                  });
                                } else {
                                  setState(() {
                                    files.removeAt(indexFiles);
                                  });
                                }
                              } else {
                                indexFiles = files.length - 1;
                                if (files[indexFiles].existsSync()) {
                                  await player.play(DeviceFileSource(files[indexFiles].path));
                                  setState(() {
                                    indexFiles = indexFiles;
                                  });
                                } else {
                                  setState(() {
                                    files.removeAt(indexFiles);
                                  });
                                }
                              }
                            } catch (e) {
                              print(e);
                            }
                          },
                          child: Text("prev"),
                        ),
                        TextButton(
                          onPressed: () async {
                            await player.pause(); // will resume from beginning
                          },
                          child: Text("pause"),
                        ),
                        TextButton(
                          onPressed: () async {
                            await player.resume(); // will resume from beginning
                          },
                          child: Text("resum"),
                        ),
                        TextButton(
                          onPressed: () async {
                            try {
                              indexFiles++;
                              if (indexFiles >= files.length) {
                                indexFiles = 0;
                              }
                              if (files[indexFiles] != null) {
                                if (files[indexFiles].existsSync()) {
                                  await player.play(DeviceFileSource(files[indexFiles].path));
                                  setState(() {
                                    indexFiles = indexFiles;
                                  });
                                } else {
                                  setState(() {
                                    files.removeAt(indexFiles);
                                  });
                                }
                              } else {
                                indexFiles = 0;
                                if (files[indexFiles].existsSync()) {
                                  await player.play(DeviceFileSource(files[indexFiles].path));
                                  setState(() {
                                    indexFiles = indexFiles;
                                  });
                                } else {
                                  setState(() {
                                    files.removeAt(indexFiles);
                                  });
                                }
                              }
                            } catch (e) {
                              print(e);
                            }
                          },
                          child: Text("next"),
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
}
