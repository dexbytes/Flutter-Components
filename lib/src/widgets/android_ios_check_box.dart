import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fullter_main_app/src/api_calling/api_constant.dart';

class AndroidIosCheckbox extends StatefulWidget {
  final Function onChanged;
  AndroidIosCheckbox({Key key, @required this.onChanged //Fill color
      })
      : super(key: key);
  @override
  _AndroidIosCheckbox createState() => _AndroidIosCheckbox();
}

class _AndroidIosCheckbox extends State<AndroidIosCheckbox> {
  @override
  Widget build(BuildContext context) {
    //bool isAndroid = false;
    if (ConstantC.currentPlatform == -1) {
      //Check device platform
      if (Platform.isIOS) {
        ConstantC.isAndroidPlatform = false;
      } else if (Platform.isAndroid) {
        ConstantC.isAndroidPlatform = true;
      }
    } else {
      //Android
      if (ConstantC.currentPlatform == 0) {
        ConstantC.isAndroidPlatform = true;
      }
      //iOS
      if (ConstantC.currentPlatform == 1) {
        ConstantC.isAndroidPlatform = false;
      }
    }

    //Disabled color
    Color checkBoxEmptyColor = Colors.grey;
    Color checkFillColor = Colors.white;

    BoxDecoration decoration(
            {double borderWith = 2, double borderRadius = 25}) =>
        BoxDecoration(
          // You can use like this way or like the below line
          border: Border.all(
              color: Colors.blueGrey,
              width: borderWith,
              style: BorderStyle.solid), //Border.all
          borderRadius: BorderRadius.all(
            Radius.circular(borderRadius),
          ),
          color: Colors.blueGrey,
        );

    BoxDecoration decorationSelected(
            {double borderWith = 1,
            double borderRadius = 25,
            bool selected = false}) =>
        BoxDecoration(
            // You can use like this way or like the below line
            border: Border.all(
                color: selected ? checkBoxEmptyColor : Colors.transparent,
                width: borderWith,
                style: BorderStyle.solid), //Border.all
            borderRadius: BorderRadius.all(
              Radius.circular(borderRadius),
            ),
            color: selected ? checkFillColor : Colors.transparent);

    Widget buildText({String value = "", bool selected = false}) => Container(
          width: 80,
          decoration: decorationSelected(selected: selected),
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          child: Center(
            child: Text(
              value,
              style: TextStyle(
                  fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
                  color: selected ? Colors.black : Colors.grey),
            ),
          ),
        );

    Widget androidIosSelectionOption = Container(
      height: 45,
      width: 180,
      padding: EdgeInsets.symmetric(
          horizontal: 3,
          vertical: 2), //I used some padding without fixed width and height
      decoration: decoration(),
      child: Align(
        alignment: Alignment.center,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              onTap: () {
                ConstantC.currentPlatform = 1;
                ConstantC.isAndroidPlatform = false;
                widget.onChanged();
                setState(() {});
              },
              child: Container(
                child: buildText(
                    value: "iOS", selected: !ConstantC.isAndroidPlatform),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            InkWell(
              onTap: () {
                ConstantC.currentPlatform = 0;
                ConstantC.isAndroidPlatform = true;
                widget.onChanged();
                setState(() {});
              },
              child: Container(
                child: buildText(
                    value: "Android", selected: ConstantC.isAndroidPlatform),
              ),
            )
          ],
        ),
      ), // You can add a Icon instead of text also, like below.
      //child: new Icon(Icons.arrow_forward, size: 50.0, color: Colors.black38)),
    );

    return Padding(
      padding: EdgeInsets.all(10),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[androidIosSelectionOption],
      ),
    );
  }
}
