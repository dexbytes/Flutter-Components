import 'package:flutter/material.dart';

class AppDimens {
  static MediaQueryData _mediaQueryData;
  double _safeAreaHorizontal;
  double _safeAreaVertical;

  BuildContext context;
  double buttonHeightRatio = 7.5; // It will apply in the app if custom value not received
  double buttonWidthRatio = 20; // It will apply in the app if custom value not received

  double editFieldHeightRatio = 40; // It will apply in the app if custom value not received
  double editFieldWidthRatio = 20; // It will apply in the app if custom value not received

  double fountSizeRatio = 4; // It will apply in the app if custom value not received
  double fountSizeButtonRatio = 5; // It will apply in the app if custom value not received

  double radiusValue = 50; // It will apply in the app if custom value not received
  double radiusCustomValue = 5; //It will apply in the app if custom value not received

  double iconValue = 50; // It will apply in the app if custom value not received
  double iconCustomValue = 5; //It will apply in the app if custom value not received

  double imageCustomValue = 50; //It will apply in the app if custom value not received


  double verticalMarginValue = 1.5; //It will apply in the app if custom value not received
  double horizontalMarginValue = 5; //It will apply in the app if custom value not received
  double buttonHorizontalPadding = 20; //It will apply in the app if custom value not received

  //Find Device height and width
  appDimensFind({Key key, @required BuildContext context})
  {
    if (context != null)
    {
      _mediaQueryData = MediaQuery.of(context);
    }
  }

  double sizeHorizontalCalculate() {
    double screenWidth = 0.0 ;
    double safeBlockHorizontal = 0.0;
    screenWidth = _mediaQueryData.size.width;
    _safeAreaHorizontal = _mediaQueryData.padding.left + _mediaQueryData.padding.right;
    safeBlockHorizontal = (screenWidth - _safeAreaHorizontal) / 100;
    return safeBlockHorizontal;
  }

  double sizeVerticalCalculate ()
  {
    double screenHeight = 0;
    double safeBlockVertical = 0;
    screenHeight = _mediaQueryData.size.height;
    _safeAreaVertical = _mediaQueryData.padding.top + _mediaQueryData.padding.bottom;
    safeBlockVertical = ( screenHeight - _safeAreaVertical) / 100;
    return safeBlockVertical;
  }

  //**************************************************************************//

  //Dynamic height
  double statusBarHeight()
  {
    try
    {
      double value = _mediaQueryData.padding.top;
      return value;
    }
    catch (e)
    {
      print(e);
      return 0.0;
    }
  }

  //Appbar height
  double appBarHeight()
  {
    try
    {
      double value = kBottomNavigationBarHeight;
      return value;
    }
    catch (e)
    {
      print(e);
      return 0.0;
    }
  }


  //Dynamic height
  double heightFullScreen()
  {
    try
    {
      double value = _mediaQueryData.size.height;
      return value;
    }
    catch (e)
    {
      print(e);
      return 0.0;
    }
  }

//Dynamic width
  double widthFullScreen()
  {
    try
    {
      double value = _mediaQueryData.size.width;
      return value;
    }
    catch (e)
    {
      print(e);
      return 0;
    }
  }


//Dynamic height
  double heightDynamic({ Key key,  @required double value})
  {
    try
    {
      //value = (sizeVerticalCalculate()* value);
      return value;
    }
    catch (e)
    {
      print(e);
      return 0.0;
    }
  }

//Dynamic width
  double widthDynamic({ Key key,  @required double value})
  {
    try
    {
      //return sizeHorizontalCalculate() * value;
      return value;
    }
    catch (e)
    {
      print(e);
      return 0;
    }
  }


//Button height
  double buttonHeight({ Key key,  double value = 45})
  {
    try
    {

      // return sizeVerticalCalculate() * (value != null ? value : buttonHeightRatio);
      return value;
    }
    catch (e)
    {
      print(e);
      return 0;
    }
  }
//Button width
  double buttonWidth({ Key key,  double value})  {
    try
    {
      return sizeHorizontalCalculate() * (value != null ? value : buttonWidthRatio);
    }
    catch (e)
    {
      print(e);
      return 0;
    }
  }


//Edit Field height
  double editFiledHeight({ Key key,  double value})
  {
    try
    {
      return sizeVerticalCalculate() * (value != null ? value : editFieldHeightRatio);
    }
    catch (e)
    {
      print(e);
      return 0;
    }
  }
//Edit Field width
  double editFiledWidth({ Key key,  double value})
  {
    try {
      return sizeHorizontalCalculate() * (value != null ? value : editFieldWidthRatio);
    }
    catch (e)
    {
      print(e);
      return 0;
    }

  }//Edit Field width
  double fontSize({ Key key,  double value}){
    try
    {
      // return sizeHorizontalCalculate() * (value != null ? value : fountSizeRatio);
      return value;
    }
    catch (e)
    {
      print(e);
      return 0;
    }
  }

  double fontSizeButton({ Key key,  double value}){
    try
    {
      //return sizeHorizontalCalculate() * (value != null ? value : fountSizeButtonRatio);
      return value;
    }
    catch (e)
    {
      print(e);
      return 0;
    }
  }


//Radius According Screen
  double radiusAccordingScreen({ Key key,  double value})  {
    try
    {
      return sizeHorizontalCalculate() * (value != null ? value : radiusValue);
    }
    catch (e)
    {
      print(e);
      return 0;
    }
  }
//Radius Radius Custom
  double radiusCustom({ Key key,double value})  {
    try
    {
      return (value != null ? value : radiusValue);
    }
    catch (e)
    {
      print(e);
      return 0;
    }
  }

  //All Side margin padding
  EdgeInsets marginPaddingAllSideEqual(
      { Key key, double value = 5})  {
    EdgeInsets paddingAllSide = EdgeInsets.all(5);
    try
    {
      paddingAllSide = EdgeInsets.all(value);
      //return sizeVerticalCalculate() * (value != null ? value : verticalMarginValue);
    }
    catch (e) {
      print(e);
    }
    return paddingAllSide;
  }
  //All Side margin padding
  EdgeInsets marginPaddingAllSideDynamicAppScreen(
      { Key key, double left = 5,double top = 5,double right = 5,double bottom = 5})  {
    EdgeInsets paddingAllSide = EdgeInsets.fromLTRB(5,5,5,5);
    try {
      paddingAllSide = EdgeInsets.fromLTRB(left,top,right,bottom);
      //return sizeVerticalCalculate() * (value != null ? value : verticalMarginValue);
    }
    catch (e) {
      print(e);
    }
    return paddingAllSide;
  }

  //All Side margin padding
  EdgeInsets marginPaddingAllSideDynamic(
      { Key key, double left = 5,double top = 5,double right = 5,double bottom = 5})  {
    EdgeInsets paddingAllSide = EdgeInsets.fromLTRB(5,5,5,5);
    try {
      paddingAllSide = EdgeInsets.fromLTRB(left,top,right,bottom);
      //return sizeVerticalCalculate() * (value != null ? value : verticalMarginValue);
    }
    catch (e) {
      print(e);
    }
    return paddingAllSide;
  }



  //Vertically and Horizontally padding margin
  EdgeInsets marginPaddingVerticalHorizontal(
      { Key key,double horizontal = 5 ,double vertical = 5})  {
    EdgeInsets paddingAllSide = EdgeInsets.symmetric(horizontal: 5, vertical: 5);
    try {
      paddingAllSide = EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical);
      //return sizeVerticalCalculate() * (value != null ? value : verticalMarginValue);
    }
    catch (e) {
      print(e);
    }
    return paddingAllSide;
  }

  //Vertically padding/margin
  EdgeInsets marginPaddingVertical(
      { Key key,double vertical = 5})  {
    EdgeInsets paddingAllSide = EdgeInsets.symmetric(vertical: 5);
    try {
      paddingAllSide = EdgeInsets.symmetric(vertical: vertical);
      //return sizeVerticalCalculate() * (value != null ? value : verticalMarginValue);
    }
    catch (e) {
      print(e);
    }
    return paddingAllSide;
  }

  //Horizontally padding/margin
  EdgeInsets marginPaddingHorizontal(
      { Key key,double horizontal = 5})  {
    EdgeInsets paddingAllSide = EdgeInsets.symmetric(horizontal: 5);
    try {
      paddingAllSide = EdgeInsets.symmetric(horizontal: horizontal);
      //return sizeVerticalCalculate() * (value != null ? value : verticalMarginValue);
    }
    catch (e) {
      print(e);
    }
    return paddingAllSide;
  }






//Vertical Margin
  double verticalMarginPadding(
      { Key key, double value})  {
    try {
      //return sizeVerticalCalculate() * (value != null ? value : verticalMarginValue);
      return value;
    }
    catch (e) {
      print(e);
      return 0;
    }
  }
//Horizontal Margin
  double horizontalMarginPadding(
      { Key key,  double value})  {
    try {
      //return sizeHorizontalCalculate() * (value != null ? value : horizontalMarginValue);
      return value;
    }
    catch (e) {
      print(e);
      return 0;
    }
  }

//Icon According Screen
  double iconSquareAccordingScreen(
      { Key key,  double value})  {
    try {
      return sizeHorizontalCalculate() * (value != null ? value : iconCustomValue);
    }
    catch (e) {
      print(e);
      return 0;
    }
  }
//Icon Custom
  double iconSquareCustom(
      { Key key,  double value})  {
    try {
      // return (value != null ? value : iconValue);
      return value;
    }
    catch (e) {
      print(e);
      return 0;
    }
  }

//Image According Screen
  double imageSquareAccordingScreen(
      { Key key,  double value})  {
    try {
      //  return sizeHorizontalCalculate() * (value != null ? value : imageCustomValue);
      return value;
    }
    catch (e) {
      print(e);
      return 0;
    }
  }}
