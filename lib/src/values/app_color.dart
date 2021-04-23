import 'dart:ui';

import 'package:flutter/material.dart';

class AppColors {
  int intWhite = 0xFFF44336;
  Color colorPrimary = Color.fromARGB(255, 51, 51, 51);
  Color colorPrimaryDark = Color.fromARGB(255, 41, 41, 41);
  Color colorAccent = Color.fromARGB(255, 30, 198, 89);
  Color orange = Color.fromARGB(255, 252, 109, 38);
  Color greyUnselected = Color.fromARGB(255, 96, 96, 96);
  Color whiteCard = Color.fromARGB(255, 250, 250, 250);
  Color chromeGrey = Color.fromARGB(255, 240, 240, 240);
  Color white = Color.fromARGB(255, 255, 255, 255);
  Color whiteSecondary = Color.fromARGB(255, 220, 220, 220);
  Color whiteUnSelected = Color.fromARGB(255, 180, 180, 180);
  Color indigo = Color.fromARGB(255, 51, 105, 231);
  Color primaryText = Color.fromARGB(255, 51, 51, 51);
  Color secondaryText = Color.fromARGB(255, 114, 114, 114);
  Color grey = Color.fromARGB(255, 188, 187, 187);

  //Extra colors
  Color primaryShadeColor1 = Color(0xFFaccfdc);
  Color primaryShadeColor2 = Color(0xFF6cc3e3);
  Color darkRed = Color(0xFF620F0F);
  Color red = Color(0xFFDD2E37);
  Color yellow = Color(0xFF4AA546);
  Color lightBackgroundColor = Color(0xFFF5F5F5);
  Color lightBlack = Color(0xFF231F20);
  Color lightblack = Color(0xFF231F20);
  Color black = Color(0xFF000000);
  Color wordGreyColor = Color(0xFFCCCCCC);

  MaterialAccentColor primaryColor = MaterialAccentColor(
    0xFFf2af58,
    <int, Color>{
      100: Color(0xFF4AA546),
      200: Color(0xFF003071),
      300: Color(0x509b8560),
      400: Color(0xFF00aeef),
      500: Color(0xFFffc3f5),
      600: Color(0xFFffc3f5),
      700: Color(0x00ffc3f5),
    },
  );

  MaterialColor appThemeColor = MaterialColor(0xFF9b8560, <int, Color>{
    50: Color.fromRGBO(155, 133, 96, .1),
    100: Color.fromRGBO(155, 133, 96, .2),
    200: Color.fromRGBO(155, 133, 96, .3),
    300: Color.fromRGBO(155, 133, 96, .4),
    400: Color.fromRGBO(155, 133, 96, .5),
    500: Color.fromRGBO(155, 133, 96, .6),
    600: Color.fromRGBO(155, 133, 96, .7),
    700: Color.fromRGBO(155, 133, 96, .8),
    800: Color.fromRGBO(155, 133, 96, .9),
    900: Color.fromRGBO(155, 133, 96, 1),
  });

  //Status bar color
  Color appStatusBarTransColor = Color(0x00000000);
  //Loader Color ********************************
  MaterialColor loaderColor = MaterialColor(
    0xFF4AA546,
    <int, Color>{
      100: Color(0xFF4AA546),
      200: Color(0xFF696969),
      300: Color(0xFFffc3f5),
      400: Color(0xFFA9A9A9),
      500: Color(0xFFCCCCCC),
      600: Color(0x0D000CC0),
      700: Color(0x0D000000),
    },
  );
  MaterialColor loaderBgColor = MaterialColor(
    0xFFFFFFFF,
    <int, Color>{
      100: Color(0xFFFFFFFF),
      200: Color(0xFF696969),
      300: Color(0xFF808080),
      400: Color(0xFFA9A9A9),
      500: Color(0xFFCCCCCC),
      600: Color(0x0D000CC0),
      700: Color(0x0D000000),
    },
  );

  //AppBar color start
  MaterialColor appBarLetIconColor = MaterialColor(
    0xFF000000,
    <int, Color>{
      100: Color(0xFFFFFFFF),
      200: Color(0xFF62696e),
      300: Color(0xFF808080),
      400: Color(0xFFA9A9A9),
      500: Color(0xFFCCCCCC),
      600: Color(0x0D000CC0),
      700: Color(0x0D000000),
    },
  );
  MaterialColor appBarTextColor = MaterialColor(
    0xFF2c3134,
    <int, Color>{
      100: Color(0xFFFFFFFF),
      200: Color(0xFF696969),
      300: Color(0xFF808080),
      400: Color(0xFFA9A9A9),
      500: Color(0xFFCCCCCC),
      600: Color(0xFF242424),
      700: Color(0x0D000000),
    },
  );
  MaterialColor appBarSubTextColor = MaterialColor(
    0xFF2c3134,
    <int, Color>{
      100: Color(0xFFf1a7dc),
      200: Color(0xFF696969),
      300: Color(0xFF808080),
      400: Color(0xFFA9A9A9),
      500: Color(0xFFCCCCCC),
      600: Color(0x0D000CC0),
      700: Color(0x0D000000),
    },
  );
  MaterialColor appBarRightIconColor = MaterialColor(
    0xFF000000,
    <int, Color>{
      100: Color(0xFFFFFFFF),
      200: Color(0xFF696969),
      300: Color(0xFF808080),
      400: Color(0xFFA9A9A9),
      500: Color(0xFFCCCCCC),
      600: Color(0x0D000CC0),
      700: Color(0x0D000000),
    },
  );
  MaterialColor appBarBgColor = MaterialColor(
    0xFFFFFFFF,
    <int, Color>{
      100: Color(0xFF4AA546),
      200: Color(0xFF696969),
      300: Color(0xFF808080),
      400: Color(0xFFA9A9A9),
      500: Color(0xFF33302b),
      600: Color(0x0D000CC0),
      700: Color(0x00FFFFFF),
    },
  );
  MaterialColor appBarBorderColor = MaterialColor(
    0xFFA9A9A9,
    <int, Color>{
      100: Color(0xFF000000),
      200: Color(0xFF696969),
      300: Color(0xFF808080),
      400: Color(0xFFA9A9A9),
      500: Color(0xFFCCCCCC),
      600: Color(0x0D000CC0),
      700: Color(0x0D000000),
    },
  );
  //AppBar color end

  //Drawer color *********************************************
  MaterialColor drawerLetIconMaterialColor = MaterialColor(
    0xFF000000,
    <int, Color>{
      100: Color(0xFFFFFFFF),
      200: Color(0xFF696969),
      300: Color(0xFF808080),
      400: Color(0xFFA9A9A9),
      500: Color(0xFFCCCCCC),
      600: Color(0x0D000CC0),
      700: Color(0x0D000000),
    },
  );
  MaterialColor drawerTextColor = MaterialColor(
    0xFF000000,
    <int, Color>{
      100: Color(0xFFFFFFFF),
      200: Color(0xFF696969),
      300: Color(0xFF808080),
      400: Color(0xFFA9A9A9),
      500: Color(0xFFCCCCCC),
      600: Color(0x0D000CC0),
      700: Color(0x0D000000),
    },
  );
  MaterialColor drawerRightIconColor = MaterialColor(
    0xFF000000,
    <int, Color>{
      100: Color(0xFFFFFFFF),
      200: Color(0xFF696969),
      300: Color(0xFF808080),
      400: Color(0xFFA9A9A9),
      500: Color(0xFFCCCCCC),
      600: Color(0x0D000CC0),
      700: Color(0x0D000000),
    },
  );
  MaterialColor drawerBgColor = MaterialColor(
    0xFFFFFFFF,
    <int, Color>{
      100: Color(0xFFFFFFFF),
      200: Color(0xFF696969),
      300: Color(0xFF808080),
      400: Color(0xFFA9A9A9),
      500: Color(0xFFCCCCCC),
      600: Color(0x0D000CC0),
      700: Color(0x0D000000),
    },
  );
  MaterialColor drawerBorderColor = MaterialColor(
    0xFFFFFFFF,
    <int, Color>{
      100: Color(0xFFFFFFFF),
      200: Color(0xFF696969),
      300: Color(0xFF808080),
      400: Color(0xFFA9A9A9),
      500: Color(0xFFCCCCCC),
      600: Color(0x0D000CC0),
      700: Color(0x0D000000),
    },
  );
  MaterialColor drawerDividerColor = MaterialColor(
    0xFF000000,
    <int, Color>{
      100: Color(0xFFFFFFFF),
      200: Color(0xFF696969),
      300: Color(0xFF808080),
      400: Color(0xFFA9A9A9),
      500: Color(0xFFCCCCCC),
      600: Color(0x0D000CC0),
      700: Color(0x0D000000),
    },
  );
  MaterialColor drawerBottomViewBgColor = MaterialColor(
    0xFFFFFFFF,
    <int, Color>{
      100: Color(0xFFFFFFFF),
      200: Color(0xFF696969),
      300: Color(0xFF808080),
      400: Color(0xFFA9A9A9),
      500: Color(0xFFCCCCCC),
      600: Color(0x0D000CC0),
      700: Color(0x0D000000),
    },
  );
  MaterialColor drawerHeaderViewBgColor = MaterialColor(
    0xFFFFFFFF,
    <int, Color>{
      100: Color(0xFFFFFFFF),
      200: Color(0xFF696969),
      300: Color(0xFF808080),
      400: Color(0xFFA9A9A9),
      500: Color(0xFFCCCCCC),
      600: Color(0x0D000CC0),
      700: Color(0x0D000000),
    },
  );
  MaterialColor drawerSelectedItemBgColor = MaterialColor(
    0xFF000000,
    <int, Color>{
      100: Color(0xFFFFFFFF),
      200: Color(0xFF696969),
      300: Color(0xFF808080),
      400: Color(0xFFA9A9A9),
      500: Color(0xFFCCCCCC),
      600: Color(0x0D000CC0),
      700: Color(0x0D000000),
    },
  );
  MaterialColor drawerSelectedItemTextColor = MaterialColor(
    0xFF000000,
    <int, Color>{
      100: Color(0xFFFFFFFF),
      200: Color(0xFF696969),
      300: Color(0xFF808080),
      400: Color(0xFFA9A9A9),
      500: Color(0xFFCCCCCC),
      600: Color(0x0D000CC0),
      700: Color(0x0D000000),
    },
  );
  MaterialColor drawerSelectedItemIconColor = MaterialColor(
    0xFF000000,
    <int, Color>{
      100: Color(0xFFFFFFFF),
      200: Color(0xFF696969),
      300: Color(0xFF808080),
      400: Color(0xFFA9A9A9),
      500: Color(0xFFCCCCCC),
      600: Color(0x0D000CC0),
      700: Color(0x0D000000),
    },
  );
  MaterialColor drawerDisabledItemColor = MaterialColor(
    0xFFCCCCCC,
    <int, Color>{
      100: Color(0xFFFFFFFF),
      200: Color(0xFF696969),
      300: Color(0xFF808080),
      400: Color(0xFFA9A9A9),
      500: Color(0xFFCCCCCC),
      600: Color(0x0D000CC0),
      700: Color(0x0D000000),
    },
  );

  //*  Bottom bar color ***********************************
  MaterialColor bottomBarIconColor = MaterialColor(
    0xFF000000,
    <int, Color>{
      100: Color(0xFFFFFFFF),
      200: Color(0xFF696969),
      300: Color(0xFF808080),
      400: Color(0xFFA9A9A9),
      500: Color(0xFFCCCCCC),
      600: Color(0x0D000CC0),
      700: Color(0x0D000000),
    },
  );
  MaterialColor bottomBarTextColor = MaterialColor(
    0xFF000000,
    <int, Color>{
      100: Color(0xFFFFFFFF),
      200: Color(0xFF696969),
      300: Color(0xFF808080),
      400: Color(0xFFA9A9A9),
      500: Color(0xFFCCCCCC),
      600: Color(0x0D000CC0),
      700: Color(0x0D000000),
    },
  );
  MaterialColor bottomBarBgColor = MaterialColor(
    0xFFFFFFFF,
    <int, Color>{
      100: Color(0xFFFFFFFF),
      200: Color(0xFF696969),
      300: Color(0xFF808080),
      400: Color(0xFFA9A9A9),
      500: Color(0xFFCCCCCC),
      600: Color(0x0D000CC0),
      700: Color(0x0D000000),
    },
  );
  MaterialColor bottomBarBorderColor = MaterialColor(
    0xFFeff4f9,
    <int, Color>{
      100: Color(0xFFFFFFFF),
      200: Color(0xFF696969),
      300: Color(0xFF808080),
      400: Color(0xFFA9A9A9),
      500: Color(0xFFCCCCCC),
      600: Color(0x0D000CC0),
      700: Color(0x0D000000),
    },
  );
  MaterialColor bottomBarDividerColor = MaterialColor(
    0xFF000000,
    <int, Color>{
      100: Color(0xFFFFFFFF),
      200: Color(0xFF696969),
      300: Color(0xFF808080),
      400: Color(0xFFA9A9A9),
      500: Color(0xFFCCCCCC),
      600: Color(0x0D000CC0),
      700: Color(0x0D000000),
    },
  );
  MaterialColor bottomBarSelectedItemBgColor = MaterialColor(
    0xFFDD2E37,
    <int, Color>{
      100: Color(0xFFFFFFFF),
      200: Color(0xFF696969),
      300: Color(0xFF808080),
      400: Color(0xFFA9A9A9),
      500: Color(0xFFCCCCCC),
      600: Color(0x0D000CC0),
      700: Color(0x0D000000),
    },
  );
  MaterialColor bottomBarSelectedItemTextColor = MaterialColor(
    0xFF00aeef,
    <int, Color>{
      100: Color(0xFFFFFFFF),
      200: Color(0xFF696969),
      300: Color(0xFF808080),
      400: Color(0xFFA9A9A9),
      500: Color(0xFFCCCCCC),
      600: Color(0x0D000CC0),
      700: Color(0x0D000000),
    },
  );
  MaterialColor bottomBarSelectedItemIconColor = MaterialColor(
    0xFF4AA546,
    <int, Color>{
      100: Color(0xFFFFFFFF),
      200: Color(0xFF696969),
      300: Color(0xFF808080),
      400: Color(0xFFA9A9A9),
      500: Color(0xFFCCCCCC),
      600: Color(0x0D000CC0),
      700: Color(0x0D000000),
    },
  );
  MaterialColor bottomBarDisabledItemColor = MaterialColor(
    0xFFA3AEB5,
    <int, Color>{
      100: Color(0xFFFFFFFF),
      200: Color(0xFF696969),
      300: Color(0xFF808080),
      400: Color(0xFFA9A9A9),
      500: Color(0xFFCCCCCC),
      600: Color(0x0D000CC0),
      700: Color(0x0D000000),
    },
  );

  //*Application Main containers BG color ***********************************
  MaterialColor appBgColor = MaterialColor(
    0xFFf2f4f5,
    <int, Color>{
      100: Color(0xFFfdfdfd),
      200: Color(0xFFf2f4f5),
      300: Color(0xFFf2f2f2),
      400: Color(0xFFf4f6f7),
      500: Color(0xFF33302b),
      600: Color(0xFFf0f1f2),
      700: Color(0x0D000000),
    },
  );

  MaterialColor appTopBgColor = MaterialColor(
    0xFFFFFFFF,
    <int, Color>{
      100: Color(0xFFFFFFFF),
      200: Color(0xFF696969),
      300: Color(0xFF808080),
      400: Color(0xFFA9A9A9),
      500: Color(0xFFf6f8f9),
      600: Color(0xFFC0C0C0),
      700: Color(0xFFC0C0C0),
    },
  );
  MaterialColor appCenterBgColor = MaterialColor(
    0xFFFFFFFF,
    <int, Color>{
      100: Color(0xFF000000),
      200: Color(0xFF696969),
      300: Color(0xFF808080),
      400: Color(0xFFA9A9A9),
      500: Color(0xFFC0C0C0),
      600: Color(0xFFC0C0C0),
      700: Color(0xFFC0C0C0),
    },
  );
  MaterialColor appBottomBgColor = MaterialColor(
    0xFFFFFFFF,
    <int, Color>{
      100: Color(0xFF000000),
      200: Color(0xFF696969),
      300: Color(0xFF808080),
      400: Color(0xFFA9A9A9),
      500: Color(0xFFC0C0C0),
      600: Color(0xFFC0C0C0),
      700: Color(0xFFC0C0C0),
    },
  );

  //*  Bottom bar color ***********************************
  MaterialColor appStatusBarColor = MaterialColor(
    0xFF4AA546,
    <int, Color>{
      100: Color(0xFF4AA546),
      200: Color(0xFF4AA546),
      400: Color(0xFF4AA546),
      500: Color(0xFF4AA546),
      600: Color(0xFF4AA546),
      700: Color(0x00FFFFFF),
    },
  );
  MaterialColor appDisabledColor = MaterialColor(
    0xFF6C6C6C,
    <int, Color>{
      100: Color(0xFF8D8D8D), //previous color - 0xFF6C6C6C
      200: Color(0xFF696969),
      300: Color(0xFF808080),
      400: Color(0xFFA9A9A9),
      500: Color(0xFFC0C0C0),
      600: Color(0xFFC0C0C0),
      700: Color(0xFFC0C0C0),
    },
  );
  MaterialColor appErrorTextColor = MaterialColor(
    0xFFDD2E37,
    <int, Color>{
      100: Color(0xFF000000),
      200: Color(0xFF696969),
      300: Color(0xFF808080),
      400: Color(0xFFA9A9A9),
      500: Color(0xFFC0C0C0),
      600: Color(0xFFA9A9A9),
    },
  );

  MaterialColor appDividerColor = MaterialColor(
    0xFF000000,
    <int, Color>{
      100: Color(0xFF000000),
      200: Color(0xFF696969),
      300: Color(0xFF808080),
      400: Color(0xFFA9A9A9),
      500: Color(0xFFC0C0C0),
      600: Color(0xFFdadfe2),
      700: Color(0x0D000000),
    },
  );
  MaterialColor appListDividerColor = MaterialColor(
    0xFF000000,
    <int, Color>{
      100: Color(0xFF000000),
      200: Color(0xFF696969),
      300: Color(0xFF808080),
      400: Color(0xFFA9A9A9),
      500: Color(0xFFdadfe2),
      600: Color(0x1a000000),
      700: Color(0x0D000000),
    },
  );
  MaterialColor appTransColor = MaterialColor(
    0x00FFFFFF,
    <int, Color>{
      100: Color(0xFF000000),
      200: Color(0xFF696969),
      300: Color(0xFF808080),
      400: Color(0xFFA9A9A9),
      500: Color(0xFFCCCCCC),
      600: Color(0x80000000),
      700: Color(0x00000000),
    },
  );

  //Buttons Color ************************************
  MaterialColor buttonBgColor = MaterialColor(
    0xFF4AA546,
    <int, Color>{
      100: Color(0xFF4AA546),
      200: Color(0xFFf9f7ef),
      300: Color(0xFFf4f1ec),
      400: Color(0xFFA9A9A9),
      500: Color(0xFFC0C0C0),
      600: Color(0xFFf9f7ef),
      700: Color(0xFFf9f7ef),
    },
  );
  MaterialColor buttonTextColor = MaterialColor(
    0xFFFFFFFF,
    <int, Color>{
      100: Color(0xFFFFFFFF),
      200: Color(0xFF4AA546),
      300: Color(0xFF808080),
      400: Color(0xFFA9A9A9),
      500: Color(0xFFC0C0C0),
      600: Color(0xFF003071),
      700: Color(0xFFC0C0C0),
    },
  );
  MaterialColor buttonIconColor = MaterialColor(
    0xFFFFFFFF,
    <int, Color>{
      100: Color(0xFFFFFFFF),
      200: Color(0xFF4AA546),
      300: Color(0xFF808080),
      400: Color(0xFFA9A9A9),
      500: Color(0xFFC0C0C0),
      600: Color(0xFFC0C0C0),
      700: Color(0xFFC0C0C0),
    },
  );
  MaterialColor buttonBorderColor = MaterialColor(
    0xFFCCCCCC,
    <int, Color>{
      100: Color(0xFFFFFFFF),
      200: Color(0xFF4AA546),
      300: Color(0xFF808080),
      400: Color(0xFFA9A9A9),
      500: Color(0xFFC0C0C0),
      600: Color(0xFFC0C0C0),
      700: Color(0x00FFFFFF),
    },
  );

  //Card bg color ************************************
  MaterialColor cardBgColor = MaterialColor(
    0xFFFFFFFF,
    <int, Color>{
      100: Color(0xFFFFFFFF),
      200: Color(0xFF4AA546),
      300: Color(0xFF808080),
      400: Color(0xFFA9A9A9),
      500: Color(0xFFC0C0C0),
      600: Color(0xFFC0C0C0),
      700: Color(0xFFC0C0C0),
    },
  );

  //Edit field Color *********************************
  MaterialColor editTextColor = MaterialColor(
    0xFF2c3134,
    <int, Color>{
      100: Color(0xFF000000),
      200: Color(0xF2000000),
      300: Color(0xB3000000),
      400: Color(0x50000000),
      500: Color(0xFFC0C0C0),
      600: Color(0xFFC0C0C0),
      700: Color(0xFFC0C0C0),
    },
  );
  MaterialColor editTextHintColor = MaterialColor(
    0xFFbcbfc3,
    <int, Color>{
      100: Color(0xFFa2adb5),
      200: Color(0xFF8fa0b4),
      300: Color(0xFF808080),
      400: Color(0xFFA9A9A9),
      500: Color(0xFFC0C0C0),
      600: Color(0xFFC0C0C0),
      700: Color(0xFFC0C0C0),
    },
  );
  MaterialColor editTextBgColor = MaterialColor(
    0xFFFFFFFF,
    <int, Color>{
      100: Color(0xFFf0f1f2),
      200: Color(0xFFf2f2f2),
      300: Color(0xFF808080),
      400: Color(0xFFA9A9A9),
      500: Color(0xFFf4f6f7),
      600: Color(0xFFC0C0C0),
      700: Color(0xFFC0C0C0),
    },
  ); //Edit field Color
  MaterialColor editCursorColor = MaterialColor(
    0xFFffc3f5,
    <int, Color>{
      100: Color(0xFFFFFFFF),
      200: Color(0xFF696969),
      300: Color(0xFF808080),
      400: Color(0xFFA9A9A9),
      500: Color(0xFFC0C0C0),
      600: Color(0xFFC0C0C0),
      700: Color(0xFFC0C0C0),
    },
  );
  MaterialColor editTextFocusedBorderColor = MaterialColor(
    0xFF003071,
    <int, Color>{
      100: Color(0xFFf0f1f2),
      200: Color(0xFF696969),
      300: Color(0xFF808080),
      400: Color(0xFFA9A9A9),
      500: Color(0xFFC0C0C0),
    },
  );
  MaterialColor editTextBorderColor = MaterialColor(
    0xFFffc3f5,
    <int, Color>{
      100: Color(0xFFf0f1f2),
      200: Color(0xFF696969),
      300: Color(0xFF808080),
      400: Color(0xFFA9A9A9),
      500: Color(0xFFC0C0C0),
    },
  );
  MaterialColor editTextEnabledBorderColor = MaterialColor(
    0xFFffc3f5,
    <int, Color>{
      100: Color(0xFFf0f1f2),
      200: Color(0xFF696969),
      300: Color(0xFF808080),
      400: Color(0xFFA9A9A9),
      500: Color(0xFFC0C0C0),
    },
  );

  MaterialColor editTextIconColor = MaterialColor(
    0xFF000000,
    <int, Color>{
      100: Color(0xFF000000),
      200: Color(0xFF696969),
      300: Color(0xFF808080),
      400: Color(0xFFA9A9A9),
      500: Color(0xFFC0C0C0),
      600: Color(0xFFC0C0C0),
      700: Color(0xFFC0C0C0),
    },
  );
  MaterialColor editTextErrorColor = MaterialColor(
    0xFFDD2E37,
    <int, Color>{
      100: Color(0xFF000000),
      200: Color(0xFF696969),
      300: Color(0xFF808080),
      400: Color(0xFFA9A9A9),
      500: Color(0xFFC0C0C0),
      600: Color(0xFFC0C0C0),
      700: Color(0xFFC0C0C0),
    },
  );

  //Text field Color *********************************
  MaterialColor textBgColor = MaterialColor(
    0xFFFFFFFF,
    <int, Color>{
      100: Color(0xFF000000),
      200: Color(0xF2696969),
      300: Color(0xFF808080),
      400: Color(0xFFA9A9A9),
      500: Color(0xFFC0C0C0),
      600: Color(0xFF4AA546),
      700: Color(0xFF2c3134),
    },
  );
  MaterialColor textNormalColor = MaterialColor(
    0xFF2c3134,
    <int, Color>{
      100: Color(0xFF8d8d8d),
      200: Color(0xFF222222),
      300: Color(0xFFa2adb5),
      400: Color(0xFF62696e),
      500: Color(0xFF2c2d30),
      600: Color(0xFF4AA546),
      700: Color(0xFF3b3b3b),
    },
  );
  MaterialColor textSubHeadingColor = MaterialColor(
    0xFF000000,
    <int, Color>{
      100: Color(0xFF000000),
      200: Color(0xE6000000),
      300: Color(0xFF4AA546),
      400: Color(0x80000000),
      500: Color(0xFFC0C0C0),
      600: Color(0xFFC0C0C0),
      700: Color(0xFFC0C0C0),
    },
  );
  MaterialColor textHeadingColor = MaterialColor(
    0xFF2c3134,
    <int, Color>{
      100: Color(0xFF2c3134),
      200: Color(0xE6000000),
      300: Color(0xB3000000),
      400: Color(0x80000000),
      500: Color(0xFFC0C0C0),
      600: Color(0xFFC0C0C0),
      700: Color(0xFFC0C0C0),
    },
  );

  MaterialColor textDisabledColor = MaterialColor(
    0xFFCCCCCC,
    <int, Color>{
      100: Color(0xFFCCCCCC),
      200: Color(0xFFCCCCCC),
      400: Color(0xFFCCCCCC),
      500: Color(0xFFCCCCCC),
      600: Color(0xFFCCCCCC),
      700: Color(0xFFCCCCCC),
    },
  );
  MaterialColor textIconColor = MaterialColor(
    0xFF000000,
    <int, Color>{
      100: Color(0xFFCCCCCC),
      200: Color(0xFFCCCCCC),
      400: Color(0xFFCCCCCC),
      500: Color(0xFFCCCCCC),
      600: Color(0xFFCCCCCC),
      700: Color(0xFFCCCCCC),
    },
  );
  MaterialColor textBorderColor = MaterialColor(
    0xFFDD2E37,
    <int, Color>{
      100: Color(0xFFCCCCCC),
      200: Color(0xFFCCCCCC),
      400: Color(0xFFCCCCCC),
      500: Color(0xFFCCCCCC),
      600: Color(0xFFCCCCCC),
      700: Color(0xFFCCCCCC),
    },
  );

  //List field Color *****************************
  MaterialColor listRowBgColor = MaterialColor(
    0xFFFFFFFF,
    <int, Color>{
      100: Color(0xFFf6f8f9),
      200: Color(0xFFFFFFFF),
      300: Color(0xFF808080),
      400: Color(0xFFA9A9A9),
      500: Color(0xFFC0C0C0),
      600: Color(0xFFC0C0C0),
      700: Color(0x00000000),
    },
  );
  MaterialColor listBgColor = MaterialColor(
    0xFFF5F5F5,
    <int, Color>{
      100: Color(0x00FFFFFF),
      200: Color(0xFF696969),
      300: Color(0xFF808080),
      400: Color(0xFFA9A9A9),
      500: Color(0xFFC0C0C0),
      600: Color(0xFFC0C0C0),
      700: Color(0xFFC0C0C0),
    },
  );
  MaterialColor listTextColor = MaterialColor(
    0xFF000000,
    <int, Color>{
      100: Color(0x00FFFFFF),
      200: Color(0xFF696969),
      300: Color(0xFF808080),
      400: Color(0xFFA9A9A9),
      500: Color(0xFFC0C0C0),
      600: Color(0xFFC0C0C0),
      700: Color(0xFFC0C0C0),
    },
  );
  MaterialColor listRowBorderColor = MaterialColor(
    0xFFFFFFFF,
    <int, Color>{
      100: Color(0x00FFFFFF),
      200: Color(0xFF696969),
      300: Color(0xFF808080),
      400: Color(0xFFA9A9A9),
      500: Color(0xFFC0C0C0),
      600: Color(0xFFC0C0C0),
      700: Color(0xFFC0C0C0),
    },
  );

  //Amount color **********************************
  MaterialColor activeAmountColor = MaterialColor(
    0xFF0ca84b,
    <int, Color>{
      100: Color(0x00FFFFFF),
      200: Color(0xFF696969),
      300: Color(0xFF808080),
      400: Color(0xFFA9A9A9),
      500: Color(0xFFC0C0C0),
      600: Color(0xFFC0C0C0),
      700: Color(0xFFC0C0C0),
    },
  );
  MaterialColor activeAmountColor2 = MaterialColor(
    0xFF32CD32,
    <int, Color>{
      100: Color(0x00FFFFFF),
      200: Color(0xFF696969),
      300: Color(0xFF808080),
      400: Color(0xFFA9A9A9),
      500: Color(0xFFC0C0C0),
      600: Color(0xFFC0C0C0),
      700: Color(0xFFC0C0C0),
    },
  );

  MaterialColor chatTimeTextColor = MaterialColor(
    0xFFFFFFFF,
    <int, Color>{
      100: Color(0xFF000000),
      200: Color(0xFF696969),
      300: Color(0xFF808080),
      400: Color(0xFFA9A9A9),
      500: Color(0xFFC0C0C0),
      600: Color(0xFFC0C0C0),
      700: Color(0xFFC0C0C0),
    },
  );
  MaterialColor chatSenderRowBgColor = MaterialColor(
    0xFF9b8560,
    <int, Color>{
      100: Color(0x509b8560),
      200: Color(0xFF4AA546),
      300: Color(0xFF4AA546),
      400: Color(0xFFA9A9A9),
      500: Color(0xFFC0C0C0),
      600: Color(0xFFC0C0C0),
      700: Color(0xFFC0C0C0),
    },
  );
  MaterialColor chatSenderTextColor = MaterialColor(
    0xFFFFFFFF,
    <int, Color>{
      100: Color(0xFFFFFFFF),
      200: Color(0xFF696969),
      300: Color(0xFF808080),
      400: Color(0xFFA9A9A9),
      500: Color(0xFFC0C0C0),
      600: Color(0xFFC0C0C0),
      700: Color(0xFFC0C0C0),
    },
  );
  MaterialColor chatSelfRowBgColor = MaterialColor(
    0xFFf4f1ec,
    <int, Color>{
      100: Color(0xFFf4f1ec),
      200: Color(0xFF696969),
      300: Color(0xFF808080),
      400: Color(0xFFA9A9A9),
      500: Color(0xFFC0C0C0),
      600: Color(0xFFC0C0C0),
      700: Color(0xFFC0C0C0),
    },
  );
  MaterialColor chatSelfTextColor = MaterialColor(
    0xFF242424,
    <int, Color>{
      100: Color(0xFF000000),
      200: Color(0xFF696969),
      300: Color(0xFF808080),
      400: Color(0xFFA9A9A9),
      500: Color(0xFFC0C0C0),
      600: Color(0xFFC0C0C0),
      700: Color(0xFFC0C0C0),
    },
  );

  MaterialAccentColor circleColor = MaterialAccentColor(
    0xFF726344,
    <int, Color>{
      100: Color(0xFF003071),
      200: Color(0xFFded7ca),
      300: Color(0xFF00aeef),
      400: Color(0xFF00aeef),
      500: Color(0xFFffc3f5),
      600: Color(0xFFffc3f5),
      700: Color(0xFFffc3f5),
    },
  );
  MaterialAccentColor iconColor = MaterialAccentColor(
    0xFF726344,
    <int, Color>{
      100: Color(0xFFdadfe2),
      200: Color(0xFF4AA546),
      300: Color(0xFFf4f6f7),
      400: Color(0xFFded7ca),
      500: Color(0xFFffc3f5),
      600: Color(0xFFffc3f5),
      700: Color(0xFFffc3f5),
    },
  );

  MaterialAccentColor datetimeColor = MaterialAccentColor(
    0xFF8fa0b4,
    <int, Color>{
      100: Color(0xFFdadfe2),
      200: Color(0xFF4AA546),
      300: Color(0xFF00aeef),
      400: Color(0xFF00aeef),
      500: Color(0xFFffc3f5),
      600: Color(0xFFffc3f5),
      700: Color(0xFFffc3f5),
    },
  );


  List<Color> gredientColor =  [
    Color(0xFFeaeaee),
    Color(0xFFdae6f7),
  ];
}

//different color opacity code
/*
100% — FF
95% — F2
90% — E6
85% — D9
80% — CC
75% — BF
70% — B3
65% — A6
60% — 99
55% — 8C
50% — 80
45% — 73
40% — 66
35% — 59
30% — 4D
25% — 40
20% — 33
15% — 26
10% — 1A
5% — 0D
0% — 00
*/
