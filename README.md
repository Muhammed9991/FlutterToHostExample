# Flutter To Host Example

A Flutter project demonstrating bidirectional communication between Flutter and native platforms (iOS, Android, macOS) using [Pigeon](https://pub.dev/packages/pigeon).

## Overview

This project showcases how to implement type-safe communication between Flutter and native code using the Pigeon package. It demonstrates:

- Flutter-to-native platform communication
- Native-to-Flutter communication
- Handling of complex data types
- Integration with Stacked architecture

## What is Pigeon?

Pigeon is a code generator tool that creates type-safe interfaces for communication between Flutter and host platforms. It generates code for:

- Dart (Flutter)
- Swift/Objective-C (iOS/macOS)
- Kotlin/Java (Android)
- C++ (Windows/Linux)

This eliminates the need for error-prone manual coding of platform channels and ensures type safety across language boundaries.

## Project Structure

- `/pigeons/example_pigeons.dart` - Pigeon interface definitions
- `/lib/src/messages.g.dart` - Generated Dart code for Pigeon interfaces
- iOS, Android, and macOS folders contain the generated native code

## Key Features

### 1. Type-Safe APIs

The project defines two main APIs:

```dart
// Flutter to Host
@HostApi()
abstract class ExampleHostApi {
  String getHostLanguage();
  int add(int a, int b);
  bool sendMessage(MessageData message);
}

// Host to Flutter
@FlutterApi()
abstract class MessageFlutterApi {
  String flutterMethod(String? aString);
}
```

### 2. Complex Data Types

Demonstrates passing complex data structures between Flutter and native platforms:

```dart
class MessageData {
  MessageData({required this.code, required this.data});
  String? name;
  String? description;
  Code code;
  Map<String?, String?> data;
}
```

### 3. Bidirectional Communication

- Flutter can call native methods via `ExampleHostApi`
- Native platforms can call Flutter methods via `MessageFlutterApi`

## Getting Started

### Prerequisites

- Flutter SDK
- Dart SDK
- Xcode (for iOS/macOS)
- Android Studio (for Android)

### Setup

1. Clone the repository
2. Install dependencies:
   ```
   flutter pub get
   ```
3. Run the code generation for Pigeon:
   ```
   dart run pigeon --input pigeons/example_pigeons.dart
   ```
4. Run the app:
   ```
   flutter run
   ```

## How It Works

1. Define your API interfaces in the Pigeon file (`pigeons/example_pigeons.dart`)
2. Run the Pigeon code generator to create platform-specific code
3. Implement the native side of the API in Swift, Kotlin, etc.
4. Use the generated Dart classes in your Flutter code

## Implementation Notes

### Flutter Side

The app uses the Stacked architecture pattern for state management. The `HomeViewModel` demonstrates calling native methods through the Pigeon-generated API:

```dart
void showBottomSheet() {
  MessageData messageData = MessageData(
    code: Code.one,
    data: {'name': 'From flutter', 'description': 'because its cool!'},
  );
  _exampleHostApi.sendMessage(messageData);
  // ...
}
```

### Native Side

Native platforms implement the interface defined by Pigeon. For example, iOS implements the `ExampleHostApi` protocol in Swift.

## Modifying the API

To modify or extend the API:

1. Edit the `pigeons/example_pigeons.dart` file
2. Run the Pigeon code generator:
   ```
   dart run pigeon --input pigeons/example_pigeons.dart
   ```
3. Implement any new methods on the native side
4. Use the updated API in your Flutter code

## Resources

- [Pigeon Package](https://pub.dev/packages/pigeon)
- [Flutter Platform Channels](https://docs.flutter.dev/development/platform-integration/platform-channels)
- [Stacked Architecture](https://pub.dev/packages/stacked)

## License

This project is for educational purposes and is available under the MIT License.
