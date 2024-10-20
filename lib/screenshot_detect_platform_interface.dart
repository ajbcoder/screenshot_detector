// screenshot_detector/lib/screenshot_detector_platform_interface.dart
import 'package:flutter_screenshot_detect/screenshot_detect_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

abstract class ScreenshotDetectPlatform extends PlatformInterface {
  ScreenshotDetectPlatform() : super(token: _token);

  static final Object _token = Object();
  static ScreenshotDetectPlatform _instance = MethodChannelScreenshotDetect();

  static ScreenshotDetectPlatform get instance => _instance;

  static set instance(ScreenshotDetectPlatform instance) {
    PlatformInterface.verify(instance, _token);
    _instance = instance;
  }

  Stream<void> get onScreenshot {
    throw UnimplementedError('onScreenshot has not been implemented.');
  }
}
