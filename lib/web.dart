import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:perma/login.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String url = "https://flutter.dev/";

  final flutterWebviewPlugin = new FlutterWebviewPlugin();
  late StreamSubscription<WebViewStateChanged>
      _onchanged; // here we checked the url state if it loaded or start Load or abort Load

  @override
  void initState() {
    super.initState();
    _onchanged = flutterWebviewPlugin.onStateChanged
        .listen((WebViewStateChanged state) {});
  }

  @override
  void dispose() {
    super.dispose();
    flutterWebviewPlugin
        .dispose(); // disposing the webview widget to avoid any leaks
  }

  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
        url: url,
        withJavascript: true, // run javascript
        withZoom: false, // if you want the user zoom-in and zoom-out
        hidden:
            false, // put it true if you want to show CircularProgressIndicator while waiting for the page to load

        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text("Flutter"),
          centerTitle: false,
          elevation: 1, // give the appbar shadows

          actions: <Widget>[
            InkWell(
              onTap: () {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => Login()));
              },
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                width: 120,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.white),
                child: Center(
                  child: Text(
                    'Log out',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ], // make the icons colors inside appbar with white color
        ),
        initialChild: Container(
          // but if you want to add your own waiting widget just add InitialChild
          color: Colors.white,
          child: const Center(
            child: Text('waiting...'),
          ),
        ));
  }
}
