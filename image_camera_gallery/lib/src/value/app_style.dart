import 'package:flutter/material.dart';
import '../../photo_gallery_main.dart';

class PhotoGalleryAppStyle {
  TextStyle videoRecordingTimerStyle(
          {Color texColor, double fontSize, fontFamily, fontWeight}) =>
      TextStyle(
        color: texColor != null ? texColor : Colors.red,
        fontSize: fontSize != null ? fontSize : 17,
        fontFamily: fontFamily != null
            ? fontFamily
            : PhotoGalleryAppFonts().defaultFont,
        fontWeight: fontWeight != null
            ? fontWeight
            : PhotoGalleryAppFonts().semiBold600,
      );

  TextStyle appBarTitleStyle(
          {Color texColor, double fontSize, fontFamily, fontWeight}) =>
      TextStyle(
        color: texColor != null ? texColor : Colors.white,
        fontSize: fontSize != null ? fontSize : 17,
        fontFamily: fontFamily != null
            ? fontFamily
            : PhotoGalleryAppFonts().defaultFont,
        fontWeight: fontWeight != null
            ? fontWeight
            : PhotoGalleryAppFonts().semiBold600,
      );

  TextStyle appBarDoneBtnTextStyle(
          {Color texColor, double fontSize, fontFamily, fontWeight}) =>
      TextStyle(
        color: texColor != null ? texColor : Colors.white,
        fontSize: fontSize != null ? fontSize : 17,
        fontFamily: fontFamily != null
            ? fontFamily
            : PhotoGalleryAppFonts().defaultFont,
        fontWeight: fontWeight != null
            ? fontWeight
            : PhotoGalleryAppFonts().semiBold600,
      );

  TextStyle subTitleStyle(
          {Color texColor, double fontSize, fontFamily, fontWeight}) =>
      TextStyle(
        color: texColor != null
            ? texColor
            : PhotoGalleryAppColors().textSubHeadingColor,
        fontSize: fontSize != null ? fontSize : 12,
        fontFamily: fontFamily != null
            ? fontFamily
            : PhotoGalleryAppFonts().defaultFont,
        fontWeight: fontWeight != null
            ? fontWeight
            : PhotoGalleryAppFonts().semiBold600,
      );

  TextStyle h1Style(
          {Color texColor, double fontSize, fontFamily, fontWeight}) =>
      TextStyle(
        color: texColor != null
            ? texColor
            : PhotoGalleryAppColors().textNormalColor,
        fontSize: fontSize != null ? fontSize : 24,
        fontFamily: fontFamily != null
            ? fontFamily
            : PhotoGalleryAppFonts().defaultFont,
        fontWeight:
            fontWeight != null ? fontWeight : PhotoGalleryAppFonts().bold700,
      );

  TextStyle h2Style(
          {Color texColor, double fontSize, fontFamily, fontWeight}) =>
      TextStyle(
        color: texColor != null
            ? texColor
            : PhotoGalleryAppColors().textNormalColor,
        fontSize: fontSize != null ? fontSize : 22,
        fontFamily: fontFamily != null
            ? fontFamily
            : PhotoGalleryAppFonts().defaultFont,
        fontWeight:
            fontWeight != null ? fontWeight : PhotoGalleryAppFonts().regular400,
      );

  TextStyle h3Style(
          {Color texColor, double fontSize, fontFamily, fontWeight}) =>
      TextStyle(
        color: texColor != null
            ? texColor
            : PhotoGalleryAppColors().textNormalColor,
        fontSize: fontSize != null ? fontSize : 20,
        fontFamily: fontFamily != null
            ? fontFamily
            : PhotoGalleryAppFonts().defaultFont,
        fontWeight:
            fontWeight != null ? fontWeight : PhotoGalleryAppFonts().regular400,
      );

  TextStyle h4Style(
          {Color texColor, double fontSize, fontFamily, fontWeight}) =>
      TextStyle(
        color: texColor != null
            ? texColor
            : PhotoGalleryAppColors().textNormalColor,
        fontSize: fontSize != null ? fontSize : 18,
        fontFamily: fontFamily != null
            ? fontFamily
            : PhotoGalleryAppFonts().defaultFont,
        fontWeight:
            fontWeight != null ? fontWeight : PhotoGalleryAppFonts().regular400,
      );

  TextStyle h5Style(
          {Color texColor, double fontSize, fontFamily, fontWeight}) =>
      TextStyle(
        color: texColor != null
            ? texColor
            : PhotoGalleryAppColors().textNormalColor,
        fontSize: fontSize != null ? fontSize : 16,
        fontFamily: fontFamily != null
            ? fontFamily
            : PhotoGalleryAppFonts().defaultFont,
        fontWeight:
            fontWeight != null ? fontWeight : PhotoGalleryAppFonts().regular400,
      );

  TextStyle h6Style(
          {Color texColor, double fontSize, fontFamily, fontWeight}) =>
      TextStyle(
        color: texColor != null
            ? texColor
            : PhotoGalleryAppColors().textNormalColor,
        fontSize: fontSize != null ? fontSize : 14,
        fontFamily: fontFamily != null
            ? fontFamily
            : PhotoGalleryAppFonts().defaultFont,
        fontWeight:
            fontWeight != null ? fontWeight : PhotoGalleryAppFonts().regular400,
      );

  TextStyle appBarT1Style(
          {Color texColor, double fontSize, fontFamily, fontWeight}) =>
      TextStyle(
        color: texColor != null
            ? texColor
            : PhotoGalleryAppColors().appBarTextColor,
        fontSize: fontSize != null ? fontSize : 25,
        fontFamily: fontFamily != null
            ? fontFamily
            : PhotoGalleryAppFonts().defaultFont,
        fontWeight:
            fontWeight != null ? fontWeight : PhotoGalleryAppFonts().bold700,
      );

  TextStyle appBarT3Style(
          {Color texColor, double fontSize, fontFamily, fontWeight}) =>
      TextStyle(
        color: texColor != null
            ? texColor
            : PhotoGalleryAppColors().appBarTextColor[100],
        fontSize: fontSize != null ? fontSize : 18,
        fontFamily: fontFamily != null
            ? fontFamily
            : PhotoGalleryAppFonts().defaultFont,
        fontWeight: fontWeight != null
            ? fontWeight
            : PhotoGalleryAppFonts().semiBold600,
      );

  TextStyle appBarT2Style(
          {Color texColor, double fontSize, fontFamily, fontWeight}) =>
      TextStyle(
        color: texColor != null
            ? texColor
            : PhotoGalleryAppColors().textNormalColor,
        fontSize: fontSize != null ? fontSize : 25,
        fontFamily: fontFamily != null
            ? fontFamily
            : PhotoGalleryAppFonts().defaultFont,
        fontWeight:
            fontWeight != null ? fontWeight : PhotoGalleryAppFonts().bold700,
      );

  TextStyle fileNameStyle(
          {Color texColor, double fontSize, fontFamily, fontWeight}) =>
      TextStyle(
        color: texColor != null
            ? texColor
            : PhotoGalleryAppColors().textNormalColor,
        fontSize: fontSize != null ? fontSize : 11,
        fontFamily: fontFamily != null
            ? fontFamily
            : PhotoGalleryAppFonts().defaultFont,
        fontWeight:
            fontWeight != null ? fontWeight : PhotoGalleryAppFonts().regular400,
      );

  List<BoxShadow> shadow = <BoxShadow>[
    BoxShadow(color: Color(0xfff8f8f8), blurRadius: 10, spreadRadius: 15),
  ];

  //App bar setting in normal mode
  Color appBarColorBg = Colors.white;
  Color screenBgColor = Colors.white;
  Color appBarColorItems = Colors.black;
  // Color toolBarIndicatorColor = Color(0xFF231641);
  Color toolBarIndicatorColor = Colors.blueAccent;

  //If multi image selected in gallery
  Color appBarHighlightColorBg = Colors.orange;
  Color appBarHighlightColorItems = Colors.white;
}

PhotoGalleryAppStyle appStyle = PhotoGalleryAppStyle();
