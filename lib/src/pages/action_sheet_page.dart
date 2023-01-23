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
    // Render modal bottom sheet.
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
                // Button is used to show action bottom sheet modal.
                ElevatedButton(
                  child: const Text('show Modal Bottom Sheet'),
                  onPressed: () {
                    // This sheet has a share item of ActionBottomSheetModal.
                    ActionBottomSheetModal(
                      isAndroid: ConstantC.isAndroidPlatform,
                      alertTitle: "Share option",
                      itemList: [
                        ItemModel(
                            menuName: "Delete",
                            itemTextColor: Colors
                                .red), // This is a bottom sheet single item, By clicking bottom sheet user can move next step after closing the bottom sheet.
                        ItemModel(menuName: "Share"),
                        ItemModel(menuName: "Pay"),
                        ItemModel(menuName: "Favorite")
                      ],
                      context: context,
                      // This is a callback function to perform an action.
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

    // To handle the back button press action of the mobile.
    _onBackPressed() {
      Navigator.pop(context);
    }

    // To the back button press action of the mobile
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
                  // Default function
                  physics: BouncingScrollPhysics(),
                  dragStartBehavior: DragStartBehavior.down,
                  child: _centerView(),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
