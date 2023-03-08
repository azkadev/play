# Play library
<p align="center">
  <img src="https://user-images.githubusercontent.com/82513502/173231252-9d9b1090-edf4-474d-9837-831a66277145.png" width="350px">
</p>
<h2 align="center">Fast, Enjoyable & Customizable Play library</h2>

[![Pub Version](https://img.shields.io/pub/v/play?label=pub.dev&labelColor=333940&logo=dart)](https://pub.dev/packages/play)

Play Library untuk memutar video dan audio cross platform dengan mudah hanya menambah code pada dart, example sudah ada di

## Features

- 🚀 Cross platform: mobile, desktop, web
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

1. [x] Cross platform support (Android,iOS, Linux, Windows, Web)
2. [x] Easy Play Video and Audio
3. [x] Custom View Audio And Video
4. [x] Realtime Player Like (call, streaming)
5. [ ] Custom Encoding & Decoding Audio & Video

## Tested On 
 
| OS      | Tested     |
|---------|------------|
| Android | Tested     |
| Linux   | Tested     |
| Windows | Tested     |
| ios     | Tested     |
| Web     | Tested     |
| macOS   | Not Tested |

## Quickstart

add library in first dart file

```dart
import 'package:play/play.dart';
```

Audio Player
```dart

Scaffold(

  ---
  Audio(
    audioData: AudioData.file(
      file: File(path),
    ),
    isAutoStart: false,
    builder: (BuildContext context, Widget child, Audio audio, AudioState audioState,AudioController audioController) {
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
    mediaData: MediaData.file(
      file: File(path),
    ),
    isAutoStart: false,
    builder: (BuildContext context, Widget child, Video video, VideoState videoState, MediaController mediaController) {
      return child;
    }
  );
  ---

)
``` 

> I don't have enough native coding skills so I can't add many features in this library, if you want to contribute please just add it I'll be happy if you help me


## Docs
I use 3 libraries so your document can be seen here

1. [video_player](https://github.com/flutter/plugins/tree/main/packages/video_player/video_player)
2. [media_kit](https://github.com/alexmercerind/media_kit)


### Audio
Documentation audio

1. AudioData
   
  - file
    ```dart
    AudioData.file(
      file: File("./path_to_audio.mp3"),
    )
    ```
  - asset
    ```dart
    AudioData.asset(
      asset: "assets/audio/audio.mp3",
    )
    ```
  - network
    ```dart
    AudioData.network(
      url: "https://example.com/example.mp3",
    )
    ```

2. isAutoStart 
   - `true`
      if you want auto play set data to true
   - `false`
      if you don't want auto play set data to true
3. id
   - int
    If you want to play a lot of media, add the IDs in the order of the videos / don't have the same ones

4. builder

#### AudioController
- `pause`
- `play`

### Video
Documentation video
```dart

Scaffold(
  child: Video(
    mediaData: MediaData.file(
      file: File(path),
    ),
    isAutoStart: false,
    builder: (BuildContext context, Widget child, Video video, VideoState videoState, MediaController mediaController) {
      /// custom view
      return child;
    }
  );
)
```

1. mediaData
   
  - file
    ```dart
    MediaData.file(
      file: File("./path_to_video.mp4"),
    )
    ```
  - asset
    ```dart
    MediaData.asset(
      asset: "assets/videos/video.mp4",
    )
    ```
  - network
    ```dart
    MediaData.network(
      url: "https://example.com/example.mp4",
    )
    ```
2. isAutoStart 
   - `true`
      if you want auto play set data to true
   - `false`
      if you don't want auto play set data to true
3. id
   - int
    If you want to play a lot of media, add the IDs in the order of the videos / don't have the same ones

4. builder

#### MediaController
- `seek(Duration())`
- `playOrPause`
- `isPlaying`
- `pause`
- `play`
- `size`
- `aspectRatio`
- `setPlaybackSpeed(1.5)`
- `setVolume(0.5)`