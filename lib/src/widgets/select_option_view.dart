import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

typedef SelectedCallBack = Function({int index});

class SelectOptionView extends StatefulWidget {
  final String text;
  final String textLabel;
  final TextStyle selectionOptionTextStyle;
  final Widget iconWidget;
  final List<String> itemList;
  final bool isAndroid;
  final SelectedCallBack selectedCallBack;
  final int
      preSelectedIndex; //Pre selected index if we want show pre selected index from list it by default -1 means no menu selected
  SelectOptionView({
    Key key,
    this.text,
    this.textLabel = "",
    this.isAndroid = false,
    this.selectedCallBack,
    this.iconWidget,
    this.preSelectedIndex = -1,
    this.itemList = const [
      "Followers",
      "Like",
      "Share",
      "Completed",
      "Warning",
      "Notification",
      "Unread"
          "Draft",
      "Deleted"
    ],
    this.selectionOptionTextStyle,
  }) : super(key: key);

  @override
  _SelectOptionViewState createState() => _SelectOptionViewState(
      selectionOptionTextStyle: selectionOptionTextStyle,
      itemList: itemList,
      isAndroid: isAndroid,
      iconWidget: iconWidget,
      preSelectedIndex: preSelectedIndex);
}

class _SelectOptionViewState extends State<SelectOptionView> {
  final TextStyle selectionOptionTextStyle;
  final Widget iconWidget;
  final List<String> itemList;
  final bool isAndroid;
  final int
      preSelectedIndex; //Pre selected index if we want show pre selected index from list it by default -1 means no menu selected
  String selectedItem = "Selected";
  _SelectOptionViewState({
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
                String itemSelected = itemList[value];
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

//Selected menu call back function type
typedef ContextCallback = Function(BuildContext alertContext);

class ConfirmationAlert {
  BuildContext context;
  String alertTitle;
  String message;
  String positiveActionText;
  String negativeActionText;
  TextStyle textStylePositiveActionIos;
  TextStyle textStyleNegativeActionIos;

  TextStyle textStyleNegativeActionAndroid;
  TextStyle textStylePositiveActionAndroid;

  Function callBackYes;
  ContextCallback noCallback;
  bool isAndroid;
  List<String> itemList;
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
      this.message = "This is confirmation alert",
      this.textStylePositiveActionIos,
      this.textStyleNegativeActionIos,
      this.itemList = const [],
      this.callBackYes,
      this.isAndroid = false,
      this.noCallback})
      : assert(message != null) {
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
    Widget customList = ListView.separated(
        separatorBuilder: (context, index) => Divider(
              color: Colors.transparent,
              height: 0.0,
              indent: 0.0,
              endIndent: 0.0,
            ),
        //controller: scrollController,
        //padding: listViewEdgeInsets,
        physics: AlwaysScrollableScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: itemList.length,
        itemBuilder: (context, i) {
          String menuName = itemList[i];
          Widget tempRowView1 = Container(
            height: childRowHeight,
            child: GestureDetector(
                onTap: () {
                  selectedIndexLocal = i;
                },
                child: Center(child: Text(menuName))),
          );
          Widget tempRowView = tempRowView1;
          return tempRowView;
        });

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
                  content: customList,
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
                        this.callBackYes(alertContext);
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
