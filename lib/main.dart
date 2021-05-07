import 'package:flutter/material.dart';
import 'package:fullter_main_app/src/pages/home_new_page.dart';
import 'package:fullter_main_app/src/widgets/alerts/confirmation_alert.dart';

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

/// This is the stateless widget that the main application instantiates.
class MyStatelessWidget extends StatelessWidget {
  const MyStatelessWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              ConfirmationAlert(
                  context: context,
                  noCallback: (alertContext) {},
                  callBackYes: (alertContext) {});
            },
            child: Text("Confirmation"),
          )
        ],
      ),
    );
  }
}
