// ignore_for_file: unnecessary_new

import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import '../util/notification.dart';
import '../util/secure_store.dart';

class PushNotificationService {
  static FirebaseMessaging messaging = FirebaseMessaging.instance;
  static String? tokenFCM;
  static LocalNotification oLocalNotification = LocalNotification();

  /*static StreamController<String> _streamMessageController =
      new StreamController.broadcast();

  static Stream<String> get messageStream => _streamMessageController.stream;*/

  static Future initializeApp() async {
    //Push Notification
    try {
      await Firebase.initializeApp();
      tokenFCM = await FirebaseMessaging.instance.getToken();
      SecureStore oS = SecureStore();
      await oS.createFCM(tokenFCM);
      print("************************ token FCM *******************");
      print(tokenFCM);

      /**Cuando la app esta terminada**/
      FirebaseMessaging.onBackgroundMessage(_backgrounHandler);

      /**CUANDO LA APP ESTA EN BACKGROUND(SE PRESIONO EL HOME ETC)**/
      FirebaseMessaging.onMessage.listen(_onMessageHandler);

      /** CUANDO LA APP ESTA EN USO**/
      FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpenApp);
    } catch (e) {
      print(e.toString());
    }
  }

  static Future<void> _backgrounHandler(RemoteMessage message) async {
    print('BACKGROUND HANLDER ${message.messageId}');
    print("NOTIFICATIOB TITLE ${message.notification!.title}");
    print("NOTIFICATIOB TITLE ${message.notification!.body}");
    oLocalNotification.showNotificationSimple(
        message.notification == null ? "NO TITLE" : message.notification!.title,
        message.notification == null ? "NO BODY" : message.notification!.body,
        "");
    //_streamMessageController.add(message.notification?.title ?? 'No title');
  }

  static Future<void> _onMessageHandler(RemoteMessage message) async {
    print('onMessage HANLDER ${message.messageId}');
    print("NOTIFICATIOB TITLE ${message.notification!.title}");
    print("NOTIFICATIOB TITLE ${message.notification!.body}");
    oLocalNotification.showNotificationSimple(
        message.notification == null ? "NO TITLE" : message.notification!.title,
        message.notification == null ? "NO BODY" : message.notification!.body,
        "");
    //_streamMessageController.add(message.notification?.title ?? 'No title');
  }

  static Future<void> _onMessageOpenApp(RemoteMessage message) async {
    print('onMessageOpenApp HANLDER ${message.messageId}');
    print("NOTIFICATIOB TITLE ${message.notification!.title}");
    print("NOTIFICATIOB BODY ${message.notification!.body}");

    oLocalNotification.showNotificationSimple(
        message.notification == null ? "NO TITLE" : message.notification!.title,
        message.notification == null ? "NO BODY" : message.notification!.body,
        "");
    //_streamMessageController.add(message.notification?.title ?? 'No title');
  }

  /*static closeStreams() {
    _streamMessageController.close();
  }*/
}
