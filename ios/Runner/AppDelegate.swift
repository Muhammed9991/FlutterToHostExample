import Flutter
import UIKit

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate, ExampleHostApi {
    
    
    var hostToFlutterAPI: HostToFlutterAPI?
    
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        GeneratedPluginRegistrant.register(with: self)

        let controller: FlutterViewController = window?.rootViewController as! FlutterViewController

        // Host to Flutter communication
        hostToFlutterAPI = HostToFlutterAPI(binaryMessenger: controller.binaryMessenger)
        
        // Flutter to Host communication
        ExampleHostApiSetup.setUp(binaryMessenger: controller.binaryMessenger, api: self)

        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }

    // MARK: - Methods calling from Flutter

    func getHostLanguage() throws -> String {
        "Calling from flutter"
    }

    func add(_ a: Int64, to b: Int64) throws -> Int64 {
        return a + b
    }
    
    func sendMessage(message: MessageData) throws -> Bool {
        print("Message from flutter: \n \(message.data))")
        hostToFlutterAPI?.callFlutterMethod(aString: "Hello from iOS") { _ in }
        return true
    }
}

extension FlutterError: Error {}

class HostToFlutterAPI {
    let flutterAPI: MessageFlutterApi

    init(binaryMessenger: FlutterBinaryMessenger) {
        flutterAPI = MessageFlutterApi(binaryMessenger: binaryMessenger)
    }

    func callFlutterMethod(aString: String?, completion: @escaping (Result<String, Error>) -> Void) {
        flutterAPI.flutterMethod(aString: aString) { _ in
            completion(.success("This is being sent from iOS"))
        }
    }
}
