# Play library
<p align="center">
  <img src="https://user-images.githubusercontent.com/82513502/173231252-9d9b1090-edf4-474d-9837-831a66277145.png" width="350px">
</p>
<h2 align="center">Fast, Enjoyable & Customizable Play library</h2>

[![Pub Version](https://img.shields.io/pub/v/play?label=pub.dev&labelColor=333940&logo=dart)](https://pub.dev/packages/play)

Play dart library to make application video and audio

## Features

- 🚀 Cross platform: mobile, desktop, browser
- ⚡ Great performance
- ❤️ Simple, powerful, & intuitive API

---

## Install Library
```bash
dart pub add play
```

```bash
flutter pub add play
```

- [Doc + Example](https://github.com/azkadev/play/tree/main/dart/play/doc)
- [Youtube-Tutorial](https://youtube.com/c/hexaminate)

## Quickstart

```dart
// ignore_for_file: unused_local_variable, duplicate_ignore

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:play/play.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: true,
      title: "Azka Dev",
      home: App(),
    ),
  );
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);
  @override
  MyApp createState() => MyApp();
}

class MyApp extends State<App> {
  VideoController controllerVideo = VideoController();
  AudioController controllerAudio = AudioController();
  @override
  void initState() {
    super.initState();
  }

  @override
  // ignore: duplicate_ignore, duplicate_ignore
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    // ignore: unused_local_variable
    final getHeight = mediaQuery.size.height;
    final getWidth = mediaQuery.size.width;
    return MaterialApp(
      debugShowCheckedModeBanner: true,
      title: "Home",
      home: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Video.assets(
                "/home/azkadev/Videos/video.mp4",
                controller: controllerVideo,
                callback: (UpdateVideo res) {
                  var update = res.raw;
                  if (update is Map) {
                    if (update["@type"] == "video") {}
                  }
                },
                onTap: () {
                  controllerVideo.play;
                },
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Image.asset("/path/thumnail"),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(10),
              child: Audio.assets(
                "/home/azkadev/Music/audio.mp3",
                controller: controllerAudio,
                callback: (UpdateAudio res) {
                  var update = res.raw;
                  if (update is Map) {
                    if (update["@type"] == "audio") {}
                  }
                },
                onTap: () {
                  controllerAudio.play;
                },
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Image.asset("/path/thumnail"),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}

```