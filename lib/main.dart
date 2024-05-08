import 'package:flutter/material.dart';
import 'package:pigeons_demo/app/app.bottomsheets.dart';
import 'package:pigeons_demo/app/app.dialogs.dart';
import 'package:pigeons_demo/app/app.locator.dart';
import 'package:pigeons_demo/app/app.router.dart';
import 'package:pigeons_demo/src/messages.g.dart';
import 'package:stacked_services/stacked_services.dart';

class _DemoFlutterAPI implements MessageFlutterApi {
  @override
  String flutterMethod(String? aString) {
    print("Message from iOS: $aString");
    return 'Message from iOS: $aString';
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  setupDialogUi();
  setupBottomSheetUi();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    // This is the listener from Host to Flutter
    MessageFlutterApi.setUp(_DemoFlutterAPI());

    return MaterialApp(
      initialRoute: Routes.startupView,
      onGenerateRoute: StackedRouter().onGenerateRoute,
      navigatorKey: StackedService.navigatorKey,
      navigatorObservers: [
        StackedService.routeObserver,
      ],
    );
  }
}
