import "package:flutter/material.dart";
import 'package:share/share.dart';
import 'dart:io';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {
  String url;
  String title;

  WebViewPage(this.url, this.title);

  @override
  WebViewPageState createState() => WebViewPageState();
}

class WebViewPageState extends State<WebViewPage> {
  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Haber WebView"),
        actions: [
          IconButton(
              icon: Icon(Icons.share_outlined),
              onPressed: () {
                _share(context);
              })
        ],
      ),
      body: WebView(
        initialUrl: widget.url,
      ),
    );
  }

  _share(BuildContext context) async {
    final RenderBox box = context.findRenderObject();
    await Share.share(widget.title + "\n "+ widget.url,
        sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
  }
}
