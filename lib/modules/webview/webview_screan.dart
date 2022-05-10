import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
// import 'package:webview_flutter/webview_flutter.dart';

class WebviewScrean extends StatelessWidget {
  final String url;

  WebviewScrean(this.url);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: WebView(
        initialUrl: url,
      ),
      //   WebViewWidget(
      //     controller: WebViewController()..loadRequest(Uri(scheme: 'uri')
      //     )
      // ),
    );
  }
}
