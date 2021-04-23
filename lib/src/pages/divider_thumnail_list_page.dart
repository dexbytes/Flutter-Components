import 'dart:io';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fullter_main_app/src/api_calling/api_constant.dart';
import 'package:fullter_main_app/src/widgets/android_ios_check_box.dart';
import 'package:fullter_main_app/src/widgets/badge.dart';
import 'package:fullter_main_app/src/widgets/dividerListCustom.dart';
import 'package:fullter_main_app/src/widgets/icon_right_with_text.dart';
import 'package:fullter_main_app/src/widgets/labeled_check_box.dart';
import 'package:fullter_main_app/src/widgets/listViewCustom.dart';

class DividerThumbnailListPage extends StatefulWidget {
  DividerThumbnailListPage({Key key}) : super(key: key);
  @override
  _DividerThumbnailListPageState createState() =>
      _DividerThumbnailListPageState();
}

class _DividerThumbnailListPageState extends State<DividerThumbnailListPage> {
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
              dividerListViewType: DividerListViewType.LIST_THUMBNAILS,
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
                  //appBar:_appBar(),
                  body: Container(
                    color: Colors.white,
                    child: _centerView(),
                  ),
                ))));
  }
}
