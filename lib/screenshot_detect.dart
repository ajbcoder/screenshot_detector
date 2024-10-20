// lib/screenshot_detector.dart
import 'package:flutter/services.dart';

class ScreenshotDetect {
  static const EventChannel _eventChannel =
      EventChannel('com.ss.detect/events');

  Stream<ScreenshotEvent>? _screenshotStream;

  /// Represents a screenshot detection event
  Stream<ScreenshotEvent> get onScreenshot {
    _screenshotStream ??= _eventChannel.receiveBroadcastStream().map(
        (event) => ScreenshotEvent.fromMap(event as Map<Object?, Object?>));
    return _screenshotStream!;
  }

  /// Starts listening for screenshot events
  void startListening(Function(ScreenshotEvent event) onScreenshotTaken) {
    onScreenshot.listen(onScreenshotTaken);
  }

  /// Disposes of the screenshot stream
  void dispose() {
    _screenshotStream = null;
  }
}

/// Represents a screenshot detection event with additional metadata
class ScreenshotEvent {
  /// The method used to detect the screenshot
  final String method;

  /// Timestamp when the screenshot was detected
  final DateTime timestamp;

  /// Path to the screenshot file (only available for content observer method)
  final String? path;

  ScreenshotEvent({
    required this.method,
    required this.timestamp,
    this.path,
  });

  factory ScreenshotEvent.fromMap(Map<Object?, Object?> map) {
    return ScreenshotEvent(
      method: map['method'] as String,
      timestamp: DateTime.fromMicrosecondsSinceEpoch(map['timestamp'] as int),
      path: map['path'] as String?,
    );
  }

  @override
  String toString() {
    return 'ScreenshotEvent(method: $method, timestamp: $timestamp, path: $path)';
  }
}
