import 'package:flutter/material.dart';
import '../firebase/firebase_messaging_setup.dart';
import '../webview/webview_controller.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HarajSyriaPage extends StatefulWidget {
  const HarajSyriaPage({super.key});

  @override
  State<HarajSyriaPage> createState() => _HarajSyriaPageState();
}

class _HarajSyriaPageState extends State<HarajSyriaPage> {
  late HarajWebViewController webController;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();

    webController = HarajWebViewController((value) {
      setState(() => _isLoading = value);
    });

    setupFirebaseMessaging();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            WebViewWidget(controller: webController.controller),
            if (_isLoading)
              const Center(
                child: CircularProgressIndicator(color: Colors.brown),
              ),
          ],
        ),
      ),
    );
  }
}
