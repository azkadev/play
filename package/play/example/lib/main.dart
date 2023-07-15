// ignore_for_file: non_constant_identifier_names

import 'package:flutter/foundation.dart';
import 'package:galaxeus_lib/extension/extension.dart';
import "package:universal_io/io.dart";
import 'package:file_picker/file_picker.dart';
import "package:device_frame/device_frame.dart";

import 'package:flutter/material.dart';
import 'package:play/play.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Play.ensureInitialized();
  return runApp(
    const MaterialApp(home: MainPage()),
  );
}

class MainPage extends StatefulWidget {
  const MainPage({
    super.key,
  });
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  DeviceInfo device = Devices.ios.iPhone13ProMax;
  TextEditingController textEditingController = TextEditingController();
  final MediaController media_controller = MediaController(
    id: 0,
    isAutoStart: false,
  );
  List<FileSystemEntity> files = [];
  PageController pageController = PageController();
  int index = 0;
  bool isPlay = true;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    media_controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    return Scaffold(
      body: SizedBox(
        height: mediaQueryData.size.height,
        width: mediaQueryData.size.width,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: TextFormField(
                controller: textEditingController,
                cursorColor: Colors.black,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (String? text) {
                  if (text == null || text.isEmpty) {
                    return "Url harus isi";
                  }
                  if (!RegExp(r"^http", caseSensitive: false).hasMatch(text)) {
                    return "format url salah";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(0.0),
                  hintText: 'https://video.com/video.mp4',
                  labelText: "Video url",
                  labelStyle: const TextStyle(
                    color: Colors.black,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w400,
                  ),
                  hintStyle: const TextStyle(
                    color: Colors.grey,
                    fontSize: 14.0,
                  ),
                  suffixIconColor: Colors.black,
                  suffix: Padding(
                    padding: const EdgeInsets.all(10),
                    child: InkWell(
                      onTap: () async {
                        if (textEditingController.text.isEmpty) {
                          return;
                        }
                        Uri uri = Uri.parse(textEditingController.text);
                        print(uri);
                        if (RegExp(r"(youtube)", caseSensitive: false).hashData(uri.host)) {
                          print("wait");
                          MediaData? mediaData = await MediaData.youtube(
                            url: textEditingController.text,
                          );
                          print(mediaData ?? "a");
                          if (mediaData == null) {
                            return;
                          }
                          await media_controller.initialize(
                            setState: setState,
                            mediaData: mediaData,
                            onReady: (bool isReady) {
                              setState(() {
                                media_controller.is_init = isReady;
                              });
                            },
                          );
                        } else {
                          await media_controller.initialize(
                            setState: setState,
                            mediaData: MediaData.network(
                              url: textEditingController.text,
                            ),
                            onReady: (bool isReady) {
                              setState(() {
                                media_controller.is_init = isReady;
                              });
                            },
                          );
                        }

                        await media_controller.playOrPause();
                        setState(() {});
                      },
                      child: const Icon(
                        Icons.send,
                        color: Colors.black,
                        size: 18,
                      ),
                    ),
                  ),
                  prefixIcon: const Icon(
                    Icons.link,
                    color: Colors.black,
                    size: 18,
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey.shade200,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey.shade200,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  floatingLabelStyle: const TextStyle(
                    color: Colors.black,
                    fontSize: 18.0,
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.black,
                      width: 1.5,
                    ),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.black,
                      width: 1.5,
                    ),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.black,
                      width: 1.5,
                    ),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  PopupMenuButton(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        device.name,
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                        overflow: TextOverflow.clip,
                      ),
                    ),
                    itemBuilder: (BuildContext context) {
                      return [
                        ...Devices.all
                            .map((DeviceInfo deviceInfo) {
                              return PopupMenuItem(
                                child: Text(
                                  "${deviceInfo.name} ${deviceInfo.identifier.platform.name}",
                                ),
                                onTap: () {
                                  setState(() {
                                    device = deviceInfo.copyWith.call();
                                  });
                                },
                              );
                            })
                            .toList()
                            .cast<PopupMenuItem>(),
                      ];
                    },
                  ),
                ],
              ),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(0),
                child: DeviceFrame(
                  device: device,
                  screen: LayoutBuilder(
                    builder: (BuildContext ctx, BoxConstraints constraints) {
                      return MaterialApp(
                        home: Scaffold(
                          backgroundColor: Colors.black,
                          body: Visibility(
                            visible: !kIsWeb,
                            replacement: Stack(
                              fit: StackFit.passthrough,
                              children: [
                                Center(
                                  child: AspectRatio(
                                    aspectRatio: media_controller.aspectRatio,
                                    child: MediaPlayer(
                                      mediaController: media_controller,
                                      onProcces: (context) {
                                        return const CircularProgressIndicator();
                                      },
                                    ),
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
                                          onTap: () async {
                                            await media_controller.pause();
                                            // pageController.jumpToPage(i - 1);
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
                                          onTap: () async {
                                            print("sasa");
                                            await media_controller.playOrPause();
                                          },
                                          child: Icon(
                                            (media_controller.isPlaying) ? Icons.pause : Icons.play_arrow,
                                            color: Colors.white,
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () async {
                                            await media_controller.pause();

                                            // pageController.jumpToPage(i + 1);
                                          },
                                          child: const Icon(
                                            Icons.skip_next,
                                            color: Colors.white,
                                          ),
                                        ),
                                        Expanded(
                                          child: StreamBuilder(
                                            stream: media_controller.streamDurationPosition(),
                                            builder: (BuildContext context, AsyncSnapshot snapshot) {
                                              return Slider(
                                                min: 0,
                                                max: media_controller.getDurationMax().inMicroseconds.toDouble(),
                                                value: media_controller.getDurationPosition().inMicroseconds.toDouble(),
                                                onChanged: (double value) async {
                                                  await media_controller.seek(Duration(microseconds: value.toInt()));
                                                  setState(() {});
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
                            child: Visibility(
                              visible: files.isNotEmpty,
                              replacement: Center(
                                child: TextButton(
                                  onPressed: () async {
                                    String? dir = await FilePicker.platform.getDirectoryPath();
                                    if (dir != null) {
                                      var directory = Directory(dir);
                                      files = directory.listSync();

                                      setState(() {});
                                    }
                                  },
                                  child: const Text("select directory medias"),
                                ),
                              ),
                              child: PageView.builder(
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
                                    key: Key("video :${i}"),
                                    mediaData: MediaData.file(file: File(files[i].path)),
                                    id: i,
                                    onProcces: (context) {
                                      return const Text(
                                        "Thumbnail",
                                      );
                                    },
                                    builder: (BuildContext context, Widget child, Video video, VideoState videoState, MediaController mediaController) {
                                      if (index != i) {
                                        videoState.mediaController.pause();
                                      } else {
                                        if (isPlay) {
                                          videoState.mediaController.play();
                                        } else {
                                          videoState.mediaController.pause();
                                        }
                                      }
                                      return Container(
                                        width: MediaQuery.of(ctx).size.width,
                                        height: MediaQuery.of(ctx).size.height,
                                        decoration: const BoxDecoration(
                                          color: Colors.black,
                                        ),
                                        child: Stack(
                                          fit: StackFit.passthrough,
                                          children: [
                                            Center(
                                              child: AspectRatio(
                                                aspectRatio: videoState.mediaController.aspectRatio,
                                                child: child,
                                              ),
                                            ),
                                            Positioned(
                                              top: 5,
                                              left: 0,
                                              right: 0,
                                              child: Padding(
                                                padding: const EdgeInsets.all(25),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    TextButton(
                                                      onPressed: () async {
                                                        await mediaController.dispose();
                                                        files = [];

                                                        setState(() {});
                                                        String? dir = await FilePicker.platform.getDirectoryPath();
                                                        if (dir != null) {
                                                          var directory = Directory(dir);
                                                          files = directory.listSync();

                                                          setState(() {});
                                                        }
                                                      },
                                                      child: const Text("select directory medias"),
                                                    ),
                                                    InkWell(
                                                      onTap: () async {
                                                        await mediaController.dispose();
                                                        files = [];
                                                        setState(() {});
                                                      },
                                                      child: const Icon(
                                                        Icons.close,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ],
                                                ),
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
                                                        videoState.mediaController.pause();
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
                                                      onTap: () async {
                                                        await videoState.mediaController.playOrPause();
                                                        setState(() {
                                                          isPlay = !videoState.mediaController.isPlaying;
                                                        });
                                                      },
                                                      child: Icon(
                                                        (isPlay) ? Icons.pause : Icons.play_arrow,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                    InkWell(
                                                      onTap: () {
                                                        videoState.mediaController.pause();

                                                        pageController.jumpToPage(i + 1);
                                                      },
                                                      child: const Icon(
                                                        Icons.skip_next,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: StreamBuilder(
                                                        stream: videoState.mediaController.streamDurationPosition(),
                                                        builder: (BuildContext context, AsyncSnapshot snapshot) {
                                                          return Slider(
                                                            min: 0,
                                                            max: videoState.mediaController.getDurationMax().inMilliseconds.toDouble(),
                                                            value: videoState.mediaController.getDurationPosition().inMilliseconds.toDouble(),
                                                            onChanged: (double value) {
                                                              setState(() {
                                                                videoState.mediaController.seek(Duration(milliseconds: value.toInt()));
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
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
