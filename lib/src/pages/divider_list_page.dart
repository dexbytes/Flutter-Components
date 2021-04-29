import 'package:flutter/material.dart';
import 'package:fullter_main_app/src/widgets/android_ios_check_box.dart';
import 'package:fullter_main_app/src/widgets/dividerListCustom.dart';

class DividerListPage extends StatefulWidget {
  DividerListPage({Key key}) : super(key: key);
  @override
  _DividerListPageState createState() => _DividerListPageState();
}

class _DividerListPageState extends State<DividerListPage> {
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //Center View
    Widget _centerView() {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            AndroidIosCheckbox(
              onChanged: () {
                setState(() {});
              },
            ),
            DividerListCustom(
              shrinkWrap: true,
            ),
          ],
        ),
      );
    }

    //Back Press
    _onBackPressed() {
      print("ok");
      Navigator.pop(context);
      print("ok");
    }

    return WillPopScope(
        onWillPop: _onBackPressed,
        child: Container(
            color: Colors.transparent,
            child: SafeArea(
                bottom: false,
                child: Scaffold(
                  backgroundColor: Colors.white,
                  appBar: AppBar(
                    backgroundColor: Color.fromRGBO(36, 41, 46, 1),
                    title: Text(
                      "Item Divider list",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  body: Container(
                    color: Colors.white,
                    child: _centerView(),
                  ),
                ))));
  }
}
