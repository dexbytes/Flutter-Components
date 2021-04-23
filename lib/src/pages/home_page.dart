import 'dart:io';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fullter_main_app/src/all_file_import/app_values_files_link.dart';
import 'package:fullter_main_app/src/widgets/extentions.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    AppDimens _appDimens = Provider.of<AppDimens>(context);
    AppStyle _appStyle = Provider.of<AppStyle>(context);
    AppColors _appColors = Provider.of<AppColors>(context);
//  AppFonts _appFonts = Provider.of<AppFonts>(context);
    _appDimens.appDimensFind(context: context);

    Widget _icon(IconData icon, {Color color}) {
      return Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(13)),
            color: Theme.of(context).backgroundColor,
            boxShadow: _appStyle.shadow),
        child: Icon(
          icon,
          color: color != null ? color : _appColors.iconColor,
        ),
      ).ripple(() {}, borderRadius: BorderRadius.all(Radius.circular(13)));
    }

    Widget _search() {
      return Container(
        margin: _appDimens.marginPaddingVertical(),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Container(
                height: 40,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Provider.of<AppColors>(context).editTextBgColor,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: TextField(
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Search Products",
                      hintStyle: TextStyle(fontSize: 12),
                      contentPadding: EdgeInsets.only(
                          left: 10, right: 10, bottom: 0, top: 5),
                      prefixIcon: Icon(Icons.search, color: Colors.black54)),
                ),
              ),
            ),
            SizedBox(width: 20),
            _icon(Icons.filter_list, color: Colors.black54)
          ],
        ),
      );
    }

    //Center View
    Widget _centerView() {
      return Container(
        child: Column(
          children: <Widget>[
            _search(),
            Text("Flutter Demo Text 1"),
            Text(
              "Flutter Demo Text 2",
              style:
                  _appStyle.h1Style(texColor: _appColors.textNormalColor[600]),
            )
          ],
        ),
      );
    }

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
            color: _appColors.appStatusBarColor[700],
            child: SafeArea(
                bottom: false,
                child: Scaffold(
                  //appBar:_appBar(),
                  body: Container(
                    color: _appColors.appBgColor,
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      dragStartBehavior: DragStartBehavior.down,
                      child: _centerView(),
                    ),
                  ),
                ))));
  }
}
