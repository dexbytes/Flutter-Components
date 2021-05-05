import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fullter_main_app/src/api_calling/api_constant.dart';
import 'package:fullter_main_app/src/model/screen_list_model.dart';
import 'package:fullter_main_app/src/pages/action_sheet_page.dart';
import 'package:fullter_main_app/src/pages/alert_page.dart';
import 'package:fullter_main_app/src/pages/badges_page.dart';
import 'package:fullter_main_app/src/pages/buttons_page.dart';
import 'package:fullter_main_app/src/pages/card_page.dart';
import 'package:fullter_main_app/src/pages/check_box_page.dart';
import 'package:fullter_main_app/src/pages/datepicker_page.dart';
import 'package:fullter_main_app/src/pages/divider_avatar_list_page.dart';
import 'package:fullter_main_app/src/pages/divider_icon_list_page.dart';
import 'package:fullter_main_app/src/pages/divider_list_page.dart';
import 'package:fullter_main_app/src/pages/divider_thumnail_list_page.dart';
import 'package:fullter_main_app/src/pages/floating_button_page.dart';
import 'package:fullter_main_app/src/pages/input_field_page.dart';
import 'package:fullter_main_app/src/pages/item_list_page.dart';
import 'package:fullter_main_app/src/pages/custom_switch_page.dart';
import 'package:fullter_main_app/src/pages/tab_bar_page.dart';
import 'package:fullter_main_app/src/pages/search_view_page.dart';
import 'package:fullter_main_app/src/pages/select_page.dart';
import 'package:fullter_main_app/src/pages/toolbar_page.dart';
import 'package:fullter_main_app/src/pages/popover_page.dart';
import 'package:fullter_main_app/src/pages/radio_page.dart';
import 'package:fullter_main_app/src/widgets/DraggableFloatingActionButton.dart';
import 'package:fullter_main_app/src/widgets/android_ios_check_box.dart';

class HomeNewPage extends StatefulWidget {
  HomeNewPage({Key key}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomeNewPage>
    with SingleTickerProviderStateMixin {
  DraggableFloatingActionButtonController
      mDraggableFloatingActionButtonController =
      DraggableFloatingActionButtonController();
  List<ScreenListModel> screenList = [
    ScreenListModel(screen: ActionSheetPage(), title: "Action Sheet"),
    ScreenListModel(screen: AlertPage(), title: "Alert"),
    ScreenListModel(screen: CheckBoxPage(), title: "Checkbox"),
    ScreenListModel(screen: BadgesPage(), title: "Badges"),
    ScreenListModel(screen: ButtonsPage(), title: "Buttons"),
    ScreenListModel(screen: FloatingButtonsPage(), title: "Floating Buttons"),
    ScreenListModel(screen: CardPage(), title: "Card View"),
    ScreenListModel(screen: DatePickerPage(), title: "Date & Time Picker"),
    ScreenListModel(screen: ItemListPage(), title: "Simple Item List"),
    ScreenListModel(screen: DividerListPage(), title: "Divider List"),
    ScreenListModel(screen: DividerIconListPage(), title: "Icon List"),
    ScreenListModel(screen: DividerAvatarListPage(), title: "Avatar List"),
    ScreenListModel(screen: CustomSwitchPage(), title: "Custom Switch"),
    ScreenListModel(screen: RadioPage(), title: "Radio "),
    ScreenListModel(screen: PopoverPage(), title: "PopOver "),
    ScreenListModel(
        screen: DividerThumbnailListPage(), title: "Thumbnail List"),
    ScreenListModel(screen: InputFiledPage(), title: "Input Field"),
    ScreenListModel(screen: TabBarPage(), title: "Tab Bar"),
    ScreenListModel(screen: SelectPage(), title: "Select"),
    ScreenListModel(screen: ToolBarPage(), title: "ToolBar"),
    ScreenListModel(screen: SearchViewPage(), title: "Search"),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //Back Press
    _onBackPressed() {
      if (Platform.isAndroid) {
        SystemNavigator.pop();
      } else if (Platform.isIOS) {
        // exit(0);
        SystemChannels.platform.invokeMethod('SystemNavigator.pop');
      } else {
        exit(0);
      }
    }

    return WillPopScope(
        onWillPop: _onBackPressed,
        child: Container(
            color: Colors.transparent,
            child: SafeArea(
                bottom: false,
                child: Scaffold(
                  backgroundColor: Colors.white,
                  //appBar:_appBar(),
                  body: Container(
                    color: Colors.white,
                    padding: EdgeInsets.only(top: 5),
                    child: Stack(
                      children: [
                        Center(
                          child: Padding(
                            padding: EdgeInsets.only(top: 5),
                            child: ListView.builder(
                                itemCount: screenList.length,
                                itemBuilder: (BuildContext context, int index) {
                                  String title = screenList[index].title;
                                  return InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              screenList[index].screen,
                                        ),
                                      ).then((value) {
                                        try {
                                          setState(() {});
                                        } catch (e) {
                                          print(e);
                                        }
                                      });
                                    },
                                    child: Card(
                                      margin: EdgeInsets.only(
                                          top: 5,
                                          bottom: 5,
                                          right: 10,
                                          left: 10),
                                      color: Colors.blue,
                                      child: Container(
                                          margin: EdgeInsets.only(
                                              top: 15, bottom: 15),
                                          child: Center(
                                              child: Text(
                                            '$title',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600),
                                          ))),
                                    ),
                                  );
                                }),
                          ),
                        ),
                        DraggableFloatingActionButton(
                            controller:
                                mDraggableFloatingActionButtonController,
                            childViewSize: Size(250, 120),
                            childView: AndroidIosCheckbox(
                              onChanged: () {
                                mDraggableFloatingActionButtonController
                                    .callToCollapse();
                                setState(() {});
                              },
                            ),
                            appContext: context,
                            data: 'Demo',
                            offset: new Offset(100, 100),
                            backgroundColor: Colors.white,
                            child: Icon(
                              Icons.wb_incandescent,
                              color: ConstantC.isAndroidPlatform
                                  ? Colors.green
                                  : Colors.yellow,
                            )),
                      ],
                    ),
                  ),
                ))));
  }
}
