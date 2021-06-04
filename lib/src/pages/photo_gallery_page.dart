import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fullter_main_app/src/api_calling/api_constant.dart';
import 'package:fullter_main_app/src/pages/photo_gallery/photo_gallery.dart';
import 'package:fullter_main_app/src/pages/sign_up_forms/card_sign_up_form.dart';
import 'package:fullter_main_app/src/pages/sign_up_forms/normal_sign_up_form.dart';
import 'package:fullter_main_app/src/pages/sign_up_forms/sign_up_form_4.dart';
import 'package:fullter_main_app/src/pages/sign_up_forms/sign_up_form_5.dart';
import 'package:fullter_main_app/src/pages/sign_up_forms/sign_up_with_social_form.dart';
import 'package:fullter_main_app/src/widgets/android_ios_check_box.dart';
import 'package:fullter_main_app/src/widgets/appbar/tool_bar_widget.dart';
import 'package:fullter_main_app/src/widgets/pop_over/popup_menu.dart';
import 'package:fullter_main_app/src/widgets/pop_over/popup_widget_menu.dart';

class PhotoGalleryMainPage extends StatefulWidget {
  PhotoGalleryMainPage({Key key}) : super(key: key);
  @override
  _PhotoGalleryMainPageState createState() => _PhotoGalleryMainPageState();
}

class _PhotoGalleryMainPageState extends State<PhotoGalleryMainPage> {
  GlobalKey moreMenuKey = GlobalKey();
  GlobalKey platformMenuKey = GlobalKey();
  PopupMenuSingleChild menuSingleChild;
  int selectedViewType = 1;
  String title = "Photo Gallery";
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
          MenuItem(title: 'Photo Gallery', itemInfo: 1),
          MenuItem(title: 'Photo Gallery2', itemInfo: 2)
        ],
        onClickMenu: (MenuItemProvider item) {
          setState(() {
            selectedViewType = item.menuItemInfo;
            title = item.menuTitle;
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
              title: '',
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
      Widget childView = Container(
        margin: EdgeInsets.only(top: 150),
        child: Center(
            child: Text(
          "Coming soon",
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
        )),
      );
      switch (selectedViewType) {
        case 1:
          {
            childView = PhotoGalleryPage();
          }
          break;
        case 2:
          {
            childView = NormalSignUpPage();
          }
          break;
        case 3:
          {
            childView = CardSignUpWithSocialPage();
          }
          break;

        case 4:
          {
            childView = CardSignUpPage4();
          }
          break;

        case 5:
          {
            childView = CardSignUpPage5();
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
                    title: "$title",
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
                    color: Colors.white70,
                    child: SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        dragStartBehavior: DragStartBehavior.down,
                        child: _centerView()),
                  ),
                ))));
  }
}
