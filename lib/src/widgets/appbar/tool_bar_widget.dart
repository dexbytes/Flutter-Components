import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fullter_main_app/src/all_file_import/app_values_files_link.dart';
import 'package:provider/provider.dart';

class ToolBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final TextStyle titleStyle;
  final double profileSize;
  final Widget appBarLeftIcons;
  final String notificationCount;
  final double leftIconSize;
  final double marginLeft;
  final double marginRight;
  final Color appBarBgColor;
  final Function() onPressed;
  final Function() onLeftIconPressed;
  final List<Widget> appBarRightIcons;
  final double statusBarHeight;
  final bool isAndroid;

  ToolBarWidget(
      {Key key,
      this.isAndroid = true,
      this.statusBarHeight,
      this.title = "",
      this.titleStyle,
      this.profileSize,
      this.appBarLeftIcons,
      this.notificationCount = "0",
      this.leftIconSize = 25,
      this.marginLeft = 0,
      this.marginRight = 0,
      this.appBarBgColor = const Color(0xFF00aeef),
      this.onPressed,
      this.onLeftIconPressed,
      this.appBarRightIcons,
      @required context})
      : super(key: key);

  @override
  Size get preferredSize =>
      Size.fromHeight(profileSize != null ? profileSize : 56.0);

  @override
  Widget build(BuildContext context) {
    /*bool isAndroid = false;
    //Check device platform
    if (Platform.isIOS) {
      isAndroid = false;
    } else if (Platform.isAndroid) {
      isAndroid = true;
    }*/

    TextStyle appBarT1Style(
            {Color texColor, double fontSize, fontFamily, fontWeight}) =>
        TextStyle(
          color: texColor != null ? texColor : Colors.white,
          fontSize: fontSize != null ? fontSize : 20,
          fontFamily: fontFamily,
          fontWeight: fontWeight != null ? fontWeight : FontWeight.w500,
        );

    Widget leftIcon() {
      return Center(
        child: Container(
          child: appBarLeftIcons,
        ),
      );
    }

    return AppBar(
        backgroundColor: appBarBgColor,
        elevation: 0.0,
        //For card view
        flexibleSpace: Container(
          // Add box decoration
          decoration: BoxDecoration(
            // Box decoration takes a gradient
            gradient: LinearGradient(
              // Where the linear gradient begins and ends
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              // Add one stop for each color. Stops should increase from 0 to 1
              stops: [0.1, 0.6, 0.9],
              colors: [
                // Colors are easy thanks to Flutter's Colors class.
                Color(0xFFFFF),
                Color(0xFFFFF),
                Color(0xFFFFF),
              ],
            ),
          ),
        ),
        automaticallyImplyLeading: true,
        //`true` if you want Flutter to automatically add Back Button when needed,
        //or `false` if you want to force your own back button every where
        centerTitle: true,
        title: isAndroid
            ? Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 0),
                  child: new Text(title != null ? title : "",
                      style: titleStyle != null ? titleStyle : appBarT1Style(),
                      textAlign: TextAlign.center),
                ),
              )
            : Container(
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: new Text(title != null ? title : "",
                    style: titleStyle != null ? titleStyle : appBarT1Style(),
                    textAlign: TextAlign.center),
              ),
        leading: appBarLeftIcons == null
            ? Container()
            : Center(
                child: IconButton(
                  iconSize: leftIconSize,
                  icon: leftIcon(),
                  onPressed: () => onLeftIconPressed(),
                ),
              ),
        actions: appBarRightIcons);
  }
}
