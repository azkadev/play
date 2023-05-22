// ignore_for_file: argument_type_not_assignable_to_error_handler

import 'dart:async';
import 'dart:convert';

import 'package:play/src/media_data.dart';

Stream<Duration> slebew() async* {
  Duration duration = Duration();
  while (true) {
    await Future.delayed(Duration(milliseconds: 500));
    duration += Duration(seconds: 1);
    if (duration > Duration(seconds: 10)) {
      yield duration;

      throw "SA";
    }
    yield duration;
  }
}

void prettyPrintData(dynamic data) {
  if (data is Map || data is List) {
    print(JsonEncoder.withIndent(" " * 2).convert(data));
  } else {
    print("${data.toString()}");
  }
}

void main(List<String> args) async {
  // var res = await GoogleApisClient(googleApisClientApiKey: GoogleApisClientApiKey({})).youtube_no_auth.getChannelVideos(channel: "UC928-F8HenjZD1zNdMY42vA");
  // prettyPrintData(res.toJson());
  print(
      (await MediaData.youtube(url: "https://youtube.com/watch?v=qhkxK0TyUKQ"))
          ?.path);
}
