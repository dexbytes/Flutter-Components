import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

typedef SelectedBottomSheetCallBack = Function({int index});

class SelectOptionBottomSheetView extends StatefulWidget {
  final String text;
  final String textLabel;
  final TextStyle selectionOptionTextStyle;
  final Widget iconWidget;
  final List<MenuItemModelBottomSheet> itemList;
  final bool isAndroid;
  final SelectedBottomSheetCallBack selectedCallBack;
  final int
      preSelectedIndex; //Pre selected index if we want show pre selected index from list it by default -1 means no menu selected
  SelectOptionBottomSheetView({
    Key key,
    this.text,
    this.textLabel = "",
    this.isAndroid = false,
    this.selectedCallBack,
    this.iconWidget,
    this.preSelectedIndex = -1,
    @required this.itemList,
    this.selectionOptionTextStyle,
  }) : super(key: key);

  @override
  _SelectOptionBottomSheetViewState createState() =>
      _SelectOptionBottomSheetViewState(
          selectionOptionTextStyle: selectionOptionTextStyle,
          itemList: itemList,
          isAndroid: isAndroid,
          iconWidget: iconWidget,
          preSelectedIndex: preSelectedIndex);
}

class _SelectOptionBottomSheetViewState
    extends State<SelectOptionBottomSheetView> {
  final TextStyle selectionOptionTextStyle;
  final Widget iconWidget;
  final List<MenuItemModelBottomSheet> itemList;
  final bool isAndroid;
  final int
      preSelectedIndex; //Pre selected index if we want show pre selected index from list it by default -1 means no menu selected
  String selectedItem = "";
  _SelectOptionBottomSheetViewState({
    this.isAndroid = false,
    this.iconWidget,
    this.preSelectedIndex = -1,
    this.itemList,
    this.selectionOptionTextStyle,
  });
  @override
  Widget build(BuildContext context) {
    Widget selectorLabel() {
      TextStyle selectionOptionTextStyleTemp = selectionOptionTextStyle != null
          ? selectionOptionTextStyle
          : TextStyle(color: Colors.black, fontSize: 15);
      return Text(
        widget.textLabel,
        style: selectionOptionTextStyleTemp,
        textAlign: TextAlign.left,
      );
    }

    Widget selectedLabel() {
      TextStyle selectionOptionTextStyleTemp = selectionOptionTextStyle != null
          ? selectionOptionTextStyle
          : TextStyle(color: Colors.black, fontSize: 15);
      return Text(
        selectedItem,
        style: selectionOptionTextStyleTemp,
        textAlign: TextAlign.right,
      );
    }

    Widget icon() {
      return iconWidget != null
          ? iconWidget
          : Icon(
              Icons.arrow_drop_down,
              size: 25.0,
              color: CupertinoColors.black,
            );
    }

    return Material(
        child: Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: InkWell(
        onTap: () {
          /*ConfirmationAlert(
              itemList: itemList,
              alertTitle: widget.textLabel,
              isAndroid: isAndroid,
              context: context,
              noCallback: (alertContext) {},
              callBackYes: (int value) {
                if (widget.selectedCallBack != null) {
                  widget.selectedCallBack(index: value);
                }
                String itemSelected = itemList[value].itemName;
                setState(() {
                  selectedItem = itemSelected;
                });
              });*/

          ActionBottomSheetModal(
            isAndroid: isAndroid,
            alertTitle: "Share option",
            itemList: itemList,
            context: context,
            selectedItemCallBack: (value) {
              if (widget.selectedCallBack != null) {
                widget.selectedCallBack(index: value);
              }
              String itemSelected = itemList[value].itemName;
              setState(() {
                selectedItem = itemSelected;
              });
            },
          );
        },
        child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                child: selectorLabel(),
              ),
              Align(
                  alignment: Alignment.centerRight,
                  child: Row(
                    children: [selectedLabel(), icon()],
                  )),
            ]),
      ),
    ));
  }
}

//******************* Model ***** Start ********************
class MenuItemModelBottomSheet {
  String itemName;
  bool isSelected;
  String itemId;
  MenuItemModelBottomSheet(
      {@required this.itemName, this.isSelected = false, this.itemId = "0"});
}
//******************* Model ***** End ***********************

//****************** Menu List ****** Start ********************
typedef MenuItemListRowCallback = Function(
    {MenuItemModelBottomSheet singleRowData});

class MenuItemListView extends StatefulWidget {
  final List<MenuItemModelBottomSheet> itemList;
  final SelectedBottomSheetCallBack selectedMenuCallBack;
  final double childRowHeight;
  final MenuItemListRowCallback rowView;

  MenuItemListView({
    Key key,
    this.itemList,
    this.selectedMenuCallBack,
    this.rowView,
    this.childRowHeight = 40.0,
  }) : super(key: key);
  @override
  _MenuItemListViewState createState() =>
      _MenuItemListViewState(itemListTemp: itemList);
}

class _MenuItemListViewState extends State<MenuItemListView> {
  List<MenuItemModelBottomSheet> itemList = [];
  int lastSelectedIndex = -1;
  _MenuItemListViewState(
      {List<MenuItemModelBottomSheet> itemListTemp = const []}) {
    itemList.addAll(itemListTemp);
    int i = 0;
    itemList.map((rowData) {
      if (rowData.isSelected) {
        MenuItemModelBottomSheet mMenuItemModel = itemList[i];
        // mMenuItemModel.isSelected = false;
        //itemList[i] = mMenuItemModel;
        lastSelectedIndex = i;
      }
      i++;
    }).toList();
  }
  //Item Tab
  void onItemTab(int index) {
    // if this item isn't selected yet, "isSelected": false -> true
    // If this item already is selected: "isSelected": true -> false
    setState(() {
      if (lastSelectedIndex == -1) {
        lastSelectedIndex = index;
      } else {
        if (lastSelectedIndex != index) {
          itemList[lastSelectedIndex].isSelected = false;
          lastSelectedIndex = index;
        } else if (lastSelectedIndex == index) {
          lastSelectedIndex = -1;
        }
      }
      itemList[index].isSelected = !itemList[index].isSelected;
    });
    //Return selected index
    if (widget.selectedMenuCallBack != null && itemList[index].isSelected) {
      widget.selectedMenuCallBack(index: index);
      //itemList[lastSelectedIndex].isSelected = false;
    } else {
      widget.selectedMenuCallBack(index: -1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: itemList.length,
      itemBuilder: (BuildContext ctx, index) {
        return Container(
          height: widget.childRowHeight,
          child: Card(
              color: Colors.transparent,
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0)),
              child: InkWell(
                onTap: () {
                  onItemTab(index);
                },
                child: widget.rowView != null
                    ? widget.rowView(singleRowData: itemList[index])
                    : Container(),
              )),
        );
      },
    );
  }
}
//****************** Menu List ****** End ********************

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
  List<MenuItemModelBottomSheet> itemList;
  EdgeInsets itemMarginAllSide;
  EdgeInsets itemPaddingAllSide;
  EdgeInsets sheetPaddingAllSide;
  TextStyle styleRowItemAndroid;
  TextStyle styleRowItemIos;
  TextStyle styleRowTitleAndroid;
  TextStyle styleRowTitleIos;
  bool isAndroid;
  static int selectedIndex = -1;
  int selectedIndexLocal = -1;

  ActionBottomSheetModal({
    @required this.context,
    @required this.cancelCallBack,
    @required this.selectedItemCallBack,
    @required this.itemList,
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
    if (selectedIndex != -1) {
      selectedIndexLocal = selectedIndex;
    }
    //Check device platform
    /*if (Platform.isIOS) {
      this.isAndroid = false;
    } else if (Platform.isAndroid) {
      this.isAndroid = true;
    }*/
    _actionBottomSheetModal();
  }

  //Single row of items
  Widget singleItemView({@required String menuName, Color itemColor}) {
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

  Future<void> _actionBottomSheetModal() {
    //Item list view
    Widget titleListView() {
      return Align(
        alignment: Alignment.center,
        child: Container(
          height: 150,
          child: Expanded(
            child: MenuItemListView(
              rowView: ({MenuItemModelBottomSheet singleRowData}) {
                return singleItemView(
                    menuName: singleRowData.itemName); //singleItemView();
              },
              itemList: itemList,
              selectedMenuCallBack: ({index}) {
                selectedIndexLocal = index;
                selectedIndex = selectedIndexLocal;
                if (selectedIndex != -1) {
                  this.selectedItemCallBack(selectedIndex);
                }
                Navigator.pop(context, true);
              },
            ),
          ),
        ),
      );
    }

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
                  children: [/*titleView(),*/ titleListView()],
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
      textColorItem = isAndroid ? Colors.black12 : Colors.blue;
    }
    //Ios
    styleRowItem = this.styleRowItemIos != null
        ? this.styleRowItemIos
        : TextStyle(
            color: textColorItem, fontSize: 17, fontWeight: FontWeight.w600);
    //Android
    if (isAndroid) {
      styleRowItem = this.styleRowItemAndroid != null
          ? this.styleRowItemAndroid
          : TextStyle(
              color: textColorItem, fontSize: 17, fontWeight: FontWeight.w500);
    }
    return styleRowItem;
  }

  TextStyle buildTextStyleTitle({Color textColor}) {
    TextStyle styleText;
    if (textColor == null) {
      textColor = isAndroid ? Colors.black12 : Colors.blueAccent;
    }
    //ios
    styleText = this.styleRowItemIos != null
        ? this.styleRowItemIos
        : TextStyle(
            color: textColor, fontSize: 17, fontWeight: FontWeight.w600);
    //Android
    if (isAndroid) {
      styleText = this.styleRowItemAndroid != null
          ? this.styleRowItemAndroid
          : TextStyle(
              color: textColor, fontSize: 17, fontWeight: FontWeight.w500);
    }
    return styleText;
  }

  TextStyle buildTextStyleCancelTitle({Color textColor}) {
    TextStyle styleText;
    if (textColor == null) {
      textColor = isAndroid ? Colors.black12 : Colors.blueAccent;
    }
    //iOS
    styleText = this.styleRowTitleIos != null
        ? this.styleRowTitleIos
        : TextStyle(
            color: textColor, fontSize: 17, fontWeight: FontWeight.w600);
    //Android
    if (isAndroid) {
      styleText = this.styleRowTitleAndroid != null
          ? this.styleRowTitleAndroid
          : TextStyle(
              color: textColor, fontSize: 17, fontWeight: FontWeight.w500);
    }
    return styleText;
  }
}
