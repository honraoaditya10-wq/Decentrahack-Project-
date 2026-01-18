import UIKit
import Flutter
import GoogleMaps   // 👈 Add this line

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    
    // 👇 Add your Google Maps API key here
    GMSServices.provideAPIKey("AIzaSyAs4ZHvrzhYs5219h53-323VNOBzDX8BEs")
    
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
