# Play library
<p align="center">
  <img src="https://user-images.githubusercontent.com/82513502/173231252-9d9b1090-edf4-474d-9837-831a66277145.png" width="350px">
</p>
<h2 align="center">Fast, Enjoyable & Customizable Play library</h2>

[![Pub Version](https://img.shields.io/pub/v/play?label=pub.dev&labelColor=333940&logo=dart)](https://pub.dev/packages/play)

Play Library untuk memutar video dan audio cross platform dengan mudah hanya menambah code pada dart, example sudah ada di

## Features

- 🚀 Cross platform: mobile, desktop, browser
- ⚡ Great performance
- ❤️ Simple, powerful, & intuitive API

---

## Demo


https://user-images.githubusercontent.com/82513502/204106088-90c8d756-fbee-4724-9087-46bc99e69a00.mp4

https://user-images.githubusercontent.com/82513502/204106197-4bc3d9ba-f374-40ff-9913-7f4ffd40b530.mp4



## Install Library
```bash
dart pub add play
```

```bash
flutter pub add play
```

- [Doc + Example](https://github.com/azkadev/play)
- [Youtube-Tutorial](https://youtube.com/@azkadev)

## To-Do

1. [x] Cross platform support (Android,iOS,Linux,macOS, Windows, Web)
2. [x] Easy Play Video and Audio
3. [x] Custom View Audio And Video
4. [ ] Realtime Player Like (call, streaming)

## Quickstart

Audio Player
```dart

Scaffold(

  ---
  Audio(
    audioData: AudioData.file(
      file: File(path),
    ),
    isAutoStart: false,
    audioViewBuilder: (Widget child, Audio audio, AudioState audioState) {
      return child;
    }
  );
  ---

)

```

Video Player
```dart
Scaffold(

  ---
  Video(
    videoData: VideoData.file(
      file: File(path),
    ),
    isAutoStart: false,
    videoViewBuilder: (Widget child, Video video, VideoState videoState) {
      return child;
    }
  );
  ---

)
```
