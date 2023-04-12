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
  // final _key = UniqueKey();
  late final WebViewController controller;

  WebViewExampleState(this.url);

  @override
  void initState() {
    super.initState();
    // Enable virtual display.
    // if (Platform.isAndroid) WebView.platform = AndroidWebView();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      // ..setNavigationDelegate(
      //   NavigationDelegate(
      //     onProgress: (int progress) {
      //       // Update loading bar.
      //     },
      //     onPageStarted: (String url) {},
      //     onPageFinished: (String url) {},
      //     onWebResourceError: (WebResourceError error) {},
      //     onNavigationRequest: (NavigationRequest request) {
      //       if (request.url.startsWith('https://www.youtube.com/')) {
      //         return NavigationDecision.prevent;
      //       }
      //       return NavigationDecision.navigate;
      //     },
      //   ),
      // )
      ..loadRequest(Uri.parse(this.url)).then((value) {
        setState(() {
          isLoading = false;
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: new AppBar(
      //     title: Text(this.title,style: TextStyle(fontWeight: FontWeight.w700)),centerTitle: true
      // ),
      body: Stack(
        children: <Widget>[
          WebViewWidget(
            controller: controller,
          ),
          // WebView(
          //   key: _key,
          //   initialUrl: this.url,
          //   javascriptMode: JavascriptMode.unrestricted,
          //   onPageFinished: (finish) {
          //     setState(() {
          //       isLoading = false;
          //     });
          //   },
          // ),
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
