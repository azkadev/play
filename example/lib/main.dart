// ignore_for_file: unused_local_variable, duplicate_ignore

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:play/play.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:simulate/simulate.dart';

typedef OnError = void Function(Exception exception);

void main() {
  return runSimulate(home: AppPage()); 
}

class AppPage extends StatefulWidget {
  AppPage({Key? key}) : super(key: key);

  @override
  State<AppPage> createState() => _AppPageState();
}

class _AppPageState extends State<AppPage> {
  final player = Audio();

  @override
  Widget build(BuildContext context) {
    return ScaffoldSimulate(
      body: Column(
        children: [
          TextButton(
            onPressed: () async {
              try {
                final selectedDirectory = await FilePicker.platform.pickFiles();
                if (selectedDirectory != null) {
                  if (selectedDirectory.paths[0] != null) {
                    print(selectedDirectory);
                    await player.play(DeviceFileSource(selectedDirectory.paths[0]!));
                  }
                }
              } catch (e) {
                print(e);
              }
            },
            child: Text("play"),
          ),
          TextButton(
            onPressed: () async {
              await player.pause(); // will resume from beginning
            },
            child: Text("paus"),
          ),
          TextButton(
            onPressed: () async {
              await player.resume(); // will resume from beginning
            },
            child: Text("resumt"),
          ),
          TextButton(
            onPressed: () async {
              await player.stop(); // will resume from beginning
            },
            child: Text("stop"),
          ),
        ],
      ),
    );
  }
}
 