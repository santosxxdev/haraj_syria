import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:haraj_syria/screen/haraj_syria_page.dart';
import 'firebase_options.dart';
import 'firebase/firebase_notifications.dart';

// -------------------- Background handler في main.dart --------------------
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await setupFlutterNotifications();
  showFlutterNotification(message);
  print('Handling a background message ${message.messageId}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // الـ handler علشان مشكله الاشعارات
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  await setupFlutterNotifications();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Haraj Syria',
      theme: ThemeData(primarySwatch: Colors.brown),
      home: const HarajSyriaPage(),
    );
  }
}