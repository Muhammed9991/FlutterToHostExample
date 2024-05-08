import 'package:pigeon/pigeon.dart';

// Any changes made here and we need to run
// dart pub run pigeon --input pigeons/example_pigeons.dart

// This autogenerates code for swift, kotlin, java, objc, and cpp
// we can remove as needed
@ConfigurePigeon(PigeonOptions(
  dartOut: 'lib/src/messages.g.dart',
  dartOptions: DartOptions(),
  kotlinOut:
      'android/app/src/main/kotlin/dev/flutter/pigeon_example_app/Messages.g.kt',
  kotlinOptions: KotlinOptions(),
  javaOut: 'android/app/src/main/java/io/flutter/plugins/Messages.java',
  javaOptions: JavaOptions(),
  swiftOut: 'ios/Runner/Messages.g.swift',
  swiftOptions: SwiftOptions(),
  objcHeaderOut: 'macos/Runner/messages.g.h',
  objcSourceOut: 'macos/Runner/messages.g.m',
  // Set this to a unique prefix for your plugin or application, per Objective-C naming conventions.
  objcOptions: ObjcOptions(prefix: 'PGN'),
  dartPackageName: 'pigeon_example_package',
))
enum Code { one, two }

class MessageData {
  MessageData({required this.code, required this.data});
  String? name;
  String? description;
  Code code;
  Map<String?, String?> data;
}

// Flutter to Host
@HostApi()
abstract class ExampleHostApi {
  String getHostLanguage();

  // These annotations create more idiomatic naming of methods in Objc and Swift.
  @ObjCSelector('addNumber:toNumber:')
  @SwiftFunction('add(_:to:)')
  int add(int a, int b);

  @SwiftFunction('sendMessage(message:)')
  bool sendMessage(MessageData message);
}

// Host to Flutter
@FlutterApi()
abstract class MessageFlutterApi {
  String flutterMethod(String? aString);
}
