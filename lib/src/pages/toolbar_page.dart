import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fullter_main_app/src/api_calling/api_constant.dart';
import 'package:fullter_main_app/src/widgets/alerts/confirmation_alert.dart';
import 'package:fullter_main_app/src/widgets/alerts/inform_alert.dart';
import 'package:fullter_main_app/src/widgets/android_ios_check_box.dart';
import 'package:fullter_main_app/src/widgets/appbar/tool_bar_widget.dart';
import 'package:fullter_main_app/src/widgets/appbar/tool_bar_with_progress_widget.dart';

class ToolBarPage extends StatefulWidget {
  ToolBarPage({Key key}) : super(key: key);
  @override
  _ToolBarPageState createState() => _ToolBarPageState();
}

class _ToolBarPageState extends State<ToolBarPage> {
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
            ListView(
              shrinkWrap: true,
              children: [
                ToolBarWidget(
                  isAndroid: ConstantC.isAndroidPlatform,
                  appBarBgColor: Colors.white,
                  titleStyle: TextStyle(color: Colors.black),
                  context: context,
                  title: "Standard",
                  appBarLeftIcons: Icon(
                    Icons.menu,
                    color: Colors.blueAccent,
                  ),
                  onLeftIconPressed: () {
                    Navigator.pop(context);
                  },
                  appBarRightIcons: [
                    Icon(
                      Icons.ios_share,
                      color: Colors.blueAccent,
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                ToolBarWidget(
                  isAndroid: ConstantC.isAndroidPlatform,
                  appBarBgColor: Colors.blueAccent,
                  titleStyle: TextStyle(color: Colors.white),
                  context: context,
                  title: "Primary",
                ),
                SizedBox(
                  height: 20,
                ),
                ToolBarWidget(
                  isAndroid: ConstantC.isAndroidPlatform,
                  appBarBgColor: Colors.blue,
                  titleStyle: TextStyle(color: Colors.white),
                  context: context,
                  title: "Tertiary",
                  appBarLeftIcons: Icon(
                    Icons.favorite,
                    color: Colors.white,
                  ),
                  appBarRightIcons: [
                    Container(
                      margin: EdgeInsets.only(right: 10.0),
                      child: Icon(
                        Icons.menu,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                ToolBarWidget(
                  isAndroid: ConstantC.isAndroidPlatform,
                  appBarBgColor: Colors.red,
                  titleStyle: TextStyle(color: Colors.white),
                  context: context,
                  title: "Danger",
                  appBarLeftIcons: Icon(
                    Icons.star,
                    color: Colors.white,
                  ),
                  appBarRightIcons: [
                    Container(
                      margin: EdgeInsets.only(right: 10.0),
                      child: Icon(
                        Icons.menu_outlined,
                        color: Colors.black,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 5,
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
                  backgroundColor: Colors.white.withOpacity(0.8),
                  appBar: ToolBarWidget(
                    isAndroid: ConstantC.isAndroidPlatform,
                    appBarBgColor: Colors.white,
                    titleStyle: TextStyle(color: Colors.black),
                    context: context,
                    title: "Standard",
                    appBarLeftIcons: Icon(
                      Icons.arrow_back,
                      color: Colors.blueAccent,
                    ),
                    onLeftIconPressed: () {
                      Navigator.pop(context);
                    },
                    appBarRightIcons: [
                      Icon(
                        Icons.ios_share,
                        color: Colors.blueAccent,
                      )
                    ],
                  ),
                  body: Container(
                    // color: Colors.white,
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      dragStartBehavior: DragStartBehavior.down,
                      child: _centerView(),
                    ),
                  ),
                ))));
  }
}
