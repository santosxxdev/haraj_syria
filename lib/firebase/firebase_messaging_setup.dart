import 'package:firebase_messaging/firebase_messaging.dart';
import 'firebase_notifications.dart';

Future<void> setupFirebaseMessaging() async {
  NotificationSettings settings =
  await FirebaseMessaging.instance.requestPermission(
    alert: true,
    badge: true,
    sound: true,
  );

  print('User granted permission: ${settings.authorizationStatus}');

  String? token = await FirebaseMessaging.instance.getToken();
  print("FCM Token: $token");

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Foreground message: ${message.messageId}');
    showFlutterNotification(message);
  });

  FirebaseMessaging.instance.onTokenRefresh.listen((newToken) {
    print('FCM token refreshed: $newToken');
  });

  RemoteMessage? initialMessage =
  await FirebaseMessaging.instance.getInitialMessage();

  if (initialMessage != null) {
    showFlutterNotification(initialMessage);
  }
}
