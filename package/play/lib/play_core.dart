import 'package:play/media_kit/media_kit.dart';

class Play {
  static void ensureInitialized({String? libmpv}) {
    MediaKit.ensureInitialized();
  }
}
