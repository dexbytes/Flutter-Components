import 'dart:io';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fullter_main_app/src/api_calling/api_constant.dart';
import 'package:fullter_main_app/src/widgets/android_ios_check_box.dart';
import 'package:fullter_main_app/src/widgets/badge.dart';
import 'package:fullter_main_app/src/widgets/icon_right_with_text.dart';
import 'package:fullter_main_app/src/widgets/labeled_check_box.dart';
import 'package:fullter_main_app/src/widgets/listViewCustom.dart';

class ItemListPage extends StatefulWidget {
  ItemListPage({Key key}) : super(key: key);
  @override
  _ItemListPageState createState() => _ItemListPageState();
}

class _ItemListPageState extends State<ItemListPage> {
  List<String> listData = [];
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    listData = [
      "Followers",
      "Like",
      "Share",
      "Completed",
      "Warning",
      "Notification",
      "Unread" "Draft",
      "Deleted"
    ];
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
            ListViewCustom(
              shrinkWrap: true,
              listData: listData,
              listViewType: ListViewType.LIST_ITEMS,
              tileWidget: ({singleRowData, index}) {
                BadgeType badgeType = BadgeType.FOLLOWERS;
                if (index == 1) {
                  badgeType = BadgeType.LIKE;
                } else if (index == 2) {
                  badgeType = BadgeType.SHARE;
                } else if (index == 3) {
                  badgeType = BadgeType.COMPLETED;
                } else if (index == 4) {
                  badgeType = BadgeType.WARNINGS;
                } else if (index == 5) {
                  badgeType = BadgeType.NOTIFICATION;
                } else if (index == 6) {
                  badgeType = BadgeType.UNREAD;
                } else if (index == 7) {
                  badgeType = BadgeType.DRAFT;
                } else {
                  badgeType = BadgeType.DELETED;
                }
                return IconRightWithText(
                  index: index,
                  text: listData[index],
                  iconRightWidget: Badge(
                    badgeType: badgeType,
                    badgeValue: "70",
                  ),
                  iconViewSize: Size(70, 40),
                );
              },
            )
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
