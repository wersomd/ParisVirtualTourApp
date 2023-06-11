import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:async';

class EiffelTower extends StatefulWidget {
  const EiffelTower({super.key});

  @override
  State<EiffelTower> createState() => _EiffelTowerState();
}

class _EiffelTowerState extends State<EiffelTower> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Center(
        child: WebView(
          initialUrl: Uri.dataFromString(
                  "<html><body><iframe src='https://360stories.com/paris/point/eiffel-tower-18?mode=2&playerMode=2' width='100%' height='100%'></iframe></body></html>",
                  mimeType: 'text/html')
              .toString(),
          onWebViewCreated: (WebViewController webViewController) {
            _controller.complete(webViewController);
          },
          javascriptMode: JavascriptMode.unrestricted,
        ),
      ),
    );
  }
}
