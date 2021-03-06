import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fullter_main_app/src/api_calling/api_constant.dart';
import 'package:fullter_main_app/src/widgets/android_ios_check_box.dart';
import 'package:fullter_main_app/src/widgets/action_bottom_sheet_modal.dart';

class ActionSheetPage extends StatefulWidget {
  ActionSheetPage({Key key}) : super(key: key);
  @override
  _ActionSheetPageState createState() => _ActionSheetPageState();
}

class _ActionSheetPageState extends State<ActionSheetPage> {
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
                    ActionBottomSheetModal(
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
                  appBar: AppBar(
                    backgroundColor: Color.fromRGBO(36, 41, 46, 1),
                    title: Text(
                      "Action Sheet",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
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
