import 'package:flutter/services.dart';
import 'flutter_screenshot_detect_platform_interface.dart';

class MethodChannelFlutterScreenshotDetect
    extends FlutterScreenshotDetectPlatform {
  static const EventChannel _eventChannel =
      EventChannel('com.ss.detect/events');

  @override
  Stream<void> get onScreenshot {
    return _eventChannel.receiveBroadcastStream().map((event) {});
  }
}
