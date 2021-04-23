import 'dart:io';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fullter_main_app/src/api_calling/api_constant.dart';
import 'package:fullter_main_app/src/widgets/android_ios_check_box.dart';
import 'package:fullter_main_app/src/widgets/bottom_sheet_modal.dart';

class ActionSheetPage extends StatefulWidget {
  ActionSheetPage({Key key}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<ActionSheetPage> {
  @override
  Widget build(BuildContext context) {
    //Center View
    Widget _centerView() {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
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
            ListView(
              shrinkWrap: true,
              children: [
                ElevatedButton(
                  child: const Text('show Modal Bottom Sheet'),
                  onPressed: () {
                    BottomSheetModal(
                      isAndroid: ConstantC.isAndroidPlatform,
                      alertTitle: "Share option",
                      itemList: [
                        ItemModel(
                            menuName: "Delete", itemTextColor: Colors.red),
                        ItemModel(menuName: "Share"),
                        ItemModel(menuName: "Pay"),
                        ItemModel(menuName: "Favorite")
                      ],
                      context: context,
                      selectedItemCallBack: (num) {},
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      );
    }

    //Back Press
    _onBackPressed() {
      Navigator.pop(context);
    }

    return WillPopScope(
        onWillPop: _onBackPressed,
        child: Container(
            color: Colors.transparent,
            child: SafeArea(
                bottom: false,
                child: Scaffold(
                  //appBar:_appBar(),
                  body: Container(
                    // color: Colors.white,
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        dragStartBehavior: DragStartBehavior.down,
                        child: _centerView(),
                      ),
                    ),
                  ),
                ))));
  }
}
