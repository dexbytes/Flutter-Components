import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//Selected menu call back function type
typedef RowViewCallback = Function({dynamic singleRowData, int index});

enum ListViewType {
  LIST_CUSTOM_ROW_ITEMS,
  LIST_ITEMS,
  LIST_DIVIDER,
  LIST_ICON,
  LIST_BUTTON,
  LIST_AVATAR,
  LIST_THUMBNAILS
}

class ListViewCustom extends StatelessWidget {
  ListViewCustom({
    Key key,
    this.padding = const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
    this.value,
    this.onChanged,
    this.listViewType = ListViewType.LIST_ITEMS,
    this.isAndroid = false,
    this.dividerColor = Colors.grey,
    this.listData,
    this.tileWidget, // Widget to set the row in a list view
    this.listViewEdgeInsets = const EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 8.0),
    this.listBgColor, // ListView background Color
    this.noDataFoundWidget, // No data found widget
    this.physics, // set data in the list view
    this.shrinkWrap =
        false, // get the call back when user reaches the end of the list view
    this.scrollDirection,
  }) : super(key: key);

  final EdgeInsets padding;
  final ListViewType listViewType;
  final bool value;
  final Function onChanged;
  final bool isAndroid;
  //Data to display to display in the list
  final List<dynamic> listData;
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
  final RowViewCallback tileWidget;
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
    Widget getTileWidgetType({dynamic singleRowData, int index}) {
      Widget tempRowView = Container();
      switch (this.listViewType) {
        case ListViewType.LIST_DIVIDER:
          break;
        case ListViewType.LIST_ICON:
          break;
        case ListViewType.LIST_BUTTON:
          break;
        case ListViewType.LIST_AVATAR:
          break;
        case ListViewType.LIST_THUMBNAILS:
          break;
        default: //ListViewType.LIST_ITEMS
          tempRowView = itemRowView(index: index, item: "$singleRowData");
      }
      return tempRowView;
    }

    //Widget Main List view
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
              var textValue = getListData()[i];
              Widget tempRowView1 = Container();
              if (this.tileWidget != null &&
                  this.listViewType == ListViewType.LIST_CUSTOM_ROW_ITEMS) {
                tempRowView1 =
                    this.tileWidget(singleRowData: textValue, index: i);
                print("Hello");
              } else {
                tempRowView1 =
                    getTileWidgetType(singleRowData: textValue, index: i);
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
  List<dynamic> getListData() {
    List<dynamic> listData = [];
    //If user set dynamic list type
    if (this.listData !=
            null /* &&
        this.listViewType == ListViewType.LIST_CUSTOM_ROW_ITEMS*/
        ) {
      listData.addAll(this.listData);
    } else {
      switch (this.listViewType) {
        case ListViewType.LIST_DIVIDER:
          break;
        case ListViewType.LIST_ICON:
          break;
        case ListViewType.LIST_BUTTON:
          break;
        case ListViewType.LIST_AVATAR:
          break;
        case ListViewType.LIST_THUMBNAILS:
          break;
        default: //ListViewType.LIST_ITEMS
          listData.addAll(["Mobile", "Laptop", "Keyboard"]);
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
}
