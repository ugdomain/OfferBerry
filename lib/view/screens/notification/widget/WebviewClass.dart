import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebviewClass extends StatefulWidget {
  String url;
  WebviewClass(this.url);
  @override
  WebViewExampleState createState() => WebViewExampleState(url);
}

class WebViewExampleState extends State<WebviewClass> {
  String url;
  bool isLoading = true;
  final _key = UniqueKey();

  WebViewExampleState(this.url);

  @override
  void initState() {
    super.initState();
    // Enable virtual display.
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: new AppBar(
      //     title: Text(this.title,style: TextStyle(fontWeight: FontWeight.w700)),centerTitle: true
      // ),
      body: Stack(
        children: <Widget>[
          WebView(
            key: _key,
            initialUrl: this.url,
            javascriptMode: JavascriptMode.unrestricted,
            onPageFinished: (finish) {
              setState(() {
                isLoading = false;
              });
            },
          ),
          isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Stack(),
        ],
      ),
    );
  }
}
