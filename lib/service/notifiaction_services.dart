import 'dart:developer';
import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> backgroundHandler(RemoteMessage message) async {
  log("Notification received! ${message.notification!.body}");
}

class NotificationServices {
  static Future<void> initialize() async {
    NotificationSettings settings =
        await FirebaseMessaging.instance.requestPermission();
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      log('Notification has been initialized');
      FirebaseMessaging.onBackgroundMessage(backgroundHandler);

    }
  }
}
