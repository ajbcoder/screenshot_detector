// screenshot_detector/ios/Classes/FlutterScreenshotDetectPlugin.swift
import Flutter
import UIKit

public class FlutterScreenshotDetectPlugin: NSObject, FlutterPlugin, FlutterStreamHandler {
    private var eventSink: FlutterEventSink?
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterEventChannel(
            name: "com.ss.detect/events",
            binaryMessenger: registrar.messenger()
        )
        let instance = FlutterScreenshotDetectPlugin()
        channel.setStreamHandler(instance)
    }
    
    public func onListen(withArguments arguments: Any?, eventSink: @escaping FlutterEventSink) -> FlutterError? {
        self.eventSink = eventSink
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(onScreenshotCaptured),
            name: UIApplication.userDidTakeScreenshotNotification,
            object: nil
        )
        return nil
    }
    
    public func onCancel(withArguments arguments: Any?) -> FlutterError? {
        NotificationCenter.default.removeObserver(
            self,
            name: UIApplication.userDidTakeScreenshotNotification,
            object: nil
        )
        eventSink = nil
        return nil
    }
    
    @objc private func onScreenshotCaptured() {
        let eventData: [String: Any] = [
            "method": "NA",
            "timestamp": Int(Date().timeIntervalSince1970 * 1_000_000), // Actual timestamp in microseconds
            "path": "NA"
        ]
        
        eventSink?(eventData)
    }
}
