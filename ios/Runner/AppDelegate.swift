import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
    let nativeChannel = FlutterMethodChannel(name: "com.example.flutter/native",
                                             binaryMessenger: controller.binaryMessenger)

    nativeChannel.setMethodCallHandler({
      (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
      // Flutter'dan gelen 'navigateToNative' metodunu kontrol et
      if call.method == "navigateToNative" {
        self.navigateToNativeScreen() // Native sayfaya geçiş yap
        result(nil)
      } else {
        result(FlutterMethodNotImplemented)
      }
    })

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

    private func navigateToNativeScreen() {
      // Storyboard'daki ViewController'ı yükleme
      let storyboard = UIStoryboard(name: "Main", bundle: nil) // Storyboard'un adı "Main"
      let nativeViewController = storyboard.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController

      // UINavigationController kullanarak sunma
      let navigationController = UINavigationController(rootViewController: nativeViewController)
      navigationController.modalPresentationStyle = .fullScreen

      // Flutter tarafından yönetilen rootViewController'dan geçiş yapın
      if let flutterViewController = window?.rootViewController as? FlutterViewController {
        flutterViewController.present(navigationController, animated: true, completion: nil)
      }
    }
    
    @objc 
    private func closeNativeScreen() {
      // Şu anki ekrandan geri dönmek için dismiss kullanılır
      if let presentedViewController = window?.rootViewController?.presentedViewController {
        presentedViewController.dismiss(animated: true, completion: nil)
      }
    }
}
