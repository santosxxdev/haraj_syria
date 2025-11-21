import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/material.dart';

class HarajWebViewController {
  late final WebViewController controller;

  HarajWebViewController(Function(bool) onLoadingChange) {
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.white)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (_) => onLoadingChange(true),
          onPageFinished: (_) => onLoadingChange(false),
          onWebResourceError: (error) {
            debugPrint('WebView error: ${error.description}');
          },
        ),
      )
      ..loadRequest(Uri.parse('https://harajsirya.com/'));
  }


}
