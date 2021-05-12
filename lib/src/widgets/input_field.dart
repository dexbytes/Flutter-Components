import 'package:flutter/material.dart';

enum KeyboardTypeInputFieldWidget {
  email,
  phone,
  text,
  password,
  number,
  multiLine
}
typedef OnSavedInputFieldWidgetCallBack = Function({String value});
typedef OnChangeInputFieldWidgetCallBack = Function({String value});

class InputFieldWidget extends StatelessWidget {
  final String hintText;
  final TextStyle hintTextStyle;
  final String labelText;
  final TextStyle labelTextStyle;
  final String errorText;
  final OnSavedInputFieldWidgetCallBack onSave;
  final OnChangeInputFieldWidgetCallBack onChange;
  final bool isFloatingLabel;
  final bool stackedLabelColor; //Auto change label color
  final int hintMaxLine;
  final int inPutMaxLine;
  final FocusNode focusNode;
  final int errorMaxLine;
  final KeyboardTypeInputFieldWidget keyboardType;
  final bool isAndroid;
  final Widget prefixIcon;
  final Widget suffixIcon;
  final double prefixIconConstraintSize;
  final double suffixIconConstraintSize;
  final bool isHidPassword;

  InputFieldWidget(
      {Key key,
      this.hintText = "Type Something",
      this.labelText = "Input",
      this.hintMaxLine = 1,
      this.errorMaxLine = 1,
      this.inPutMaxLine = 1,
      this.isAndroid = false,
      this.keyboardType = KeyboardTypeInputFieldWidget.text,
      this.onSave,
      this.onChange,
      this.isFloatingLabel = false,
      this.focusNode,
      this.errorText,
      this.stackedLabelColor = false,
      this.isHidPassword = true,
      this.hintTextStyle,
      this.prefixIcon,
      this.suffixIcon,
      this.labelTextStyle,
      this.prefixIconConstraintSize = 25,
      this.suffixIconConstraintSize = 25})
      : super(key: key);

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

    TextStyle labelStyle() {
      TextStyle mLabelStyle = TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: !stackedLabelColor ? Colors.black54 : null);
      if (this.isAndroid) {
        mLabelStyle = TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: !stackedLabelColor ? Colors.black54 : null);
      }
      //Override user define style
      mLabelStyle = labelTextStyle != null ? labelTextStyle : mLabelStyle;
      return mLabelStyle;
    }

    TextStyle hintStyle() {
      TextStyle mHintStyle = TextStyle(
          fontSize: 16, fontWeight: FontWeight.w500, color: Colors.grey);
      if (this.isAndroid) {
        mHintStyle = TextStyle(
            fontSize: 16, fontWeight: FontWeight.w400, color: Colors.grey);
      }
      //Override user define style
      mHintStyle = hintTextStyle != null ? hintTextStyle : mHintStyle;
      return mHintStyle;
    }

    return TextFormField(
      maxLines: inPutMaxLine,
      focusNode: focusNode,
      obscureText: keyboardType == KeyboardTypeInputFieldWidget.password
          ? isHidPassword
          : false,
      decoration: this.isFloatingLabel
          ? InputDecoration(
              prefixIconConstraints: BoxConstraints(
                  maxWidth: prefixIcon != null ? prefixIconConstraintSize : 0),
              suffixIconConstraints: BoxConstraints(
                  maxWidth: suffixIcon != null ? suffixIconConstraintSize : 0),
              prefixIcon: prefixIcon != null ? prefixIcon : Container(width: 0),
              suffixIcon: suffixIcon != null ? suffixIcon : Container(width: 0),
              labelText: this.labelText,
              labelStyle: labelStyle(),
            )
          : InputDecoration(
              prefixIconConstraints: BoxConstraints(
                  maxWidth: prefixIcon != null ? prefixIconConstraintSize : 0),
              suffixIconConstraints: BoxConstraints(
                  maxWidth: suffixIcon != null ? suffixIconConstraintSize : 0),
              prefixIcon: prefixIcon != null ? prefixIcon : Container(width: 0),
              suffixIcon: suffixIcon != null ? suffixIcon : Container(width: 0),
              floatingLabelBehavior: FloatingLabelBehavior.always,
              labelText: this.labelText,
              labelStyle: labelStyle(),
              hintText: hintText,
              hintStyle: hintStyle(),
              hintMaxLines: this.hintMaxLine,
              errorMaxLines: this.errorMaxLine),
      validator: (String value) => (value.isEmpty) ? errorText : null,
      onSaved: (String value) {
        if (this.onSave != null) {
          this.onSave(value: value);
        }
      },
      onChanged: (value) {
        if (this.onChange != null) {
          this.onChange(value: value);
        }
      },
    );
  }
}
