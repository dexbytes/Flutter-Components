import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LabeledCheckboxFlexibleWidth extends StatelessWidget {
  LabeledCheckboxFlexibleWidth({
    Key key,
    @required this.label,
    @required this.padding,
    @required this.value,
    @required this.onChanged,
    this.checkBoxColor = Colors.grey ,        //Check box out side border color in case or non selected check box
    this.checkColor = Colors.white,           // Check rite icon color
    this.checkTextColor = Colors.black,      //Check box text color
    this.checkNonFillColor = Colors.white,  //Non fill color in case of check box not selected
    this.disabled = false,
    this.checkFillColor = Colors.green,    //Fill color
    this.textPadding = 0,    //Fill color
  }) : super(key: key);

  final String label;
  final EdgeInsets padding;
  final bool value;
  final Function onChanged;
  final Color checkColor ;
  final Color checkTextColor ;
  final bool disabled ;
  final Color checkBoxColor;
  final Color checkFillColor ;
  final Color checkNonFillColor;
  final double textPadding;

  @override
  Widget build(BuildContext context) {
    bool isAndroid = false;
    //Check device platform
    if(Platform.isIOS){
      isAndroid = false;
    }
    else if(Platform.isAndroid){
      isAndroid = true;
    }
    //Disabled color
    Color textDisabledColor = Color(0xFFefefef);
    Color checkBoxDisableColor = Color(0xFFefefef);
    Color checkFillDisableColor = isAndroid?(disabled?Color(0xFFefefef):Color(0xFFffffff)):Color(0xFFffffff);
    Color checkDisableColor = Color(0xFFffffff);
    //Ios check box custome
    Widget iosCheckBox = Container(
      padding: EdgeInsets.all(5.0),//I used some padding without fixed width and height
      decoration: BoxDecoration(// You can use like this way or like the below line
          border: Border.all(
              color: disabled?checkBoxDisableColor:(value?checkFillColor:checkBoxColor),
              width: 1.0,
              style: BorderStyle.solid), //Border.all
              borderRadius: BorderRadius.all(
            Radius.circular(50),),color: (value && !disabled)?checkFillColor:!disabled?checkNonFillColor:checkFillDisableColor),
      child: (value && !disabled)?Icon(CupertinoIcons.check_mark,color: checkColor,):Icon(CupertinoIcons.check_mark,color: !disabled?checkNonFillColor:checkDisableColor,),// You can add a Icon instead of text also, like below.
      //child: new Icon(Icons.arrow_forward, size: 50.0, color: Colors.black38)),
    );
    return InkWell(
      onTap: () {
        if(!disabled){
          onChanged(!value);
        }
      },
      child: Padding(
        padding: padding,
        child: Row(
          children: <Widget>[
            isAndroid?Checkbox(checkColor: checkColor,fillColor: MaterialStateProperty.all(!disabled?(value?checkFillColor:checkBoxColor):checkFillDisableColor),
              value: !disabled?value:false,
              onChanged: (bool newValue) {
                onChanged(newValue);
              },
            ):iosCheckBox,SizedBox(width: textPadding,),
            Expanded(child: Text(label,style: TextStyle(color: !disabled?checkTextColor:textDisabledColor),)),
          ],
        ),
      ),
    );
  }
}