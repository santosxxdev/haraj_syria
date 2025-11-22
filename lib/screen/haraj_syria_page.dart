import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../firebase/firebase_messaging_setup.dart';

class HarajSyriaPage extends StatefulWidget {
  const HarajSyriaPage({super.key});

  @override
  State<HarajSyriaPage> createState() => _HarajSyriaPageState();
}

class _HarajSyriaPageState extends State<HarajSyriaPage> {
  late final WebViewController _controller;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _initializeWebView();
    _setupFirebaseMessaging();
  }

  void _initializeWebView() {
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.white)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (_) => setState(() => _isLoading = true),
          onPageFinished: (_) => setState(() => _isLoading = false),
          onWebResourceError: (error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error loading page: ${error.description}')),
            );
          },
        ),
      )
      ..loadRequest(Uri.parse('https://harajsirya.com/'));
  }

  Future<void> _setupFirebaseMessaging() async {
    await setupFirebaseMessaging();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            WebViewWidget(controller: _controller),
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