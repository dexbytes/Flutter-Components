import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum ButtonSizeTypeSolidOutline { SMALL_SIZE, DEFAULT_SIZE, LARGE_SIZE }

enum ButtonExpandedTypeSolidOutline { DEFAULT_WIDTH, BLOCK_WIDTH, FULL_WITH }

enum ButtonColorTypeSolidOutline {
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

class ButtonSolidWithOutLine extends StatelessWidget {
  ButtonSolidWithOutLine(
    this.borderColor, {
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
    this.buttonSizeType = ButtonSizeTypeSolidOutline.DEFAULT_SIZE,
    this.buttonExpandedType = ButtonExpandedTypeSolidOutline.DEFAULT_WIDTH,
    this.buttonColorType = ButtonColorTypeSolidOutline.PRIMARY,
  }) : super(key: key);

  final GestureTapCallback onPressed;

  final String title;
  final double width;
  final double height;
  final double borderWidth;
  final Color btnBgColor;
  final Color borderColor;
  final TextStyle textStyle;
  final bool showEffect;
  final ShapeBorder btnShape;
  final double elevation;
  final EdgeInsetsGeometry btnPadding;
  final bool isAndroid;
  final ButtonSizeTypeSolidOutline buttonSizeType;
  final ButtonExpandedTypeSolidOutline buttonExpandedType;
  final ButtonColorTypeSolidOutline buttonColorType;

  @override
  Widget build(BuildContext context) {
    bool isAndroid = false;
    //Check device platform
    if (Platform.isIOS) {
      isAndroid = false;
    } else if (Platform.isAndroid) {
      isAndroid = true;
    }

    // Set badget background color
    Color fillColor() {
      Color badgeBackgroundColorTemp = Color(0xff3880ff);
      switch (this.buttonColorType) {
        case ButtonColorTypeSolidOutline.SECONDARY:
          badgeBackgroundColorTemp = Color(0xff3dc2ff);
          break;
        case ButtonColorTypeSolidOutline.TERTIARY:
          badgeBackgroundColorTemp = Color(0xff5260ff);
          break;
        case ButtonColorTypeSolidOutline.SUCCESS:
          badgeBackgroundColorTemp = Color(0xff2dd36f);
          break;
        case ButtonColorTypeSolidOutline.WARNINGS:
          badgeBackgroundColorTemp = Color(0xffffc409);
          break;
        case ButtonColorTypeSolidOutline.DANGER:
          badgeBackgroundColorTemp = Color(0xffeb445a);
          break;
        case ButtonColorTypeSolidOutline.LIGHT:
          badgeBackgroundColorTemp = Color(0xfff4f5f8);
          break;
        case ButtonColorTypeSolidOutline.MEDIUM:
          badgeBackgroundColorTemp = Color(0xff92949c);
          break;
        case ButtonColorTypeSolidOutline.DARK:
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

    //buttonSolidWithOutLine text style
    Text buildTextBadge({String buttonValue}) {
      Text textView;
      double textSize =
          buttonSizeType == ButtonSizeTypeSolidOutline.LARGE_SIZE ? 18 : 16;
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

    // buttonSolidWithOutLine width/height
    BoxConstraints constraints() {
      double widthTemp = 120.0;
      double heightTemp = 47.0;
      if (buttonExpandedType == ButtonExpandedTypeSolidOutline.BLOCK_WIDTH) {
        widthTemp = double.maxFinite;
        switch (buttonSizeType) {
          case ButtonSizeTypeSolidOutline.SMALL_SIZE:
            heightTemp = 35;
            break;
          case ButtonSizeTypeSolidOutline.LARGE_SIZE:
            heightTemp = 57.0;
            break;
          default:
            heightTemp = 45.0;
        }
      } else if (buttonExpandedType ==
          ButtonExpandedTypeSolidOutline.FULL_WITH) {
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
      return (buttonExpandedType ==
              ButtonExpandedTypeSolidOutline.DEFAULT_WIDTH)
          ? BoxConstraints()
          : BoxConstraints.expand(width: widthTemp, height: heightTemp);
    }

    // buttonSolidWithOutLine Out Side Padding
    EdgeInsetsGeometry buttonOutSidePadding() {
      double paddingHorizontal = 0.0;
      double paddingVertical = 0.0;
      if (buttonExpandedType == ButtonExpandedTypeSolidOutline.DEFAULT_WIDTH) {
        switch (buttonSizeType) {
          case ButtonSizeTypeSolidOutline.SMALL_SIZE:
            paddingHorizontal = 8;
            paddingVertical = 5;
            break;
          case ButtonSizeTypeSolidOutline.LARGE_SIZE:
            paddingHorizontal = 8;
            paddingVertical = 15;
            break;
          default:
            paddingHorizontal = 8;
            paddingVertical = 8;
        }
      } else if (buttonExpandedType ==
          ButtonExpandedTypeSolidOutline.BLOCK_WIDTH) {
        paddingHorizontal = 15.0;
      } else if (buttonExpandedType ==
          ButtonExpandedTypeSolidOutline.FULL_WITH) {
        paddingHorizontal = 5.0;
      }
      return EdgeInsets.symmetric(
          horizontal: paddingHorizontal, vertical: paddingVertical);
    }

    // Set buttonInSide Padding
    EdgeInsetsGeometry buttonInSidePadding() {
      double paddingHorizontal = 0.0;
      double paddingVertical = 0.0;
      if (buttonExpandedType == ButtonExpandedTypeSolidOutline.DEFAULT_WIDTH) {
        switch (buttonSizeType) {
          case ButtonSizeTypeSolidOutline.SMALL_SIZE:
            paddingHorizontal = 8;
            paddingVertical = 5;
            break;
          case ButtonSizeTypeSolidOutline.LARGE_SIZE:
            paddingHorizontal = 8;
            paddingVertical = 15;
            break;
          default:
            paddingHorizontal = 8;
            paddingVertical = 8;
        }
      } else if (buttonExpandedType ==
          ButtonExpandedTypeSolidOutline.BLOCK_WIDTH) {
        paddingHorizontal = 5.0;
      }
      return EdgeInsets.symmetric(
          horizontal: paddingHorizontal, vertical: paddingVertical);
    }

    ShapeBorder buttonShape() {
      double radius = 10.0;
      double borderWidthTemp =
          borderColor != null ? (borderWidth > 0 ? borderWidth : 1.0) : 0.0;
      Color borderColorTemp =
          borderColor != null ? borderColor : Colors.transparent;
      if (buttonExpandedType == ButtonExpandedTypeSolidOutline.FULL_WITH) {
        radius = 0;
      }
      return btnShape != null
          ? btnShape
          : RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius),
              side: BorderSide(width: borderWidthTemp, color: borderColorTemp));
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
