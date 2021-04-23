import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fullter_main_app/src/all_file_import/app_values_files_link.dart';
import 'package:fullter_main_app/src/all_file_import/app_widget_files_link.dart';
import 'package:fullter_main_app/src/pages/home_page.dart';
import 'package:fullter_main_app/src/state/appState.dart';
import 'package:fullter_main_app/src/widgets/BottomNavigationBar/bottom_navigation_bar.dart';
import 'package:provider/provider.dart';

class MainPage extends StatefulWidget {
  MainPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int isHomePageSelected = 0;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
     /* var state = Provider.of<AppState>(context, listen: false);
      state.setPageIndex = 0;*/
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppDimens _appDimens = Provider.of<AppDimens>(context);
//    AppStyle _appStyle = Provider.of<AppStyle>(context);
    AppColors _appColors = Provider.of<AppColors>(context);
//    AppFonts _appFonts = Provider.of<AppFonts>(context);

    _appDimens.appDimensFind(context: context);

    //App Bar
    Widget _appBar() {

      Widget appBar = BackArrowWithRightIcon(
          appBarBgColor: _appColors.appBarBgColor,
          backArrowImage: null,
          title: "Home",
          statusBarHeight: _appDimens.widthDynamic(value: 12),
          appBarRightIcons: /*[rightNotigicationIcon]*/null,
          leftIconSize: _appDimens.iconSquareCustom(value: 25),  appBar: false,context: context,onLeftIconPressed:()
      {
        Navigator.pop(context,true);
      }
      );
      switch(isHomePageSelected){
        case 0:{

          appBar = BackArrowWithRightIcon(
              appBarBgColor: _appColors.appBarBgColor,
              backArrowImage: null,
              title: "Home",
              statusBarHeight: _appDimens.widthDynamic(value: 12),
              appBarRightIcons: /*[rightNotigicationIcon]*/null,
              leftIconSize: _appDimens.iconSquareCustom(value: 25),  appBar: false,context: context,onLeftIconPressed:()
          {
            Navigator.pop(context,true);
          }
          );
          break;
        }

        case 1:{

          appBar = BackArrowWithRightIcon(
              appBarBgColor: _appColors.appBarBgColor,
              backArrowImage: null,
              title: "Search",
              statusBarHeight: _appDimens.widthDynamic(value: 12),
              appBarRightIcons: /*[rightNotigicationIcon]*/null,
              leftIconSize: _appDimens.iconSquareCustom(value: 25),  appBar: false,context: context,onLeftIconPressed:()
          {
            Navigator.pop(context,true);
          }
          );
          break;
        }

        case 2:{

          appBar = BackArrowWithRightIcon(
              appBarBgColor: _appColors.appBarBgColor,
              backArrowImage: null,
              title: "Another",
              statusBarHeight: _appDimens.widthDynamic(value: 12),
              appBarRightIcons: /*[rightNotigicationIcon]*/null,
              leftIconSize: _appDimens.iconSquareCustom(value: 25),  appBar: false,context: context,onLeftIconPressed:()
          {
            Navigator.pop(context,true);
          }
          );
          break;
        }
      }

      return appBar;
    }

    //Bottom menu
   void onBottomIconPressed(int index) {
     var state = Provider.of<AppState>(context);
     state.setPageIndex = index;

      setState(() {
        isHomePageSelected = Provider.of<AppState>(context).pageIndex;
      });
    }

    //Center View
    Widget _centerView(){
      //Screens
      List<Widget> selectedScreensOnBottomMenu = <Widget>[
        MyHomePage(),
        MyHomePage(),
        MyHomePage(),
        Container(),
        MyHomePage(),
      ];

      return  AnimatedSwitcher(
          duration: Duration(milliseconds: 300),
          switchInCurve: Curves.easeInToLinear,
          switchOutCurve: Curves.easeOutBack,
          child: selectedScreensOnBottomMenu[isHomePageSelected]
      );
    }

    //Back Press
    _onBackPressed() {
      if (Platform.isAndroid) {
        SystemNavigator.pop();
      }
      else if(Platform.isIOS) {
        // exit(0);
        SystemChannels.platform.invokeMethod('SystemNavigator.pop');
      }else{
        exit(0);
      }
    }

    return
      WillPopScope(
          onWillPop: _onBackPressed,
          child: Container(
              color: _appColors.appStatusBarColor[700],
              child: SafeArea(
                  bottom: false,
                  child:Scaffold(
                    appBar:_appBar(),
                    body: Container(
                      color: _appColors.appBgColor,
                      child: _centerView(),
                    ),
                    bottomNavigationBar: SafeArea(
                        child: Container(
                          child: CustomBottomNavigationBar(
                            onIconPresedCallback: onBottomIconPressed,
                          ),
                        )),
                  ))));
  }
}
