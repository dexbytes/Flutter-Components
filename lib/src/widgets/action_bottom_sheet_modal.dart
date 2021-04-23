import 'dart:io';
import 'package:flutter/material.dart';

//Selected menu call back function type
typedef IntCallback = Function(int num);

class ItemModel {
  String menuName;
  Color itemTextColor;
  ItemModel({this.menuName = "", this.itemTextColor});
}

class ActionBottomSheetModal {
  IntCallback
      selectedItemCallBack; //Call back function it call when user click on any menu item button and return index
  VoidCallback
      cancelCallBack; //Call back function it call when user click on cancel button
  BuildContext context;
  String alertTitle = "";
  final List<ItemModel> itemList;
  EdgeInsets itemMarginAllSide;
  EdgeInsets itemPaddingAllSide;
  EdgeInsets sheetPaddingAllSide;
  TextStyle styleRowItemAndroid;
  TextStyle styleRowItemIos;
  TextStyle styleRowTitleAndroid;
  TextStyle styleRowTitleIos;
  bool isAndroid;

  ActionBottomSheetModal({
    @required this.context,
    @required this.cancelCallBack,
    @required this.selectedItemCallBack,
    this.itemList,
    this.alertTitle = "Albums",
    this.isAndroid = false,
    this.itemMarginAllSide =
        const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
    this.itemPaddingAllSide =
        const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
    this.sheetPaddingAllSide =
        const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
    this.styleRowItemAndroid,
    this.styleRowItemIos,
    this.styleRowTitleAndroid,
    this.styleRowTitleIos,
  }) {
    //Check device platform
    /*if (Platform.isIOS) {
      this.isAndroid = false;
    } else if (Platform.isAndroid) {
      this.isAndroid = true;
    }*/
    _actionBottomSheetModal();
  }

  //Single row of items
  Widget singleItemView(
      {@required String menuName, @required int itemIndex, Color itemColor}) {
    TextStyle styleRowItemTemp =
        buildTextStyleMenuItem(textColorItem: itemColor);

    return Align(
      alignment: this.isAndroid ? Alignment.centerLeft : Alignment.center,
      child: Container(
        margin: itemMarginAllSide,
        child: ElevatedButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.white),
              overlayColor: MaterialStateProperty.all(
                  this.isAndroid ? Colors.grey.withOpacity(0.1) : Colors.white),
              padding: MaterialStateProperty.all(itemPaddingAllSide),
              alignment:
                  this.isAndroid ? Alignment.centerLeft : Alignment.center,
              minimumSize:
                  MaterialStateProperty.all(Size(double.maxFinite, 45)),
              elevation: MaterialStateProperty.all(0.0)),
          child: Text('$menuName', style: styleRowItemTemp),
          onPressed: () {
            if (this.selectedItemCallBack != null) {
              this.selectedItemCallBack(itemIndex);
            }
            Navigator.pop(context, true);
          },
        ),
      ),
    );
  }

  //Cancel
  Widget cancelView({Color itemColor}) {
    TextStyle styleRowItemTemp =
        buildTextStyleCancelTitle(textColor: itemColor);
    return Align(
      alignment: this.isAndroid ? Alignment.centerLeft : Alignment.center,
      child: InkWell(
          onTap: () {
            if (this.cancelCallBack != null) {
              this.cancelCallBack();
            }
            Navigator.pop(context, true);
          },
          child: Container(
            margin: this.itemMarginAllSide,
            padding: this.isAndroid
                ? EdgeInsets.only(bottom: 10, top: 10)
                : EdgeInsets.only(bottom: 15, top: 15),
            child: Text('Cancel', style: styleRowItemTemp),
          )),
    );
  }

  //Title
  Widget titleView({Color itemColor}) {
    TextStyle styleRowItemTemp = buildTextStyleTitle(textColor: itemColor);
    return Align(
      alignment: this.isAndroid ? Alignment.centerLeft : Alignment.center,
      child: Container(
        margin: itemMarginAllSide,
        padding: EdgeInsets.only(bottom: 10, top: 10),
        child: Text(
          '${this.alertTitle}',
          style: styleRowItemTemp,
        ),
      ),
    );
  }

  //Item list view
  Widget titleListView() {
    return Align(
      alignment: Alignment.center,
      child: Container(
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: itemList.length,
          itemBuilder: (context, index) {
            return singleItemView(
                menuName: itemList[index].menuName,
                itemColor: itemList[index].itemTextColor,
                itemIndex: index);
          },
        ),
      ),
    );
  }

  Future<void> _actionBottomSheetModal() {
    return showModalBottomSheet<void>(
      isScrollControlled: false,
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          //height: 600,
          color: Colors.transparent,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.max,
            children: [
              Card(
                elevation: this.isAndroid ? 0 : 1,
                margin: this.isAndroid
                    ? EdgeInsets.all(0)
                    : EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                shape: this.isAndroid
                    ? RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(0.0)),
                      )
                    : RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [titleView(), titleListView()],
                ),
              ),
              Card(
                  elevation: this.isAndroid ? 0 : 1,
                  margin: this.isAndroid
                      ? EdgeInsets.all(0)
                      : EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  shape: this.isAndroid
                      ? RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(0.0)),
                        )
                      : RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                  child: cancelView())
            ],
          ),
        );
      },
    );
  }

  TextStyle buildTextStyleMenuItem({Color textColorItem}) {
    TextStyle styleRowItem;
    if (textColorItem == null) {
      textColorItem = isAndroid ? Colors.black : Colors.blue;
    }
    //Ios
    styleRowItem = this.styleRowItemIos != null
        ? this.styleRowItemIos
        : TextStyle(
            color: textColorItem, fontSize: 16, fontWeight: FontWeight.w500);
    //Android
    if (isAndroid) {
      styleRowItem = this.styleRowItemAndroid != null
          ? this.styleRowItemAndroid
          : TextStyle(
              color: textColorItem, fontSize: 16, fontWeight: FontWeight.w400);
    }
    return styleRowItem;
  }

  TextStyle buildTextStyleTitle({Color textColor}) {
    TextStyle styleText;
    if (textColor == null) {
      textColor = isAndroid ? Colors.grey : Colors.grey;
    }
    //ios
    styleText = this.styleRowItemIos != null
        ? this.styleRowItemIos
        : TextStyle(
            color: textColor, fontSize: 16, fontWeight: FontWeight.w500);
    //Android
    if (isAndroid) {
      styleText = this.styleRowItemAndroid != null
          ? this.styleRowItemAndroid
          : TextStyle(
              color: textColor, fontSize: 16, fontWeight: FontWeight.w400);
    }
    return styleText;
  }

  TextStyle buildTextStyleCancelTitle({Color textColor}) {
    TextStyle styleText;
    if (textColor == null) {
      textColor = isAndroid ? Colors.grey : Colors.grey;
    }
    //iOS
    styleText = this.styleRowTitleIos != null
        ? this.styleRowTitleIos
        : TextStyle(
            color: textColor, fontSize: 16, fontWeight: FontWeight.w500);
    //Android
    if (isAndroid) {
      styleText = this.styleRowTitleAndroid != null
          ? this.styleRowTitleAndroid
          : TextStyle(
              color: textColor, fontSize: 16, fontWeight: FontWeight.w400);
    }
    return styleText;
  }
}
