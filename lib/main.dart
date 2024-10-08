import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:uasmobile/map/view/demo.dart';
import 'package:uasmobile/view/menu.dart';
import 'package:uasmobile/view/sidebar/sidebar.dart';
import 'package:uasmobile/view/splashscreen.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationPlugin =
    FlutterLocalNotificationsPlugin();

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();

  var initializationSettingsAndroid =
      const AndroidInitializationSettings('codex_logo');
  var initializationSettingsIOS = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification:
          (int id, String? title, String? body, String? payload) async {});
  var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

  await flutterLocalNotificationPlugin.initialize(
    initializationSettings,
    onDidReceiveNotificationResponse: (NotificationResponse response) async {
      final payload = response.payload;
      debugPrint("notification payload: $payload");
    },
  );
  // void main() => runApp( new MyApp());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Poppins'),
      home: Splashscreen(),
    );
  }
}
