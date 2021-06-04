import 'dart:core';
import 'package:flutter/material.dart';

import '../../photo_gallery_main.dart';


class AppBarCamera extends StatelessWidget implements PreferredSizeWidget{
  final backPress;
  final okPress;
  final String title;
  final String doneBtnText;
  final int selectedItemCount;
  final double profileSize;
  final Color appBarColorOnItemSelected;
  final Color appBarColor;
  final Color appBarIconColor;

  AppBarCamera({Key key,this.backPress,this.okPress,this.title = "Gallery",this.doneBtnText = "Done",this.selectedItemCount = 0,this.profileSize = 0,this.appBarColorOnItemSelected = Colors.orange,this.appBarColor =  Colors.white,this.appBarIconColor =  Colors.white}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isItemSelected = selectedItemCount<=0?false:true;
    Color doneBtnColor = isItemSelected?Colors.white:Colors.black;
    Color backArrowColor = appBarIconColor;
    Color titleColor = isItemSelected?Colors.white:Colors.black;
    Color appBarBgColor = isItemSelected?this.appBarColorOnItemSelected:this.appBarColor;

    Widget doneBtn() => !isItemSelected?Container():Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(child: Text(
          "$doneBtnText",
          style: appStyle.appBarDoneBtnTextStyle(texColor: doneBtnColor),
        ),onTap: okPress,),
      ),
    );
    Widget titleWidget() => Align(alignment: Alignment.centerLeft,
      child: Padding(
        padding: EdgeInsets.only(left: 0,right: 0),
        child: Text(
          //  "Home Image ($selectedCount/${imageSelectState.getTotalNumberOfImage})",
          "$title",
          style: appStyle.appBarTitleStyle(texColor: titleColor),
        ),
      ),
    );
    return AppBar(backgroundColor: appBarBgColor,
      title: titleWidget(),
      leading:
        IconButton(
            icon:Icon(
              Icons.arrow_back_ios,
              color: backArrowColor,
            ),
            onPressed: () => backPress()
        ),
      actions: <Widget>[
        doneBtn(),
      ],
    ) ;
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize {
    return Size.fromHeight(profileSize!=null?profileSize:56.0);
  }

}