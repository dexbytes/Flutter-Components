import 'package:flutter/material.dart';
import 'package:fullter_main_app/src/widgets/drag/drag_size_fill.dart';

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
        body: MyStatelessWidget(),
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
          ResizableWidget(
            manipulatingBallColor: Colors.red,
            child: Container(),
          ),
          SizedBox(
            height: 50,
          ),
          ResizableWidget(
            isShowGrid: true,
            isShowXAxisNumberMarking: false,
            isShowYAxisNumberMarking: false,
            widgetBgColor: Colors.red.shade50,
            manipulatingBallColor: Colors.orange,
            child: Container(),
          )
        ],
      ),
    );
  }
}
