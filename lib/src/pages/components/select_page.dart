import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fullter_main_app/src/api_calling/api_constant.dart';
import 'package:fullter_main_app/src/widgets/android_ios_check_box.dart';
import 'package:fullter_main_app/src/widgets/badge.dart';
import 'package:fullter_main_app/src/widgets/icon_right_with_text.dart';
import 'package:fullter_main_app/src/widgets/labeled_check_box.dart';
import 'package:fullter_main_app/src/widgets/listViewCustom.dart';
import 'package:fullter_main_app/src/widgets/select_option_alert_view.dart';
import 'package:fullter_main_app/src/widgets/select_option_bottom_sheet_view.dart';

class SelectPage extends StatefulWidget {
  SelectPage({Key key}) : super(key: key);
  @override
  _SelectPageState createState() => _SelectPageState();
}

class _SelectPageState extends State<SelectPage> {
  List<String> listData = [];

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    listData = [
      "Pet",
      "Gaming",
      "Notification",
      "Operating System",
      "Music",
      "Month",
      "Year"
    ];
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
            ListViewCustom(
              shrinkWrap: true,
              listData: listData,
              listViewType: ListViewType.LIST_CUSTOM_ROW_ITEMS,
              tileWidget: ({singleRowData, index}) {
                List<MenuItemModelAlertSelect> listOfData = [
                  MenuItemModelAlertSelect(itemName: "Cat"),
                  MenuItemModelAlertSelect(itemName: "Dog")
                ];
                if (index == 1) {
                  listOfData = [
                    MenuItemModelAlertSelect(itemName: "Playstation"),
                    MenuItemModelAlertSelect(itemName: "NAS"),
                    MenuItemModelAlertSelect(itemName: "Sega Saturn"),
                    MenuItemModelAlertSelect(itemName: "Cricket"),
                  ];
                } else if (index == 3) {
                  listOfData = [
                    MenuItemModelAlertSelect(itemName: "DOS"),
                    MenuItemModelAlertSelect(itemName: "Linux"),
                    MenuItemModelAlertSelect(itemName: "MAC"),
                    MenuItemModelAlertSelect(itemName: "Windows-7"),
                    MenuItemModelAlertSelect(itemName: "Windows-8"),
                    MenuItemModelAlertSelect(itemName: "Windows-10"),
                  ];
                } else if (index == 4) {
                  listOfData = [
                    MenuItemModelAlertSelect(itemName: "Green day"),
                    MenuItemModelAlertSelect(itemName: "Pearl jam"),
                    MenuItemModelAlertSelect(itemName: "Nirvana"),
                  ];
                } else if (index == 5) {
                  listOfData = [
                    MenuItemModelAlertSelect(itemName: "Jan"),
                    MenuItemModelAlertSelect(itemName: "Feb"),
                    MenuItemModelAlertSelect(itemName: "Mar"),
                    MenuItemModelAlertSelect(itemName: "Apr"),
                    MenuItemModelAlertSelect(itemName: "May"),
                  ];
                } else if (index == 6) {
                  listOfData = [
                    MenuItemModelAlertSelect(itemName: "1989"),
                    MenuItemModelAlertSelect(itemName: "1990"),
                    MenuItemModelAlertSelect(itemName: "1991"),
                    MenuItemModelAlertSelect(itemName: "1991"),
                    MenuItemModelAlertSelect(itemName: "1992"),
                    MenuItemModelAlertSelect(itemName: "1993"),
                    MenuItemModelAlertSelect(itemName: "1994"),
                    MenuItemModelAlertSelect(itemName: "1995"),
                    MenuItemModelAlertSelect(itemName: "1996"),
                  ];
                }

                return index == 2
                    ? SelectOptionBottomSheetView(
                        isAndroid: ConstantC.isAndroidPlatform,
                        textLabel: "${listData[index]}",
                        itemList: [
                          MenuItemModelBottomSheet(itemName: "Enable"),
                          MenuItemModelBottomSheet(itemName: "Mute"),
                          MenuItemModelBottomSheet(itemName: "Mute for a week"),
                          MenuItemModelBottomSheet(itemName: "Mute for year")
                        ],
                      )
                    : SelectOptionAlertView(
                        isAndroid: ConstantC.isAndroidPlatform,
                        textLabel: "${listData[index]}",
                        itemList: listOfData,
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
                  appBar: AppBar(
                    backgroundColor: Color.fromRGBO(36, 41, 46, 1),
                    title: Text(
                      "Select",
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
