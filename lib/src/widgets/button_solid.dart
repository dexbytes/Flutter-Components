import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum ButtonSize { SMALL_SIZE, DEFAULT_SIZE, LARGE_SIZE }

enum ButtonExpandedType { DEFAULT_WIDTH, BLOCK_WIDTH, FULL_WITH }

enum ButtonColorType {
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

class ButtonSolid extends StatelessWidget {
  ButtonSolid({
    Key key,
    @required this.onPressed,
    this.title = 'DONE',
    this.width = 0.0,
    this.height = 0.0,
    this.borderWidth = 0.0,
    this.btnBgColor,
    this.textStyle,
    this.btnShape,
    this.elevation = 0.0,
    this.showEffect = true,
    this.btnPadding,
    this.isAndroid = true,
    this.buttonSize = ButtonSize.DEFAULT_SIZE,
    this.buttonExpandedType = ButtonExpandedType.DEFAULT_WIDTH,
    this.buttonColorType = ButtonColorType.PRIMARY,
  }) : super(key: key);

  final GestureTapCallback onPressed;
  final String title;
  final double width;
  final double height;
  final double borderWidth;
  final Color btnBgColor;
  final TextStyle textStyle;
  final bool showEffect;
  final ShapeBorder btnShape;
  final double elevation;
  final EdgeInsetsGeometry btnPadding;
  final bool isAndroid;
  final ButtonSize buttonSize;
  final ButtonExpandedType buttonExpandedType;
  final ButtonColorType buttonColorType;

  @override
  Widget build(BuildContext context) {
    /*bool isAndroid = false;
    //Check device platform
    if (Platform.isIOS) {
      isAndroid = false;
    } else if (Platform.isAndroid) {
      isAndroid = true;
    }*/

    // Set button property accordingly.
    Color fillColor() {
      Color badgeBackgroundColorTemp = Color(0xff3880ff);
      switch (this.buttonColorType) {
        case ButtonColorType.SECONDARY:
          badgeBackgroundColorTemp = Color(0xff3dc2ff);
          break;
        case ButtonColorType.TERTIARY:
          badgeBackgroundColorTemp = Color(0xff5260ff);
          break;
        case ButtonColorType.SUCCESS:
          badgeBackgroundColorTemp = Color(0xff2dd36f);
          break;
        case ButtonColorType.WARNINGS:
          badgeBackgroundColorTemp = Color(0xffffc409);
          break;
        case ButtonColorType.DANGER:
          badgeBackgroundColorTemp = Color(0xffeb445a);
          break;
        case ButtonColorType.LIGHT:
          badgeBackgroundColorTemp = Color(0xfff4f5f8);
          break;
        case ButtonColorType.MEDIUM:
          badgeBackgroundColorTemp = Color(0xff92949c);
          break;
        case ButtonColorType.DARK:
          badgeBackgroundColorTemp = Color(0xff222428);
          break;
        default:
          badgeBackgroundColorTemp = Color(0xff3880ff);
          break;
      }

      badgeBackgroundColorTemp =
          btnBgColor != null ? btnBgColor : badgeBackgroundColorTemp;
      return badgeBackgroundColorTemp;
    }

    //Set Solid Button text style
    Text buildTextBadge({String buttonValue}) {
      Text textView;
      double textSize = buttonSize == ButtonSize.LARGE_SIZE ? 18 : 16;
      Color badgeValueColor = Colors.white;
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

    // ButtonSolid width/height accordingly.
    BoxConstraints constraints() {
      double widthTemp = double.maxFinite;
      double heightTemp = 47.0;
      if (buttonExpandedType == ButtonExpandedType.BLOCK_WIDTH) {
        widthTemp = double.maxFinite;
        switch (buttonSize) {
          case ButtonSize.SMALL_SIZE:
            heightTemp = 35;
            break;
          case ButtonSize.LARGE_SIZE:
            heightTemp = 57.0;
            break;
          default:
            heightTemp = 45.0;
        }
      } else if (buttonExpandedType == ButtonExpandedType.FULL_WITH) {
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
      return (buttonExpandedType == ButtonExpandedType.DEFAULT_WIDTH)
          ? BoxConstraints()
          : BoxConstraints.expand(width: widthTemp, height: heightTemp);
    }

    // ButtonSolid Out Side Padding
    EdgeInsetsGeometry buttonOutSidePadding() {
      double paddingHorizontal = 0.0;
      double paddingVertical = 0.0;
      if (buttonExpandedType == ButtonExpandedType.DEFAULT_WIDTH) {
        switch (buttonSize) {
          case ButtonSize.SMALL_SIZE:
            paddingHorizontal = 8;
            paddingVertical = 5;
            break;
          case ButtonSize.LARGE_SIZE:
            paddingHorizontal = 8;
            paddingVertical = 15;
            break;
          default:
            paddingHorizontal = 8;
            paddingVertical = 8;
        }
      } else if (buttonExpandedType == ButtonExpandedType.BLOCK_WIDTH) {
        paddingHorizontal = 15.0;
      } else if (buttonExpandedType == ButtonExpandedType.FULL_WITH) {
        paddingHorizontal = 5.0;
      }
      return EdgeInsets.symmetric(
          horizontal: paddingHorizontal, vertical: paddingVertical);
    }

    EdgeInsetsGeometry buttonInSidePadding() {
      double paddingHorizontal = 0.0;
      double paddingVertical = 0.0;
      if (buttonExpandedType == ButtonExpandedType.DEFAULT_WIDTH) {
        switch (buttonSize) {
          case ButtonSize.SMALL_SIZE:
            paddingHorizontal = 8;
            paddingVertical = 5;
            break;
          case ButtonSize.LARGE_SIZE:
            paddingHorizontal = 8;
            paddingVertical = 15;
            break;
          default:
            paddingHorizontal = 8;
            paddingVertical = 8;
        }
      } else if (buttonExpandedType == ButtonExpandedType.BLOCK_WIDTH) {
        paddingHorizontal = 5.0;
      }
      return EdgeInsets.symmetric(
          horizontal: paddingHorizontal, vertical: paddingVertical);
    }

    ShapeBorder buttonShape() {
      double radius = 10.0;
      if (buttonExpandedType == ButtonExpandedType.FULL_WITH) {
        radius = 0;
      }
      return btnShape != null
          ? btnShape
          : RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius));
    }

    double elevationGet() {
      double elevationTemp = 0;
      if (elevation > 0) {
        elevationTemp = elevation;
      } else {
        //Set elevation for android platform
        if (isAndroid) {
          elevationTemp = 4;
        }
      }
      return elevationTemp;
    }

    return Padding(
      padding: buttonOutSidePadding(),
      child: RawMaterialButton(
        elevation: elevationGet(),
        highlightColor: fillColor(),
        fillColor: fillColor(),
        splashColor: fillColor(),
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
          // This is a callback function to perform an action.
        onPressed: () => onPressed,
      ),
    );
  }
}
