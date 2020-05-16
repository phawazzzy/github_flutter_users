import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class WebViewer extends StatefulWidget {
  final String url;
  final String userName;

  WebViewer({this.url, this.userName});

  @override
  _WebViewerState createState() => _WebViewerState(url, userName);
}

class _WebViewerState extends State<WebViewer> {
  String _url;
  String _userName;

  final _key = UniqueKey();

  _WebViewerState(this._url, this._userName);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
//          Text('this is me'),

          Expanded(
            child: WebviewScaffold(
              url: _url,
//              appBar: AppBar(
//                title: Text('$_userName Profile'),
//              ),
            ),
          ),
        ],
      ),
    );
  }
}