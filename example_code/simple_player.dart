// // ignore_for_file: unused_local_variable, duplicate_ignore

// import 'dart:io';
// import 'dart:math';
// import 'package:flutter/material.dart';
// import 'package:play/play.dart';
// import 'package:audioplayers/audioplayers.dart';
// import 'package:simulate/simulate.dart';

// import 'package:flutter/foundation.dart';
// import 'package:flutter/gestures.dart';
// import 'package:flutter/rendering.dart';

// void main() {
//   return runSimulate(home: AppPage());
// }

// class AppPage extends StatefulWidget {
//   AppPage({Key? key}) : super(key: key);

//   @override
//   State<AppPage> createState() => _AppPageState();
// }

// class _AppPageState extends State<AppPage> {
//   final player = Audio();
//   late Duration onChanged = Duration();
//   late Duration maxDuration = Duration();
//   double volume = 1;
//   @override
//   Widget build(BuildContext context) {
//     player.player.onPositionChanged.listen((Duration event) {
//       setState(() {
//         onChanged = event;
//       });
//     });
//     player.player.onDurationChanged.listen((Duration d) {
//       print('Max duration: $d');
//       setState(() {
//         maxDuration = d;
//       });
//     });
//     return ScaffoldSimulate(
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           TextButton(
//             onPressed: () async {
//               try {
//                 final selectedDirectory = await FilePicker.platform.pickFiles();
//                 if (selectedDirectory != null) {
//                   if (selectedDirectory.paths[0] != null) {
//                     print(selectedDirectory);

//                     await player.play(DeviceFileSource(selectedDirectory.paths[0]!));
//                   }
//                 }
//               } catch (e) {
//                 print(e);
//               }
//             },
//             child: Text("play"),
//           ),
//           TextButton(
//             onPressed: () async {
//               await player.pause(); // will resume from beginning
//             },
//             child: Text("pause"),
//           ),
//           TextButton(
//             onPressed: () async {
//               await player.resume(); // will resume from beginning
//             },
//             child: Text("resumt"),
//           ),
//           TextButton(
//             onPressed: () async {
//               await player.stop(); // will resume from beginning
//             },
//             child: Text("stop"),
//           ),
//           ProgressBar(
//             progress: onChanged,
//             total: maxDuration,
//             onSeek: (Duration duration) async {
//               print(duration);

//               await player.player.seek(duration);
//             },
//           ),
//           InkWell(
//             onTap: () async {
//               setState(() {
//                 volume++;
//               });

//               await player.player.setVolume(volume);
//             },
//             child: Icon(Icons.add),
//           ),
//           InkWell(
//             onTap: () async {
//               setState(() {
//                 volume--;
//               });

//               await player.player.setVolume(volume);
//             },
//             child: Icon(Icons.minimize),
//           ),
//         ],
//       ),
//     );
//   }
// }
