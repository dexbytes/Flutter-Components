import 'dart:io';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fullter_main_app/src/api_calling/api_constant.dart';
import 'package:fullter_main_app/src/pages/sign_up_forms/card_sign_up_form.dart';
import 'package:fullter_main_app/src/pages/sign_up_forms/normal_sign_up_form.dart';
import 'package:fullter_main_app/src/pages/sign_up_forms/sign_up_with_social_form.dart';
import 'package:fullter_main_app/src/widgets/android_ios_check_box.dart';
import 'package:fullter_main_app/src/widgets/appbar/tool_bar_widget.dart';
import 'package:fullter_main_app/src/widgets/badge.dart';
import 'package:fullter_main_app/src/widgets/button_solid.dart';
import 'package:fullter_main_app/src/widgets/card_view.dart';
import 'package:fullter_main_app/src/widgets/common_text_field.dart';
import 'package:fullter_main_app/src/widgets/icon_right_with_text.dart';
import 'package:fullter_main_app/src/widgets/input_field.dart';
import 'package:fullter_main_app/src/widgets/labeled_check_box.dart';
import 'package:fullter_main_app/src/widgets/listViewCustom.dart';
import 'package:fullter_main_app/src/widgets/pop_over/popup_menu.dart';
import 'package:fullter_main_app/src/widgets/pop_over/popup_widget_menu.dart';

import 'formpage.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({Key key}) : super(key: key);
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  GlobalKey moreMenuKey = GlobalKey();
  GlobalKey platformMenuKey = GlobalKey();
  PopupMenuSingleChild menuSingleChild;
  int selectedViewType = 1;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  void popupMenu({@required GlobalKey btnKeyObj, int maxColumn = 1}) {
    PopupMenu menu = PopupMenu(
        context: context,
        isAndroid: ConstantC.isAndroidPlatform,
        maxColumn: maxColumn,
        items: [
          MenuItem(title: 'Simple Firm', itemInfo: 1),
          MenuItem(title: 'Simple With Card', itemInfo: 2),
          MenuItem(title: 'SignUp With Social', itemInfo: 3),
        ],
        onClickMenu: (MenuItemProvider item) {
          setState(() {
            selectedViewType = item.menuItemInfo;
          });
          print('Click menu -> ${item.menuTitle}');
        },
        stateChanged: (bool isShow) {
          print('menu is ${isShow ? 'showing' : 'closed'}');
        },
        onDismiss: () {
          print('Menu is dismiss');
        });
    menu.show(widgetKey: btnKeyObj);
  }

  void popupMenuSingleChild(
      {@required GlobalKey btnKeyObj, int maxColumn = 1}) {
    menuSingleChild = PopupMenuSingleChild(
        itemHeight: 70,
        itemWidth: 202,
        context: context,
        isAndroid: ConstantC.isAndroidPlatform,
        maxColumn: maxColumn,
        items: [
          MenuItemSingleChild(
              title: 'Simple Firm',
              childWidget: AndroidIosCheckbox(
                onChanged: () {
                  setState(() {});
                  menuSingleChild.dismiss();
                },
              ))
        ],
        onClickMenu: (MenuItemProviderSingleChild item) {
          print('Click menu -> ${item.menuTitle}');
        },
        stateChanged: (bool isShow) {
          print('menu is ${isShow ? 'showing' : 'closed'}');
        },
        onDismiss: () {
          print('Menu is dismiss');
        });
    menuSingleChild.show(widgetKey: btnKeyObj);
  }

  @override
  Widget build(BuildContext context) {
    //Center View
    Widget _centerView() {
      Widget childView = Container();
      switch (selectedViewType) {
        case 1:
          {
            childView = NormalSignUpPage();
          }
          break;
        case 2:
          {
            childView = CardSignUpPage();
          }
          break;
        case 3:
          {
            childView = CardSignUpWithSocialPage();
          }
          break;
      }

      return childView;
    }

    //Back Press
    _onBackPressed() {
      print("ok");
      Navigator.pop(context);
      print("ok");
    }

    return WillPopScope(
        onWillPop: ConstantC.isAndroidPlatform ? _onBackPressed : null,
        child: Container(
            color: Colors.transparent,
            child: SafeArea(
                bottom: false,
                child: Scaffold(
                  backgroundColor: Colors.white,
                  appBar: ToolBarWidget(
                    isAndroid: ConstantC.isAndroidPlatform,
                    appBarBgColor: Color.fromRGBO(36, 41, 46, 1),
                    titleStyle: TextStyle(color: Colors.white),
                    context: context,
                    title: "SignUp Forms",
                    appBarLeftIcons: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                    onLeftIconPressed: () {
                      Navigator.pop(context);
                    },
                    appBarRightIcons: [
                      GestureDetector(
                        onTap: () {
                          popupMenuSingleChild(btnKeyObj: platformMenuKey);
                        },
                        child: Container(
                          key: platformMenuKey,
                          margin: EdgeInsets.only(right: 5.0),
                          child: Icon(
                            Icons.settings,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          popupMenu(btnKeyObj: moreMenuKey);
                        },
                        child: Container(
                          key: moreMenuKey,
                          margin: EdgeInsets.only(right: 15.0),
                          child: Icon(
                            Icons.more_vert,
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
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