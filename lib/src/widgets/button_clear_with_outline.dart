import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum ButtonSizeClear { SMALL_SIZE, DEFAULT_SIZE, LARGE_SIZE }

enum ButtonExpandedTypeClear { DEFAULT_WIDTH, BLOCK_WIDTH, FULL_WITH }

enum ButtonColorTypeClear {
  PRIMARY,
  SECONDARY,
  TERTIARY,
  SUCCESS,
  WARNINGS,
  DANGER,
  LIGHT,
  MEDIUM,
  DARK
}

class ButtonClearWithOutline extends StatelessWidget {
  ButtonClearWithOutline({
    Key key,
    @required this.onPressed,
    this.borderColor,
    this.title = 'DONE',
    this.width = 0.0,
    this.height = 0.0,
    this.borderWidth = 0.0,
    this.textStyle,
    this.btnShape,
    this.btnPadding,
    this.isAndroid = true,
    this.buttonSize = ButtonSizeClear.DEFAULT_SIZE,
    this.buttonExpandedType = ButtonExpandedTypeClear.DEFAULT_WIDTH,
    this.buttonColorType = ButtonColorTypeClear.PRIMARY,
  }) : super(key: key);

  final GestureTapCallback onPressed;

  final String title;
  final double width;
  final double height;
  final double borderWidth;
  final Color borderColor;
  final TextStyle textStyle;
  final ShapeBorder btnShape;
  final EdgeInsetsGeometry btnPadding;
  final bool isAndroid;
  final ButtonSizeClear buttonSize;
  final ButtonExpandedTypeClear buttonExpandedType;
  final ButtonColorTypeClear buttonColorType;

  @override
  Widget build(BuildContext context) {
    /* bool isAndroid = false;
    //Check device platform
    if (Platform.isIOS) {
      isAndroid = false;
    } else if (Platform.isAndroid) {
      isAndroid = true;
    }*/

    Color borderColorGet() {
      Color borderColorTemp = Color(0xff3880ff);
      switch (this.buttonColorType) {
        case ButtonColorTypeClear.SECONDARY:
          borderColorTemp = Color(0xff3dc2ff);
          break;
        case ButtonColorTypeClear.TERTIARY:
          borderColorTemp = Color(0xff5260ff);
          break;
        case ButtonColorTypeClear.SUCCESS:
          borderColorTemp = Color(0xff2dd36f);
          break;
        case ButtonColorTypeClear.WARNINGS:
          borderColorTemp = Color(0xffffc409);
          break;
        case ButtonColorTypeClear.DANGER:
          borderColorTemp = Color(0xffeb445a);
          break;
        case ButtonColorTypeClear.LIGHT:
          borderColorTemp = Color(0xfff4f5f8);
          break;
        case ButtonColorTypeClear.MEDIUM:
          borderColorTemp = Color(0xff92949c);
          break;
        case ButtonColorTypeClear.DARK:
          borderColorTemp = Color(0xff222428);
          break;
        default:
          borderColorTemp = Color(0xff3880ff);
          break;
      }

      borderColorTemp = borderColor != null ? borderColor : borderColorTemp;
      return borderColorTemp;
    }

    //ButtonClearWithOutline text style
    Text buildTextBadge({String buttonValue}) {
      Text textView;
      double textSize = buttonSize == ButtonSizeClear.LARGE_SIZE ? 18 : 16;
      Color badgeValueColor = Colors.black;
      //Set badge text color according selected badge
      TextStyle badgeValueStyle = this.textStyle != null
          ? this.textStyle
          : TextStyle(
              fontSize: textSize,
              color: badgeValueColor,
              fontWeight: FontWeight.w600);

      textView = Text("$buttonValue", style: badgeValueStyle);
      return textView;
    }

    // ButtonClearWithOutline width/height
    BoxConstraints constraints() {
      double widthTemp = 120.0;
      double heightTemp = 47.0;
      if (buttonExpandedType == ButtonExpandedTypeClear.BLOCK_WIDTH) {
        widthTemp = double.maxFinite;
        switch (buttonSize) {
          case ButtonSizeClear.SMALL_SIZE:
            heightTemp = 35;
            break;
          case ButtonSizeClear.LARGE_SIZE:
            heightTemp = 57.0;
            break;
          default:
            heightTemp = 45.0;
        }
      } else if (buttonExpandedType == ButtonExpandedTypeClear.FULL_WITH) {
        widthTemp = double.maxFinite;
        heightTemp = 47.0;
      }
      //Set user specific custom height
      if (width > 0.0) {
        widthTemp = width;
      }
      if (height > 0.0) {
        heightTemp = height;
      }
      return (buttonExpandedType == ButtonExpandedTypeClear.DEFAULT_WIDTH)
          ? BoxConstraints()
          : BoxConstraints.expand(width: widthTemp, height: heightTemp);
    }

    // ButtonClearWithOutline Out Side Padding
    EdgeInsetsGeometry buttonOutSidePadding() {
      double paddingHorizontal = 0.0;
      double paddingVertical = 0.0;
      if (buttonExpandedType == ButtonExpandedTypeClear.DEFAULT_WIDTH) {
        switch (buttonSize) {
          case ButtonSizeClear.SMALL_SIZE:
            paddingHorizontal = 8;
            paddingVertical = 5;
            break;
          case ButtonSizeClear.LARGE_SIZE:
            paddingHorizontal = 8;
            paddingVertical = 15;
            break;
          default:
            paddingHorizontal = 8;
            paddingVertical = 8;
        }
      } else if (buttonExpandedType == ButtonExpandedTypeClear.BLOCK_WIDTH) {
        paddingHorizontal = 15.0;
      } else if (buttonExpandedType == ButtonExpandedTypeClear.FULL_WITH) {
        paddingHorizontal = 5.0;
      }
      return EdgeInsets.symmetric(
          horizontal: paddingHorizontal, vertical: paddingVertical);
    }

    EdgeInsetsGeometry buttonInSidePadding() {
      double paddingHorizontal = 0.0;
      double paddingVertical = 0.0;
      if (buttonExpandedType == ButtonExpandedTypeClear.DEFAULT_WIDTH) {
        switch (buttonSize) {
          case ButtonSizeClear.SMALL_SIZE:
            paddingHorizontal = 8;
            paddingVertical = 5;
            break;
          case ButtonSizeClear.LARGE_SIZE:
            paddingHorizontal = 8;
            paddingVertical = 15;
            break;
          default:
            paddingHorizontal = 8;
            paddingVertical = 8;
        }
      } else if (buttonExpandedType == ButtonExpandedTypeClear.BLOCK_WIDTH) {
        paddingHorizontal = 5.0;
      }
      return EdgeInsets.symmetric(
          horizontal: paddingHorizontal, vertical: paddingVertical);
    }

    ShapeBorder buttonShape() {
      double radius = 10.0;

      double borderWidthTemp =
          borderColor != null ? (borderWidth > 0 ? borderWidth : 1.0) : 0.0;
      Color borderColorTemp = borderColorGet();
      if (buttonExpandedType == ButtonExpandedTypeClear.FULL_WITH) {
        radius = 0;
      }
      return btnShape != null
          ? btnShape
          : RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius),
              side: BorderSide(width: borderWidthTemp, color: borderColorTemp));
    }

    return Padding(
      padding: buttonOutSidePadding(),
      child: RawMaterialButton(
        elevation: 0,
        highlightColor: Colors.grey,
        fillColor: Colors.transparent,
        splashColor: Colors.transparent,
        focusColor: Colors.transparent,
        hoverColor: Colors.transparent,
        constraints: constraints(),
        shape: buttonShape(),
        child: Padding(
          padding: btnPadding == null ? buttonInSidePadding() : btnPadding,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              buildTextBadge(buttonValue: title),
            ],
          ),
        ),
        onPressed: () => onPressed(),
      ),
    );
  }
}
