import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fullter_main_app/src/api_calling/api_constant.dart';
import 'package:fullter_main_app/src/widgets/alerts/confirmation_alert.dart';
import 'package:fullter_main_app/src/widgets/alerts/inform_alert.dart';
import 'package:fullter_main_app/src/widgets/android_ios_check_box.dart';
import 'package:fullter_main_app/src/widgets/tab_bar_widget.dart';

class TabBarPage extends StatefulWidget {
  TabBarPage({Key key}) : super(key: key);
  @override
  _TabBarPageState createState() => _TabBarPageState();
}

class _TabBarPageState extends State<TabBarPage> {
  int selectedTabMenu = 0;
  String itemMenu = "Music";
  @override
  Widget build(BuildContext context) {
    //Bo
    void onBottomIconPressed(int index) {
      setState(() {
        selectedTabMenu = index;
        if (index == 0) {
          itemMenu = "Music";
        } else if (index == 1) {
          itemMenu = "Movie";
        } else if (index == 2) {
          itemMenu = "Video";
        }
      });
    }

    TabBarWidget mTabBarView = TabBarWidget(
        menuClickedCallBack: onBottomIconPressed,
        enableItemColor: Colors.green,
        selectedTabMenu: selectedTabMenu,
        notificationCount: 0,
        showLabels: true,
        labelTextStyle: TextStyle(
          fontSize: 12,
        ),
        tabBarItems: [
          TabBarItemsDetails(
              menuName: "Music",
              iconData: Icon(
                Icons.music_note,
                color: Colors.green,
                size: 30.0,
              )),
          TabBarItemsDetails(
              menuName: "Movie",
              iconData: Icon(
                Icons.movie,
                color: Colors.green,
                size: 30.0,
              )),
          TabBarItemsDetails(
              menuName: "Video",
              iconData: Icon(
                Icons.video_call,
                color: Colors.green,
                size: 30.0,
              )),
          /*TabBarItemsDetails(
              menuName: "Home4",
              iconData: Icon(
                Icons.audiotrack,
                color: Colors.green,
                size: 30.0,
              )),
          TabBarItemsDetails(
              menuName: "Home5",
              iconData: Icon(
                Icons.audiotrack,
                color: Colors.green,
                size: 30.0,
              )),*/
        ]);
    //Center View
    Widget _centerView() {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[],
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
                  backgroundColor: Colors.white.withOpacity(0.9),
                  appBar: AppBar(
                    backgroundColor: Color.fromRGBO(36, 41, 46, 1),
                    title: Text(
                      "$itemMenu",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  body: Container(
                    //color: Colors.white,
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      dragStartBehavior: DragStartBehavior.down,
                      child: _centerView(),
                    ),
                  ),
                  bottomNavigationBar: SafeArea(
                    child: (MediaQuery.of(context).viewInsets.bottom == 0)
                        ? Container(
                            child: mTabBarView,
                          )
                        : Container(),
                  )),
            )));
  }
}
