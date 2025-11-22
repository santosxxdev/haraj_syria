import 'package:firebase_messaging/firebase_messaging.dart';
import 'firebase_notifications.dart';

Future<void> setupFirebaseMessaging() async {
  // Request notification permissions
  NotificationSettings settings = await FirebaseMessaging.instance.requestPermission(
    alert: true,
    badge: true,
    sound: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
  );
  print('User granted permission: ${settings.authorizationStatus}');

  // Get FCM token
  String? token = await FirebaseMessaging.instance.getToken();
  print("FCM Token: $token");

  // ✅ تعديل مهم: تحقق من البيانات قبل عرض الإشعار
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Received foreground message: ${message.messageId}');

    // تأكد إن في بيانات إشعار فعلاً
    if (message.notification != null) {
      print('Showing notification: ${message.notification!.title}');
      showFlutterNotification(message);
    } else {
      print('Message has no notification data, skipping...');
    }
  });

  // Token refresh
  FirebaseMessaging.instance.onTokenRefresh.listen((newToken) {
    print('FCM token refreshed: $newToken');
  });

  // Initial message when app terminated
  RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage();
  if (initialMessage != null && initialMessage.notification != null) {
    print('App opened from terminated state by notification');
    showFlutterNotification(initialMessage);
  }

  // ✅ إضافة handler للإشعارات من الخلفية
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    print('App opened from background by notification');
    if (message.notification != null) {
      showFlutterNotification(message);
    }
  });
}