import 'package:flutter/material.dart';
import 'package:fullter_main_app/src/all_file_import/app_values_files_link.dart';
enum MyAppThem { light, dark }

class ThemeChanger extends ChangeNotifier{
  ThemeData _themeData = AppStyle.lightTheme;
  /////////// ******** App Theme *****/////////
  //Get app them
  getTheme()=> _themeData;

  //Set app them
  set setTheme(MyAppThem theme){
    _themeData = theme==MyAppThem.light?AppStyle.lightTheme:AppStyle.darkTheme;
    notifyListeners();
  }

/* static ThemeData lightTheme = ThemeData(
      backgroundColor: LightColor.background,
      primaryColor: LightColor.background,
      cardTheme: CardTheme(color: LightColor.background),
      textTheme: TextTheme(display1: TextStyle(color: LightColor.black)),
      iconTheme: IconThemeData(color: LightColor.iconColor),
      bottomAppBarColor: LightColor.background,
      dividerColor: LightColor.lightGrey,
      primaryTextTheme: TextTheme(
          body1: TextStyle(color:LightColor.titleTextColor)
      )
  );
   ThemeData darkTheme = ThemeData(
      backgroundColor: LightColor.darkgrey,
      primaryColor: LightColor.darkgrey,
      cardTheme: CardTheme(color: LightColor.darkgrey),
      textTheme: TextTheme(display1: TextStyle(color: LightColor.black)),
      iconTheme: IconThemeData(color: LightColor.iconColor),
      bottomAppBarColor: LightColor.darkgrey,
      dividerColor: LightColor.darkgrey,
      primaryTextTheme: TextTheme(
          body1: TextStyle(color:LightColor.titleTextColor)
      )
  );*/
/////////// ********  App Theme *****/////////
}