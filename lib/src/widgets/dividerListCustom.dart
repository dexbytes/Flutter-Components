import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fullter_main_app/src/widgets/avatar_left_with_data.dart';
import 'package:fullter_main_app/src/widgets/badge.dart';
import 'package:fullter_main_app/src/widgets/icon_left_and_right.dart';
import 'package:fullter_main_app/src/widgets/icon_left_with_text.dart';
import 'package:fullter_main_app/src/widgets/thumbnail_left_with_data.dart';

import 'icon_left_and_right_text_with_text.dart';

typedef DividerRowViewCallback = Function({dynamic singleRowData, int index});
enum DividerListViewType {
  LIST_CUSTOM_ROW_ITEMS,
  LIST_ITEMS,
  LIST_ICON,
  LIST_BUTTON,
  LIST_AVATAR,
  LIST_THUMBNAILS
}

class DividerListCustom extends StatelessWidget {
  DividerListCustom({
    Key key,
    this.padding = const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
    this.value,
    this.onChanged,
    this.dividerListViewType = DividerListViewType.LIST_ITEMS,
    this.isAndroid = false,
    this.dividerColor = Colors.grey,
    this.listData,
    this.dividerTileWidget, // Widget to set the row in a list view
    this.listViewEdgeInsets = const EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 8.0),
    this.listBgColor, // ListView background Color
    this.noDataFoundWidget, // No data found widget
    this.physics, // set data in the list view
    this.shrinkWrap =
        false, // get the call back when user reaches the end of the list view
    this.scrollDirection,
  }) : super(key: key);

  final EdgeInsets padding;
  final DividerListViewType dividerListViewType;
  final bool value;
  final Function onChanged;
  final bool isAndroid;
  //Data to display to display in the list
  final List<HeaderListModel> listData;
  //Properties to set the left, top, right and bottom margin using EdgeInsets
  final EdgeInsetsGeometry listViewEdgeInsets;
  //This color will set the list view background color
  final Color listBgColor;
  final Color dividerColor;
  //No data found widget that display when there no data found
  final Widget noDataFoundWidget;
  final physics;
  final bool shrinkWrap;
  final scrollDirection;
  //Tile widget to display the row in a list view
  final DividerRowViewCallback dividerTileWidget;
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    bool isAndroid = false;
    //Check device platform
    if (Platform.isIOS) {
      isAndroid = false;
    } else if (Platform.isAndroid) {
      isAndroid = true;
    }
    //Ios check box custom
    Widget iosCheckBox = Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      padding: EdgeInsets.all(
          5.0), //I used some padding without fixed width and height
      /* decoration: BoxDecoration(
          // You can use like this way or like the below line
          border: Border.all(
              color: disabled
                  ? checkBoxDisableColor
                  : (value ? checkFillColor : checkBoxColor),
              width: 1.0,
              style: BorderStyle.solid), //Border.all
          borderRadius: BorderRadius.all(
            Radius.circular(50),
          ),
          color: (value && !disabled)
              ? checkFillColor
              : !disabled
                  ? checkNonFillColor
                  : checkFillDisableColor),*/
      /*child: , */ // You can add a Icon instead of text also, like below.
      //child: new Icon(Icons.arrow_forward, size: 50.0, color: Colors.black38)),
    );

    //Create List row according list type
    Widget getTileWidgetType({HeaderListModel singleRowData, int index}) {
      bool isHeaderRow = singleRowData.isHeaderRow;
      dynamic listRowData = singleRowData.listRowData;

      Widget tempRowView = Container();
      switch (this.dividerListViewType) {
        case DividerListViewType.LIST_ICON:
          if (isHeaderRow) {
            tempRowView = listItemHead(index: index, item: "$listRowData");
          } else {
            //Left and right both
            if (singleRowData.leftIcon != null &&
                singleRowData.rightIcon != null) {
              tempRowView = IconLeftAndRight(
                index: index,
                text: "$listRowData",
                iconLeftWidget: singleRowData.leftIcon,
                iconRightWidget: singleRowData.rightIcon,
                iconRightViewSize: Size(70, 40),
              );
            }

            //Only Right
            else if (singleRowData.rightIcon != null &&
                (singleRowData.rightText == null ||
                    singleRowData.rightText.length > 0)) {
              tempRowView = IconLeftAndRight(
                index: index,
                text: "$listRowData",
                iconRightWidget: singleRowData.rightIcon,
                iconLeftWidget: singleRowData.leftIcon,
              );
            }
            //Only Right text
            else if (singleRowData.rightIcon == null &&
                (singleRowData.rightText != null &&
                    singleRowData.rightText.length > 0)) {
              tempRowView = IconLeftAndRightTextWithText(
                index: index,
                text: "$listRowData",
                textRight: singleRowData.rightText,
                iconLeftWidget: singleRowData.leftIcon,
              );
            }
            //Only Left
            else if (singleRowData.leftIcon != null) {
              tempRowView = IconLeftWithText(
                index: index,
                text: "$listRowData",
                iconWidget: singleRowData.leftIcon,
              );
            } else
              tempRowView = IconLeftWithText(
                index: index,
                text: "$listRowData",
                iconWidget: singleRowData.leftIcon,
              );
          }
          break;
        case DividerListViewType.LIST_BUTTON:
          break;
        case DividerListViewType.LIST_AVATAR:
          tempRowView = AvatarLeftWithData(
            index: index,
            avatarPath: listRowData["image"],
            rightWidget: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  // color: Colors.green,
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Name'.toUpperCase(),
                        style: TextStyle(color: Colors.black, fontSize: 12),
                        textAlign: TextAlign.start,
                      )),
                ),
                SizedBox(
                  height: 0,
                ),
                Text(
                  'Madison, WI',
                  style: TextStyle(color: Colors.grey, fontSize: 18),
                  textAlign: TextAlign.start,
                ),
              ],
            ), /*,
            rightWidget: ,: singleRowData.leftIcon,*/
          );

          break;
        case DividerListViewType.LIST_THUMBNAILS:
          tempRowView = ThumbnailLeftWithData(
            index: index,
            avatarPath: listRowData["image"],
            rightWidget: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    // color: Colors.green,
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Name'.toUpperCase(),
                          style: TextStyle(color: Colors.black, fontSize: 12),
                          textAlign: TextAlign.start,
                        )),
                  ),
                  SizedBox(
                    height: 0,
                  ),
                  Text(
                    'Madison, WI',
                    style: TextStyle(color: Colors.grey, fontSize: 18),
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
            ), /*,
            rightWidget: ,: singleRowData.leftIcon,*/
          );
          break;
        default: //DividerListViewType.LIST_ITEMS
          tempRowView = isHeaderRow
              ? listItemHead(index: index, item: "$listRowData")
              : itemRowView(index: index, item: "$listRowData");
      }
      return tempRowView;
    }

    //Main List view
    Widget getListContainer() {
      return Container(
        color: listBgColor == null ? Colors.white : listBgColor,
        child: ListView.separated(
            separatorBuilder: (context, index) => Divider(
                  color: dividerColor,
                  height: 1.0,
                  indent: 0.0,
                  endIndent: 0.0,
                ),
            //controller: scrollController,
            padding: listViewEdgeInsets,
            physics: physics ?? AlwaysScrollableScrollPhysics(),
            shrinkWrap: shrinkWrap,
            scrollDirection: scrollDirection ?? Axis.vertical,
            itemCount: getListData().length,
            itemBuilder: (context, i) {
              HeaderListModel mHeaderListModel = getListData()[i];
              Widget tempRowView1 = Container();
              if (this.dividerTileWidget != null &&
                  this.dividerListViewType ==
                      DividerListViewType.LIST_CUSTOM_ROW_ITEMS) {
                tempRowView1 = this.dividerTileWidget(
                    singleRowData: mHeaderListModel, index: i);
              } else {
                tempRowView1 = getTileWidgetType(
                    singleRowData: mHeaderListModel, index: i);
              }
              Widget tempRowView = tempRowView1;
              return tempRowView;
            }),
      );
    }

    return Padding(
      padding: padding,
      child: getListContainer(),
    );
  }

  //Get list according list type
  List<HeaderListModel> getListData() {
    List<HeaderListModel> listData = [];
    //If user set dynamic list type
    if (this.listData !=
            null /* &&
        this.dividerListViewType == DividerListViewType.LIST_CUSTOM_ROW_ITEMS*/
        ) {
      listData.addAll(this.listData);
    } else {
      switch (this.dividerListViewType) {
        case DividerListViewType.LIST_ICON:
          listData.add(HeaderListModel(
              listRowData: "Check Email",
              leftIcon: const Icon(
                Icons.mail,
                color: Colors.black,
              )));
          listData.add(HeaderListModel(
              listRowData: "Call Me",
              leftIcon: const Icon(
                Icons.chat,
                color: Colors.black,
              )));
          listData.add(HeaderListModel(
              listRowData: "Record Album",
              leftIcon: const Icon(
                Icons.mic,
                color: Colors.black,
              ),
              rightText: "Grammy"));
          listData.add(HeaderListModel(
              listRowData: "Friend",
              leftIcon: const Icon(
                Icons.group,
                color: Colors.black,
              ),
              rightIcon: Badge(
                badgeType: BadgeType.WARNINGS,
                badgeValue: "70",
              )));

          listData.add(
              HeaderListModel(listRowData: "Activities", isHeaderRow: true));
          listData.add(HeaderListModel(
              listRowData: "Booking Bad",
              leftIcon: const Icon(
                Icons.mail,
                color: Colors.black,
              ),
              rightText: "Blue,Yellow,Pink"));
          /* listData.add(HeaderListModel(listRowData: "Mac Mini"));
          listData.add(HeaderListModel(listRowData: "CCTV Camera"));*/
          break;
        case DividerListViewType.LIST_BUTTON:
          break;
        case DividerListViewType.LIST_AVATAR:
          listData.add(HeaderListModel(listRowData: {
            'image': 'https://www.worldatlas.com/upload/ce/81/b5/artboard-1.png'
          }));
          listData.add(HeaderListModel(listRowData: {
            'image': 'https://www.worldatlas.com/upload/ce/81/b5/artboard-1.png'
          }));
          listData.add(HeaderListModel(listRowData: {
            'image': 'https://www.worldatlas.com/upload/ce/81/b5/artboard-1.png'
          }));
          break;
        case DividerListViewType.LIST_THUMBNAILS:
          listData.add(HeaderListModel(listRowData: {
            'image': 'https://www.worldatlas.com/upload/ce/81/b5/artboard-1.png'
          }));
          listData.add(HeaderListModel(listRowData: {
            'image': 'https://www.worldatlas.com/upload/ce/81/b5/artboard-1.png'
          }));
          listData.add(HeaderListModel(listRowData: {
            'image': 'https://www.worldatlas.com/upload/ce/81/b5/artboard-1.png'
          }));
          break;
        default: //DividerListViewType.LIST_ITEMS

          listData.add(HeaderListModel(
              listRowData: "Electronic Item", isHeaderRow: true));
          listData.add(HeaderListModel(listRowData: "Mobile"));
          listData.add(HeaderListModel(listRowData: "Laptop"));
          listData.add(HeaderListModel(listRowData: "Keyboard"));
          listData.add(HeaderListModel(
              listRowData: "Electronic Item 2", isHeaderRow: true));
          listData.add(HeaderListModel(listRowData: "Mouse"));
          listData.add(HeaderListModel(listRowData: "Mac Mini"));
          listData.add(HeaderListModel(listRowData: "CCTV Camera"));
      }
    }
    return listData;
  }

  //Single list row for item list type
  Widget itemRowView({String item, int index}) {
    Widget tempRowView = Container(
      color: Colors.white,
      height: 50,
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: Align(alignment: Alignment.centerLeft, child: Text("$item")),
    );
    return tempRowView;
  }

  //List child head
  Widget listItemHead({String item, int index}) {
    Widget tempRowView = Container(
      color: Colors.blueGrey.withOpacity(0.2),
      height: 45,
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: Align(alignment: Alignment.centerLeft, child: Text("$item")),
    );
    return tempRowView;
  }
}

class HeaderListModel {
  bool isHeaderRow;
  dynamic listRowData;
  Widget leftIcon;
  Widget rightIcon;
  String rightText;
  HeaderListModel(
      {this.isHeaderRow = false,
      @required this.listRowData,
      this.leftIcon,
      this.rightIcon,
      this.rightText = ""});
}
