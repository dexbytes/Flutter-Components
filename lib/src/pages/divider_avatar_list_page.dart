import 'package:flutter/material.dart';
import 'package:fullter_main_app/src/widgets/android_ios_check_box.dart';
import 'package:fullter_main_app/src/widgets/dividerListCustom.dart';

class DividerAvatarListPage extends StatefulWidget {
  DividerAvatarListPage({Key key}) : super(key: key);
  @override
  _DividerAvatarListPageState createState() => _DividerAvatarListPageState();
}

class _DividerAvatarListPageState extends State<DividerAvatarListPage> {
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
              dividerListViewType: DividerListViewType.LIST_AVATAR,
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
                      "Avatar list",
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
