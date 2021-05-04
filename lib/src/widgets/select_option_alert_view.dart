import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

typedef SelectedAlertCallBack = Function({int index});

class SelectOptionAlertView extends StatefulWidget {
  final String text;
  final String textLabel;
  final TextStyle selectionOptionTextStyle;
  final Widget iconWidget;
  final List<MenuItemModelAlertSelect> itemList;
  final bool isAndroid;
  final SelectedAlertCallBack selectedCallBack;
  final int
      preSelectedIndex; //Pre selected index if we want show pre selected index from list it by default -1 means no menu selected
  SelectOptionAlertView({
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
  _SelectOptionAlertViewState createState() => _SelectOptionAlertViewState(
      selectionOptionTextStyle: selectionOptionTextStyle,
      itemList: itemList,
      isAndroid: isAndroid,
      iconWidget: iconWidget,
      preSelectedIndex: preSelectedIndex);
}

class _SelectOptionAlertViewState extends State<SelectOptionAlertView> {
  final TextStyle selectionOptionTextStyle;
  final Widget iconWidget;
  final List<MenuItemModelAlertSelect> itemList;
  final bool isAndroid;
  final int
      preSelectedIndex; //Pre selected index if we want show pre selected index from list it by default -1 means no menu selected
  String selectedItem = "";
  _SelectOptionAlertViewState({
    this.isAndroid = false,
    this.iconWidget,
    this.preSelectedIndex = -1,
    this.itemList,
    this.selectionOptionTextStyle,
  });
  @override
  Widget build(BuildContext context) {
    /*bool isAndroid = false;
    //Check device platform
    if (Platform.isIOS) {
      isAndroid = false;
    } else if (Platform.isAndroid) {
      isAndroid = true;
    }*/

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
          ConfirmationAlert(
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
              });
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
class MenuItemModelAlertSelect {
  String itemName;
  bool isSelected;
  String itemId;
  MenuItemModelAlertSelect(
      {@required this.itemName, this.isSelected = false, this.itemId = "0"});
}
//******************* Model ***** End ***********************

//****************** Menu List ****** Start ********************
typedef MenuItemListRowCallback = Function(
    {MenuItemModelAlertSelect singleRowData});

class MenuItemListView extends StatefulWidget {
  final List<MenuItemModelAlertSelect> itemList;
  final SelectedAlertCallBack selectedMenuCallBack;
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
  List<MenuItemModelAlertSelect> itemList = [];
  int lastSelectedIndex = -1;
  _MenuItemListViewState(
      {List<MenuItemModelAlertSelect> itemListTemp = const []}) {
    itemList.addAll(itemListTemp);
    int i = 0;
    itemList.map((rowData) {
      if (rowData.isSelected) {
        MenuItemModelAlertSelect mMenuItemModel = itemList[i];
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

//***************************  Alert View *******************
typedef ContextCallback = Function(BuildContext alertContext);

class ConfirmationAlert {
  BuildContext context;
  String alertTitle;
  String positiveActionText;
  String negativeActionText;
  TextStyle textStylePositiveActionIos;
  TextStyle textStyleNegativeActionIos;

  TextStyle textStyleNegativeActionAndroid;
  TextStyle textStylePositiveActionAndroid;

  Function callBackYes;
  ContextCallback noCallback;
  bool isAndroid;
  List<MenuItemModelAlertSelect> itemList;
  double childRowHeight = 40.0;
  double popUpIdemHeight = 0.0;
  //Function onSelection;
  static int selectedIndex = -1;
  int selectedIndexLocal = -1;
  ConfirmationAlert(
      {Key key,
      @required this.context,
      this.alertTitle = "Alert",
      this.positiveActionText = "Yes",
      this.negativeActionText = "No",
      this.textStylePositiveActionIos,
      this.textStyleNegativeActionIos,
      this.itemList = const [],
      this.callBackYes,
      this.isAndroid = false,
      this.noCallback}) {
    if (selectedIndex != -1) {
      selectedIndexLocal = selectedIndex;
    }
    double height = MediaQuery.of(context).size.height;
    height = height - (height / 3);
    popUpIdemHeight = (childRowHeight * itemList.length).toDouble();
    if (popUpIdemHeight > height) {
      popUpIdemHeight = height;
    }
    confirmationAlert();
  }
  Future<bool> confirmationAlert() {
    Widget iOSView({String menuName, bool isSelected = false}) {
      TextStyle mTextStyle = TextStyle(
          color: isSelected ? CupertinoColors.activeBlue : Colors.black);
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            menuName,
            style: mTextStyle,
          ),
          !isSelected
              ? Container()
              : Icon(CupertinoIcons.checkmark_alt,
                  color: CupertinoColors.activeBlue)
        ],
      );
    }

    Widget androidView({String menuName, bool isSelected = false}) {
      TextStyle mTextStyle = TextStyle(
          color: /*isSelected ? CupertinoColors.activeBlue :*/ Colors.black);
      return Row(
        children: [
          isSelected
              ? Icon(Icons.radio_button_on, color: CupertinoColors.activeBlue)
              : Icon(Icons.radio_button_off,
                  color: CupertinoColors.inactiveGray),
          SizedBox(
            width: 15,
          ),
          Text(
            menuName,
            style: mTextStyle,
          )
        ],
      );
    }

    Widget customList = MenuItemListView(
      rowView: ({MenuItemModelAlertSelect singleRowData}) {
        return isAndroid
            ? androidView(
                menuName: singleRowData.itemName,
                isSelected: singleRowData.isSelected)
            : iOSView(
                menuName: singleRowData.itemName,
                isSelected: singleRowData.isSelected);
      },
      itemList: itemList,
      selectedMenuCallBack: ({index}) => selectedIndexLocal = index,
    );
    return showDialog(
        barrierColor: Colors.transparent,
        context: this.context,
        barrierDismissible: false,
        builder: (alertContext) {
          //mContext = context1;
          return this.isAndroid
              ? AlertDialog(
                  // backgroundColor: Colors.transparent,
                  title: new Text(this.alertTitle,
                      style:
                          new TextStyle(color: Colors.black54, fontSize: 20.0)),
                  content: Container(
                    child: customList,
                    height: popUpIdemHeight,
                  ),
                  actions: <Widget>[
                    TextButton(
                      child: buildTextNegativeAction(),
                      onPressed: () {
                        this.noCallback(alertContext);
                        Navigator.pop(alertContext);
                      },
                    ),
                    TextButton(
                      child: buildTextPositiveAction(),
                      onPressed: () {
                        selectedIndex = selectedIndexLocal;
                        if (selectedIndex != -1) {
                          this.callBackYes(selectedIndex);
                        }
                        Navigator.pop(alertContext);
                      },
                    )
                  ],
                )
              : CupertinoAlertDialog(
                  // backgroundColor: Colors.transparent,
                  title: new Text(this.alertTitle,
                      style:
                          new TextStyle(color: Colors.black54, fontSize: 20.0)),
                  content: Container(
                    child: customList,
                    height: popUpIdemHeight,
                  ),
                  actions: <Widget>[
                    TextButton(
                      child: buildTextNegativeAction(),
                      onPressed: () {
                        this.noCallback(alertContext);
                        Navigator.pop(alertContext);
                      },
                    ),
                    TextButton(
                      child: buildTextPositiveAction(),
                      onPressed: () {
                        selectedIndex = selectedIndexLocal;
                        if (selectedIndex != -1) {
                          this.callBackYes(selectedIndex);
                        }
                        Navigator.pop(alertContext);
                      },
                    )
                  ],
                );
        });
  }

  Text buildTextPositiveAction({Color textColorItem}) {
    Text textView;
    /* if (textColorItem == null) {
      textColorItem = isAndroid ? Colors.black : Colors.blue;
    }*/
    //Ios
    textView = textStylePositiveActionIos != null
        ? Text("$positiveActionText", style: textStylePositiveActionIos)
        : Text("$positiveActionText");
    //Android
    if (isAndroid) {
      textView = textStylePositiveActionAndroid != null
          ? Text("$positiveActionText", style: textStylePositiveActionAndroid)
          : Text("$positiveActionText");
    }
    return textView;
  }

  Text buildTextNegativeAction({Color textColorItem}) {
    Text textView;
    /* if (textColorItem == null) {
      textColorItem = isAndroid ? Colors.black : Colors.blue;
    }*/
    //Ios
    textView = textStyleNegativeActionIos != null
        ? Text("$negativeActionText", style: textStyleNegativeActionIos)
        : Text("$negativeActionText");
    //Android
    if (isAndroid) {
      textView = textStyleNegativeActionAndroid != null
          ? Text("$negativeActionText", style: textStylePositiveActionAndroid)
          : Text("$negativeActionText");
    }
    return textView;
  }
}
//*************** Alert View ***** End **************
