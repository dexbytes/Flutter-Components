import 'package:flutter/material.dart';
import 'package:fullter_main_app/src/all_file_import/app_values_files_link.dart';

class AppStyle {

  /////////// ********  App Theme *****/////////
  static AppColors appColors = AppColors();
  static final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
      color: Colors.white,
     /* iconTheme: IconThemeData(
        color: Colors.black,
      ),*/
    ),
    colorScheme: ColorScheme.light(
      primary: appColors.primaryColor,
      onPrimary: appColors.primaryColor,
      primaryVariant: appColors.primaryColor,
      secondary: Colors.red,
    ),
    cardTheme: CardTheme(
      color: appColors.cardBgColor,
    ),
   /* iconTheme: IconThemeData(
      color: appColors.iconColor[100],
    ),*/
    textTheme: TextTheme(
      headline1: TextStyle(
        color: Colors.black,
        fontSize: 20.0,
      ),
      headline2: TextStyle(
        color: Colors.black,
        fontSize: 18.0,
      ),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.black,
    appBarTheme: AppBarTheme(
      color: Colors.black,
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
    ),
    colorScheme: ColorScheme.light(
      primary: Colors.black,
      onPrimary: Colors.black,
      primaryVariant: Colors.black,
      secondary: Colors.red,
    ),
    cardTheme: CardTheme(
      color: Colors.black,
    ),
    iconTheme: IconThemeData(
      color: Colors.white54,
    ),
    textTheme: TextTheme(
      headline1: TextStyle(
        color: Colors.white,
        fontSize: 20.0,
      ),
      headline2: TextStyle(
        color: Colors.white70,
        fontSize: 18.0,
      ),
    ),
  );

  /////////// ********  App Theme *****/////////

   TextStyle titleStyle({Color texColor,double fontSize,fontFamily,fontWeight}) => TextStyle(color: texColor!=null?texColor:AppColors().textNormalColor,
     fontSize: fontSize!=null?fontSize:16,
     fontFamily: fontFamily!=null?fontFamily: AppFonts().defaultFont,
     fontWeight: fontWeight!=null?fontWeight:AppFonts().semiBold600,);

   TextStyle subTitleStyle ({Color texColor,double fontSize,fontFamily,fontWeight}) => TextStyle(color: texColor!=null?texColor:AppColors().textSubHeadingColor,
     fontSize: fontSize!=null?fontSize:12,
     fontFamily: fontFamily!=null?fontFamily: AppFonts().defaultFont,
     fontWeight: fontWeight!=null?fontWeight:AppFonts().semiBold600,);

   TextStyle h1Style ({Color texColor,double fontSize,fontFamily,fontWeight}) => TextStyle(color: texColor!=null?texColor:AppColors().textNormalColor,
     fontSize: fontSize!=null?fontSize:24,
     fontFamily: fontFamily!=null?fontFamily: AppFonts().defaultFont,
     fontWeight: fontWeight!=null?fontWeight:AppFonts().bold700,);

   TextStyle h2Style ({Color texColor,double fontSize,fontFamily,fontWeight}) => TextStyle(color: texColor!=null?texColor:AppColors().textNormalColor,
     fontSize: fontSize!=null?fontSize:22,
     fontFamily: fontFamily!=null?fontFamily: AppFonts().defaultFont,
     fontWeight: fontWeight!=null?fontWeight:AppFonts().regular400,);

   TextStyle h3Style ({Color texColor,double fontSize,fontFamily,fontWeight}) => TextStyle(color: texColor!=null?texColor:AppColors().textNormalColor,
     fontSize: fontSize!=null?fontSize:20,
     fontFamily: fontFamily!=null?fontFamily: AppFonts().defaultFont,
     fontWeight: fontWeight!=null?fontWeight:AppFonts().regular400,);

   TextStyle h4Style ({Color texColor,double fontSize,fontFamily,fontWeight}) => TextStyle(color: texColor!=null?texColor:AppColors().textNormalColor,
     fontSize: fontSize!=null?fontSize:18,
     fontFamily: fontFamily!=null?fontFamily: AppFonts().defaultFont,
     fontWeight: fontWeight!=null?fontWeight:AppFonts().regular400,);

   TextStyle h5Style ({Color texColor,double fontSize,fontFamily,fontWeight}) => TextStyle(color: texColor!=null?texColor:AppColors().textNormalColor,
     fontSize: fontSize!=null?fontSize:16,
     fontFamily: fontFamily!=null?fontFamily: AppFonts().defaultFont,
     fontWeight: fontWeight!=null?fontWeight:AppFonts().regular400,);

   TextStyle h6Style ({Color texColor,double fontSize,fontFamily,fontWeight}) => TextStyle(color: texColor!=null?texColor:AppColors().textNormalColor,
     fontSize: fontSize!=null?fontSize:14,
     fontFamily: fontFamily!=null?fontFamily: AppFonts().defaultFont,
     fontWeight: fontWeight!=null?fontWeight:AppFonts().regular400,);


   TextStyle appBarT1Style ({Color texColor,double fontSize,fontFamily,fontWeight}) => TextStyle(color: texColor!=null?texColor:AppColors().appBarTextColor,
     fontSize: fontSize!=null?fontSize:25,
     fontFamily: fontFamily!=null?fontFamily: AppFonts().defaultFont,
     fontWeight: fontWeight!=null?fontWeight:AppFonts().bold700,);

   TextStyle appBarT2Style ({Color texColor,double fontSize,fontFamily,fontWeight}) => TextStyle(color: texColor!=null?texColor:AppColors().textNormalColor,
     fontSize: fontSize!=null?fontSize:25,
     fontFamily: fontFamily!=null?fontFamily: AppFonts().defaultFont,
     fontWeight: fontWeight!=null?fontWeight:AppFonts().bold700,);



   List<BoxShadow> shadow =  <BoxShadow>[
    BoxShadow(color: Color(0xfff8f8f8), blurRadius: 10, spreadRadius: 15),
  ];
}