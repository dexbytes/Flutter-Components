import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum CardType {
  FULL_WIDTH, //Width always full screen with size not depends on child
  DEFAULT, //With and height accordingly child data
}

class CardView extends StatelessWidget {
  final child;
  final radius;
  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry padding;
  final double elevation;
  final Color cardColor;
  final bool isAndroid;
  final CardType cardType;

  CardView(
      {Key key,
      @required this.child,
      this.margin,
      this.padding,
      this.radius = -1,
      this.elevation = 0.0,
      this.cardColor = Colors.white,
      this.cardType = CardType.DEFAULT,
      this.isAndroid = false})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    /*bool isAndroid = false;
    //Check device platform
    if (Platform.isIOS) {
      isAndroid = false;
    } else if (Platform.isAndroid) {
      isAndroid = true;
    }*/

    Color shadowColorTemp = Colors.white;
    //Card elevation
    double elevationGet() {
      double elevationTemp = 0;
      if (elevation > 0) {
        elevationTemp = elevation;
      } else {
        //Set elevation for android platform
        if (isAndroid) {
          elevationTemp = 2;
          shadowColorTemp = Colors.black;
        }
        //Set elevation for android platform
        else if (!isAndroid) {
          elevationTemp = 6;
          shadowColorTemp = Colors.white;
        }
      }
      return elevationTemp;
    }

    //Card shape
    ShapeBorder shape() {
      //iOS shape radius
      double radiusTemp = 8.0;
      //Android
      if (isAndroid) {
        radiusTemp = 5;
      }
      //User specific
      if (radius > -1) {
        radiusTemp = radius;
      }
      return RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radiusTemp),
      );
    }

    MainAxisSize cardWithType() {
      if (cardType == CardType.FULL_WIDTH) {
        return MainAxisSize.max;
      }
      return MainAxisSize.min;
    }

    // Render card
    return Card(
      color: cardColor,
      shadowColor: shadowColorTemp,
      elevation: elevationGet(),
      shape: shape(),
      margin: margin != null
          ? margin
          : EdgeInsets.symmetric(
              horizontal: isAndroid ? 16 : 16, vertical: isAndroid ? 4 : 8),
      child: Row(
        mainAxisSize: cardWithType(),
        children: [
          Padding(
            padding: padding != null
                ? padding
                : EdgeInsets.symmetric(
                    horizontal: isAndroid ? 0 : 0, vertical: isAndroid ? 0 : 0),
            child: child,
          ),
        ],
      ),
    );
  }
}
