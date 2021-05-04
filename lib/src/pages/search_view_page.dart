import 'dart:io';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fullter_main_app/src/api_calling/api_constant.dart';
import 'package:fullter_main_app/src/widgets/android_ios_check_box.dart';
import 'package:fullter_main_app/src/widgets/badge.dart';
import 'package:fullter_main_app/src/widgets/icon_right_with_text.dart';
import 'package:fullter_main_app/src/widgets/labeled_check_box.dart';
import 'package:fullter_main_app/src/widgets/listViewCustom.dart';
import 'package:fullter_main_app/src/widgets/search_view.dart';

class SearchViewPage extends StatefulWidget {
  SearchViewPage({Key key}) : super(key: key);
  @override
  _SearchViewPageState createState() => _SearchViewPageState();
}

class _SearchViewPageState extends State<SearchViewPage>
    with SingleTickerProviderStateMixin {
  List<String> listData = [];

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    listData = [
      "Followers",
      "Like",
      "Followers",
      "Like",
      "Followers",
      "Like",
      "Followers",
      "Like"
    ];

    void _cancelSearch() {
      print("cancel Search");
    }

    void _clearSearch() {
      print("clear Search");
    }

    void _onUpdate(String value) {
      print("update  $value");
    }

    void _onSubmit(String value) {
      print("submit  $value");
    }

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
            SearchView(
              isAndroid: ConstantC.isAndroidPlatform,
              onCancel: _cancelSearch,
              onClear: _clearSearch,
              onUpdate: _onUpdate,
              onSubmit: _onSubmit,
            ),
            Expanded(
              child: ListViewCustom(
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
              ),
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
