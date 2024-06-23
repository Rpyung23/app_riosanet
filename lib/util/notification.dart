import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'string.dart';

class LocalNotification {
  FlutterLocalNotificationsPlugin oFlutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  AndroidNotificationDetails oAndroidNotificationDetail =
      AndroidNotificationDetails(
    channelId,
    channelName,
    priority: Priority.high,
    playSound: true,
    importance: Importance.high,
    styleInformation: BigTextStyleInformation(''),
    ongoing: false,
  );

  initLocalNotification() async {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
// initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    final DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(
            onDidReceiveLocalNotification: (id, titulo, body, payload) => null);

    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsDarwin,
            macOS: initializationSettingsDarwin);

    await oFlutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: (respose) => null);
  }

  showNotificationSimple(titulo, body, payload) async {
    await initLocalNotification();
    oFlutterLocalNotificationsPlugin.show(0, titulo, body,
        NotificationDetails(android: oAndroidNotificationDetail),
        payload: payload);
  }
}
