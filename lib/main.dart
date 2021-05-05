import 'package:flutter/material.dart';
import 'package:fullter_main_app/src/pages/home_new_page.dart';

void main() => runApp(MyApp());

/// This is the main application widget.
class MyApp extends StatelessWidget {
  MyApp({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter Component",
      home: Scaffold(
        //appBar: AppBar(title: Text("Flutter Component")),
        body: HomeNewPage(),
      ),
    );
  }
}
