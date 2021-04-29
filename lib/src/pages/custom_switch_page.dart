import 'dart:io';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fullter_main_app/src/api_calling/api_constant.dart';
import 'package:fullter_main_app/src/widgets/DraggableFloatingActionButton.dart';
import 'package:fullter_main_app/src/widgets/android_ios_check_box.dart';
import 'package:fullter_main_app/src/widgets/badge.dart';
import 'package:fullter_main_app/src/widgets/custom_switch.dart';
import 'package:fullter_main_app/src/widgets/icon_right_with_text.dart';
import 'package:fullter_main_app/src/widgets/labeled_check_box.dart';
import 'package:fullter_main_app/src/widgets/listViewCustom.dart';

class CustomSwitchPage extends StatefulWidget {
  CustomSwitchPage({Key key}) : super(key: key);
  @override
  _CustomSwitchPageState createState() => _CustomSwitchPageState();
}

class _CustomSwitchPageState extends State<CustomSwitchPage> {
  bool status1 = false;
  bool status2 = true;
  bool status3 = false;
  bool status4 = false;
  bool status5 = false;
  bool status6 = false;
  bool status7 = false;
  bool status8 = false;
  bool isSwitchOn = false;

  Color _textColor = Colors.black;
  Color _appBarColor = Color.fromRGBO(36, 41, 46, 1);
  Color __scaffoldBgColor = Colors.white;

  DraggableFloatingActionButtonController
      mDraggableFloatingActionButtonController =
      DraggableFloatingActionButtonController();

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        textTheme: TextTheme(
          bodyText1: TextStyle(color: _textColor),
          bodyText2: TextStyle(color: _textColor),
        ),
      ),
      child: Scaffold(
        backgroundColor: __scaffoldBgColor,
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(36, 41, 46, 1),
          title: Text(
            "CustomSwitch Demo",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("Default"),
                    SizedBox(height: 10.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        CustomSwitch(
                          isAndroid: ConstantC.isAndroidPlatform,
                          value: status1,
                          onToggle: (val) {
                            setState(() {
                              status1 = val;
                            });
                          },
                        ),
                        Container(
                          alignment: Alignment.centerRight,
                          child: Text(
                            "Value: $status1",
                          ),
                        ),
                      ],
                    ),
                    Text("Default"),
                    SizedBox(height: 10.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        CustomSwitch(
                          isAndroid: ConstantC.isAndroidPlatform,
                          value: status1,
                          onToggle: (val) {
                            setState(() {
                              status1 = val;
                            });
                          },
                        ),
                        Container(
                          alignment: Alignment.centerRight,
                          child: Text(
                            "Value: $status1",
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.0),
                    Text("Custom Colors and Borders"),
                    SizedBox(height: 10.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        CustomSwitch(
                          isAndroid: ConstantC.isAndroidPlatform,
                          width: 100.0,
                          height: 55.0,
                          toggleSize: 45.0,
                          value: status2,
                          borderRadius: 30.0,
                          padding: 2.0,
                          toggleColor: Color.fromRGBO(225, 225, 225, 1),
                          switchBorder: Border.all(
                            color: Color.fromRGBO(2, 107, 206, 1),
                            width: 6.0,
                          ),
                          toggleBorder: Border.all(
                            color: Color.fromRGBO(2, 107, 206, 1),
                            width: 5.0,
                          ),
                          activeColor: Color.fromRGBO(51, 226, 255, 1),
                          inactiveColor: Colors.black38,
                          onToggle: (val) {
                            setState(() {
                              status2 = val;
                            });
                          },
                        ),
                        Container(
                          alignment: Alignment.centerRight,
                          child: Text(
                            "Value: $status2",
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.0),
                    Text("With 'On' and 'Off' text and custom text colors"),
                    SizedBox(height: 10.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        CustomSwitch(
                          isAndroid: ConstantC.isAndroidPlatform,
                          showOnOff: true,
                          activeTextColor: Colors.black,
                          inactiveTextColor: Colors.blue[50],
                          value: status3,
                          onToggle: (val) {
                            setState(() {
                              status3 = val;
                            });
                          },
                        ),
                        Container(
                          alignment: Alignment.centerRight,
                          child: Text(
                            "Value: $status3",
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.0),
                    Text("Custom size"),
                    SizedBox(height: 10.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        CustomSwitch(
                          isAndroid: ConstantC.isAndroidPlatform,
                          width: 55.0,
                          height: 25.0,
                          valueFontSize: 12.0,
                          toggleSize: 18.0,
                          value: status4,
                          onToggle: (val) {
                            setState(() {
                              status4 = val;
                            });
                          },
                        ),
                        Container(
                          alignment: Alignment.centerRight,
                          child: Text(
                            "Value: $status4",
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.0),
                    Text("Custom border radius and padding"),
                    SizedBox(height: 10.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        CustomSwitch(
                          isAndroid: ConstantC.isAndroidPlatform,
                          width: 125.0,
                          height: 55.0,
                          valueFontSize: 25.0,
                          toggleSize: 45.0,
                          value: status5,
                          borderRadius: 30.0,
                          padding: 8.0,
                          showOnOff: true,
                          onToggle: (val) {
                            setState(() {
                              status5 = val;
                            });
                          },
                        ),
                        Container(
                          alignment: Alignment.centerRight,
                          child: Text(
                            "Value: $status5",
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.0),
                    Text("Custom text"),
                    SizedBox(height: 10.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        CustomSwitch(
                          isAndroid: ConstantC.isAndroidPlatform,
                          activeText: "All Good. Negative.",
                          inactiveText: "Under Quarantine.",
                          value: status6,
                          valueFontSize: 10.0,
                          width: 110,
                          borderRadius: 30.0,
                          showOnOff: true,
                          onToggle: (val) {
                            setState(() {
                              status6 = val;
                            });
                          },
                        ),
                        Container(
                          alignment: Alignment.centerRight,
                          child: Text(
                            "Value: $status6",
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.0),
                    Text("Icon in toggle"),
                    Text(
                      "Inspired by the colors from Github Dark Mode switch",
                      style: TextStyle(
                        fontSize: 12.0,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        CustomSwitch(
                          isAndroid: ConstantC.isAndroidPlatform,
                          width: 100.0,
                          height: 55.0,
                          toggleSize: 45.0,
                          value: status7,
                          borderRadius: 30.0,
                          padding: 2.0,
                          activeToggleColor: Color(0xFF6E40C9),
                          inactiveToggleColor: Color(0xFF2F363D),
                          activeSwitchBorder: Border.all(
                            color: Color(0xFF3C1E70),
                            width: 6.0,
                          ),
                          inactiveSwitchBorder: Border.all(
                            color: Color(0xFFD1D5DA),
                            width: 6.0,
                          ),
                          activeColor: Color(0xFF271052),
                          inactiveColor: Colors.white,
                          activeIcon: Icon(
                            Icons.nightlight_round,
                            color: Color(0xFFF8E3A1),
                          ),
                          inactiveIcon: Icon(
                            Icons.wb_sunny,
                            color: Color(0xFFFFDF5D),
                          ),
                          onToggle: (val) {
                            setState(() {
                              status7 = val;

                              if (val) {
                                _textColor = Colors.white;
                                _appBarColor = Color.fromRGBO(22, 27, 34, 1);
                                __scaffoldBgColor = Color(0xFF0D1117);
                              } else {
                                _textColor = Colors.black;
                                _appBarColor = Color.fromRGBO(36, 41, 46, 1);
                                __scaffoldBgColor = Colors.white;
                              }
                            });
                          },
                        ),
                        Container(
                          alignment: Alignment.centerRight,
                          child: Text("Value: $status7"),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.0),
                    Text("Image as toggle icon"),
                    SizedBox(height: 10.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        CustomSwitch(
                          isAndroid: ConstantC.isAndroidPlatform,
                          width: 100.0,
                          height: 55.0,
                          toggleSize: 45.0,
                          value: status8,
                          borderRadius: 30.0,
                          padding: 2.0,
                          activeToggleColor: Color(0xFF0082C8),
                          inactiveToggleColor: Color(0xFF01579B),
                          activeSwitchBorder: Border.all(
                            color: Color(0xFF00D2B8),
                            width: 6.0,
                          ),
                          inactiveSwitchBorder: Border.all(
                            color: Color(0xFF29B6F6),
                            width: 6.0,
                          ),
                          activeColor: Color(0xFF55DDCA),
                          inactiveColor: Color(0xFF54C5F8),
                          activeIcon: Image.network(
                            "https://img2.pngio.com/functional-bits-in-flutter-flutter-community-medium-flutter-png-1000_1000.png",
                          ),
                          inactiveIcon: Image.network(
                            "https://upload.wikimedia.org/wikipedia/commons/7/7e/Dart-logo.png",
                          ),
                          onToggle: (val) {
                            setState(() {
                              status8 = val;
                            });
                          },
                        ),
                        Container(
                          alignment: Alignment.centerRight,
                          child: Text("Value: $status8"),
                        ),
                      ],
                    ),
                  ],
                ),
                DraggableFloatingActionButton(
                    controller: mDraggableFloatingActionButtonController,
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
                    ) /*,
                            childSelected: new Icon(
                              Icons.wb_incandescent,
                              color: Colors.green,
                            )*/
                    ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
