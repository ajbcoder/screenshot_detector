
# Flutter Screenshot Detector Plugin

A Flutter plugin to detect when screenshots are taken on Android devices and iOS Devices. This plugin provides a real-time event-based system that works for Android versions below and above 14 (`Android UPSIDE_DOWN_CAKE`). It monitors screenshots using content observers for older Android versions and a dedicated screen capture callback for Android 14+.

## Features

- Detect screenshots on Android devices using two approaches:
  - Content Observer for Android versions < 14.
  - Screen Capture Callback for Android 14+.
- Detect screenshots on iOS.
- Supports real-time screenshot detection using an EventChannel.
- Simple API to listen to screenshot capture events.

## Installation

Add this plugin to your `pubspec.yaml` file:

```yaml
dependencies:
  screenshot_detect: ^0.1.0
```

Run the following command to install the package:

```bash
flutter pub get
```

## Usage

1. Import the plugin in your Dart code:

```dart
import 'package:screenshot_detect/screenshot_detect.dart';
```

2. Initialize the plugin and listen for screenshot events:

```dart
import 'package:flutter/material.dart';
import 'package:screenshot_detect/screenshot_detect.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _status = 'Waiting for screenshot...';

  @override
  void initState() {
    super.initState();

    // Listen for screenshot detection events
    ScreenshotDetect.startListening().listen((event) {
      setState(() {
        _status = 'Screenshot detected at \${event['timestamp']}';
      });
    });
  }

  @override
  void dispose() {
    ScreenshotDetect.stopListening();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Screenshot Detector Example'),
        ),
        body: Center(
          child: Text(_status),
        ),
      ),
    );
  }
}
```

## Methods

### `startListening()`

Starts listening for screenshot capture events.

```dart
Stream<Map<String, dynamic>> startListening()
```

This method returns a stream of events whenever a screenshot is detected. The event contains the following information:

- `method`: Indicates how the screenshot was detected (`content_observer` or `screen_capture_callback`).
- `timestamp`: The timestamp when the screenshot was detected.
- `path`: The file path of the screenshot (only available for `content_observer`).

### `stopListening()`

Stops listening for screenshot events.

```dart
void stopListening()
```

## Android 14 Support

The plugin utilizes the `Activity.ScreenCaptureCallback` API, introduced in Android 14 (`UPSIDE_DOWN_CAKE`), to detect screenshots.

For Android versions lower than 14, the plugin uses the traditional content observer to monitor changes in the `MediaStore` for screenshot files.

## Permissions

To detect screenshots on Android, no special permissions are required for Android 14+. However, for Android versions below 14, make sure the app has permission to read the media files. Add the following permissions in your `AndroidManifest.xml` if targeting Android versions below 14:

```xml
<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" />
```

## Example

You can find a full working example in the `example/` directory of the repository.

## Contribution

Feel free to fork this repository and submit pull requests. Please follow best coding practices and include tests for any new features or fixes.

## License

This plugin is licensed under the MIT License. See the [LICENSE](./LICENSE) file for more details.
