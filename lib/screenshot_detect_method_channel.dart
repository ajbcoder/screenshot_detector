import 'package:flutter/services.dart';
import 'screenshot_detect_platform_interface.dart';

class MethodChannelScreenshotDetect extends ScreenshotDetectPlatform {
  static const EventChannel _eventChannel =
      EventChannel('com.ss.detect/events');

  @override
  Stream<void> get onScreenshot {
    return _eventChannel.receiveBroadcastStream().map((event) {});
  }
}
