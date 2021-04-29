import 'dart:io';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fullter_main_app/src/api_calling/api_constant.dart';
import 'package:fullter_main_app/src/widgets/android_ios_check_box.dart';
import 'package:fullter_main_app/src/widgets/badge.dart';
import 'package:fullter_main_app/src/widgets/button_clear_with_outline.dart';
import 'package:fullter_main_app/src/widgets/button_solid.dart';
import 'package:fullter_main_app/src/widgets/button_solid_with_outline.dart';
import 'package:fullter_main_app/src/widgets/dividerListCustom.dart';

class ButtonsPage extends StatefulWidget {
  ButtonsPage({Key key}) : super(key: key);
  @override
  _ButtonsPageState createState() => _ButtonsPageState();
}

class _ButtonsPageState extends State<ButtonsPage> {
  Widget buttonView = Column(
    children: [
      ButtonSolid(
        isAndroid: ConstantC.isAndroidPlatform,
        title: "Default",
      ),
      ButtonSolid(
        isAndroid: ConstantC.isAndroidPlatform,
        buttonExpandedType: ButtonExpandedType.BLOCK_WIDTH,
        buttonSize: ButtonSize.LARGE_SIZE,
        title: "Large Size",
      ),
      ButtonSolid(
        isAndroid: ConstantC.isAndroidPlatform,
        buttonExpandedType: ButtonExpandedType.DEFAULT_WIDTH,
        buttonSize: ButtonSize.LARGE_SIZE,
        title: "Large Size Default width",
      ),
      ButtonSolid(
        isAndroid: ConstantC.isAndroidPlatform,
        buttonExpandedType: ButtonExpandedType.DEFAULT_WIDTH,
        buttonSize: ButtonSize.SMALL_SIZE,
        title: "Small",
      ),
      ButtonSolid(
        isAndroid: ConstantC.isAndroidPlatform,
        buttonExpandedType: ButtonExpandedType.FULL_WITH,
        buttonSize: ButtonSize.SMALL_SIZE,
        title: "Small",
      )
    ],
  );

  Widget buttonClearView = Column(
    children: [
      ButtonClearWithOutline(
        isAndroid: ConstantC.isAndroidPlatform,
        title: "Default",
      ),
      ButtonClearWithOutline(
        isAndroid: ConstantC.isAndroidPlatform,
        buttonExpandedType: ButtonExpandedTypeClear.BLOCK_WIDTH,
        buttonSize: ButtonSizeClear.LARGE_SIZE,
        title: "Large Size",
      ),
      ButtonClearWithOutline(
        isAndroid: ConstantC.isAndroidPlatform,
        buttonExpandedType: ButtonExpandedTypeClear.DEFAULT_WIDTH,
        buttonSize: ButtonSizeClear.LARGE_SIZE,
        title: "Large Size Default width",
      ),
      ButtonClearWithOutline(
        isAndroid: ConstantC.isAndroidPlatform,
        buttonExpandedType: ButtonExpandedTypeClear.DEFAULT_WIDTH,
        buttonSize: ButtonSizeClear.SMALL_SIZE,
        title: "Small",
      ),
      ButtonClearWithOutline(
        isAndroid: ConstantC.isAndroidPlatform,
        buttonExpandedType: ButtonExpandedTypeClear.FULL_WITH,
        buttonSize: ButtonSizeClear.SMALL_SIZE,
        title: "Small",
      )
    ],
  );

  Widget buttonSolidWithBorderView = Column(
    children: [
      ButtonSolidWithOutLine(
        Colors.grey,
        title: "Default",
      ),
      ButtonSolidWithOutLine(
        Colors.red,
        borderWidth: 2,
        buttonExpandedType: ButtonExpandedTypeSolidOutline.BLOCK_WIDTH,
        buttonSizeType: ButtonSizeTypeSolidOutline.LARGE_SIZE,
        title: "Large Size",
      ),
      ButtonSolidWithOutLine(
        Colors.grey,
        buttonExpandedType: ButtonExpandedTypeSolidOutline.DEFAULT_WIDTH,
        buttonSizeType: ButtonSizeTypeSolidOutline.LARGE_SIZE,
        title: "Large Size Default width",
      ),
      ButtonSolidWithOutLine(
        Colors.orange,
        borderWidth: 2,
        buttonExpandedType: ButtonExpandedTypeSolidOutline.DEFAULT_WIDTH,
        buttonSizeType: ButtonSizeTypeSolidOutline.SMALL_SIZE,
        title: "Small",
      ),
      ButtonSolidWithOutLine(
        Colors.green,
        borderWidth: 4,
        buttonExpandedType: ButtonExpandedTypeSolidOutline.FULL_WITH,
        buttonSizeType: ButtonSizeTypeSolidOutline.LARGE_SIZE,
        title: "Full With",
      )
    ],
  );
  List<HeaderListModel> listData = [];
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    listData = [
      HeaderListModel(
          isHeaderRow: true, listRowData: {'title': "Solid button"}),
      HeaderListModel(
          isHeaderRow: false,
          listRowData: {'title': "Solid button", 'button_type': 'solid'}),
      HeaderListModel(
          isHeaderRow: false,
          listRowData: {'title': "Solid button", 'button_type': 'solid'}),
      HeaderListModel(
          isHeaderRow: false,
          listRowData: {'title': "Solid button", 'button_type': 'solid'}),
      HeaderListModel(
          isHeaderRow: false,
          listRowData: {'title': "Solid button", 'button_type': 'solid'}),
      HeaderListModel(
          isHeaderRow: true,
          listRowData: {'title': "Solid button with border"}),
      HeaderListModel(isHeaderRow: false, listRowData: {
        'title': "Solid button with border",
        'button_type': 'solid_with_boarder'
      }),
      HeaderListModel(isHeaderRow: false, listRowData: {
        'title': "Solid button with border",
        'button_type': 'solid_with_boarder'
      }),
      HeaderListModel(isHeaderRow: false, listRowData: {
        'title': "Solid button with border",
        'button_type': 'solid_with_boarder'
      }),
      HeaderListModel(isHeaderRow: false, listRowData: {
        'title': "Solid button with border",
        'button_type': 'solid_with_boarder'
      }),
      HeaderListModel(isHeaderRow: false, listRowData: {
        'title': "Solid button with border",
        'button_type': 'solid_with_boarder'
      }),
      HeaderListModel(
          isHeaderRow: true, listRowData: {'title': "Out border button"}),
      HeaderListModel(isHeaderRow: false, listRowData: {
        'title': "Out border button",
        'button_type': 'out_boarder'
      }),
      HeaderListModel(isHeaderRow: false, listRowData: {
        'title': "Out border button",
        'button_type': 'out_boarder'
      }),
      HeaderListModel(isHeaderRow: false, listRowData: {
        'title': "Out border button",
        'button_type': 'out_boarder'
      }),
      HeaderListModel(isHeaderRow: false, listRowData: {
        'title': "Out border button",
        'button_type': 'out_boarder'
      }),
      HeaderListModel(isHeaderRow: false, listRowData: {
        'title': "Out border button",
        'button_type': 'out_boarder'
      }),
    ];

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
            Column(
              children: [
                listItemHead(item: "Solid Button"),
                buttonView,
                SizedBox(
                  height: 10,
                ),
                listItemHead(item: "Solid Button With Out Line"),
                buttonSolidWithBorderView,
                SizedBox(
                  height: 10,
                ),
                listItemHead(item: "Button With Out Line"),
                buttonClearView
              ],
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
                      "Buttons",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  body: Container(
                    color: Colors.white,
                    child: SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        dragStartBehavior: DragStartBehavior.down,
                        child: _centerView()),
                  ),
                ))));
  }
}
