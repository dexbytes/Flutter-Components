import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum BadgeType {
  FOLLOWERS,
  LIKE,
  SHARE,
  COMPLETED,
  WARNINGS,
  NOTIFICATION,
  UNREAD,
  DRAFT,
  DELETED
}

class Badge extends StatelessWidget {
  Badge({
    Key key,
    this.padding = const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
    this.margin = const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
    this.badgeValue = "-1",
    this.badgeType = BadgeType.FOLLOWERS,
    this.onChanged, //Check box out side border color in case or non selected check box
    this.isAndroid = false,
    this.badgeBackgroundColor,
    this.badgeValueStyle, //Fill color
  }) : super(key: key);

  final EdgeInsets padding;
  final BadgeType badgeType;
  final EdgeInsets margin;
  final String badgeValue;
  final TextStyle badgeValueStyle;
  final Function onChanged;
  final Color badgeBackgroundColor;
  final bool isAndroid;

  @override
  Widget build(BuildContext context) {
    /*bool isAndroid = false;
    //Check device platform
    if (Platform.isIOS) {
      isAndroid = false;
    } else if (Platform.isAndroid) {
      isAndroid = true;
    }*/

    // Badge
    BoxDecoration badgeDecorationStyle(
        {double borderWith = 1, double borderRadius = 15}) {
      borderRadius = isAndroid ? 5 : 15;
      Color badgeBackgroundColorTemp = Color(0xff3880ff);
      switch (this.badgeType) {
        case BadgeType.LIKE:
          badgeBackgroundColorTemp = Color(0xff3dc2ff);
          break;
        case BadgeType.SHARE:
          badgeBackgroundColorTemp = Color(0xff5260ff);
          break;
        case BadgeType.COMPLETED:
          badgeBackgroundColorTemp = Color(0xff2dd36f);
          break;
        case BadgeType.WARNINGS:
          badgeBackgroundColorTemp = Color(0xffffc409);
          break;
        case BadgeType.NOTIFICATION:
          badgeBackgroundColorTemp = Color(0xffeb445a);
          break;
        case BadgeType.UNREAD:
          badgeBackgroundColorTemp = Color(0x00ffffff);
          break;
        case BadgeType.DRAFT:
          badgeBackgroundColorTemp = Color(0xff92949c);
          break;
        case BadgeType.DELETED:
          badgeBackgroundColorTemp = Color(0xff222428);
          break;
        default:
          badgeBackgroundColorTemp = Color(0xff3880ff);
          break;
      }

      badgeBackgroundColorTemp = badgeBackgroundColor != null
          ? badgeBackgroundColor
          : badgeBackgroundColorTemp;

      return BoxDecoration(
          // You can use like this way or like the below line
          border: Border.all(
              color: badgeBackgroundColorTemp,
              width: borderWith,
              style: BorderStyle.solid),
          borderRadius: BorderRadius.all(
            Radius.circular(borderRadius),
          ),
          color: badgeBackgroundColorTemp);
    }

    //Badge text style
    Text buildTextBadge({String badgeValue}) {
      Text textView;
      Color badgeValueColor = Colors.white;
      //Set badge text color according selected badge
      switch (this.badgeType) {
        case BadgeType.UNREAD:
          badgeValueColor = Colors.black;
          break;
        case BadgeType.WARNINGS:
          badgeValueColor = Colors.black;
          break;
        default:
          badgeValueColor = Colors.white;
          break;
      }

      TextStyle badgeValueStyle = this.badgeValueStyle != null
          ? this.badgeValueStyle
          : TextStyle(color: badgeValueColor, fontWeight: FontWeight.w600);

      textView = Text("$badgeValue", style: badgeValueStyle);
      return textView;
    }

    //Badge view for both android ios
    Widget badgeView = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          margin: margin,
          padding: padding,
          decoration: badgeDecorationStyle(),
          child: Align(
            alignment: Alignment.center,
            child: buildTextBadge(badgeValue: this.badgeValue),
          ),
        )
      ],
    );
    return badgeValue == "-1"
        ? Container()
        : InkWell(
            onTap: () {
              if (onChanged != null) {
                onChanged();
              }
            },
            child: Padding(
              padding: padding,
              child: badgeView,
            ),
          );
  }
}
