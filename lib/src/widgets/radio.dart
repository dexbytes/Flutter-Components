import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum SingingCharacter { lafayette, jefferson }

class RadioCustom extends StatelessWidget {
  RadioCustom({
    Key key,
    @required this.label,
    @required this.padding,
    @required this.value,
    @required this.onChanged,
    this.radioColor = Colors.grey, // Check rite icon color
    this.checkTextColor = Colors.black, //Check box text color
    this.disabled = false,
    this.isAndroid = false, //Fill color
  }) : super(key: key);

  final String label;
  final EdgeInsets padding;
  final bool value;
  final Function onChanged;
  final Color radioColor;
  final Color checkTextColor;
  final bool disabled;
  final bool isAndroid;

  @override
  Widget build(BuildContext context) {
    /*bool isAndroid = false;
    //Check device platform
    if(Platform.isIOS){
      isAndroid = false;
    }
    else if(Platform.isAndroid){
      isAndroid = true;
    }*/
    //Disabled color
    Color textDisabledColor = Color(0xFFefefef);
    SingingCharacter _character =
        value ? SingingCharacter.jefferson : SingingCharacter.lafayette;
    Widget androidRadio = Radio<SingingCharacter>(
      value: SingingCharacter.jefferson,
      activeColor: radioColor,
      groupValue: _character,
      onChanged: (SingingCharacter clickValue) {
        // bool  valueTemp = value;
        onChanged(!value);
        /* setState(() {
          _character = value;
        });*/
      },
    );

    //Ios check box custom
    Widget iosCheckBox = Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      padding: EdgeInsets.all(
          5.0), //I used some padding without fixed width and height
      decoration: BoxDecoration(
          // You can use like this way or like the below line
          border: Border.all(
              color: Colors.transparent,
              width: 1.0,
              style: BorderStyle.solid), //Border.all
          borderRadius: BorderRadius.all(
            Radius.circular(50),
          ),
          color: Colors.transparent),
      child: (value && !disabled)
          ? Icon(
              CupertinoIcons.checkmark_alt,
              color: radioColor,
            )
          : Icon(
              CupertinoIcons.checkmark_alt,
              color: Colors.transparent,
            ), // You can add a Icon instead of text also, like below.
      //child: new Icon(Icons.arrow_forward, size: 50.0, color: Colors.black38)),
    );
    return InkWell(
      onTap: () {
        if (!disabled) {
          onChanged(!value);
        }
      },
      child: Padding(
        padding: padding,
        child: Row(
          children: <Widget>[
            isAndroid ? androidRadio : iosCheckBox,
            SizedBox(
              width: 30,
            ),
            Expanded(
                child: Text(
              label,
              style: TextStyle(
                  color: !disabled ? checkTextColor : textDisabledColor),
            )),
          ],
        ),
      ),
    );
  }
}
