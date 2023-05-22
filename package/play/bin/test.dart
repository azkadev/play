Stream<Duration> slebew() async* {
  Duration duration = Duration();
  while (true) {
    await Future.delayed(Duration(milliseconds: 500));
    duration += Duration(seconds: 1);
    if (duration > Duration(seconds: 10)) {
      yield duration;
      break;
    }
    yield duration;
  }
}

void main(List<String> args) async {
  slebew().listen((event) { });
}
