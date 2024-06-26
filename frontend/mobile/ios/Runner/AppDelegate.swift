import UIKit
import Flutter

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    
    let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
    
    
    PlatformGeoLocationSetup.setUp(
      binaryMessenger: controller.binaryMessenger, 
      api: PlatformGeoLocationImpl()
    )

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
