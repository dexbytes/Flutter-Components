import 'dart:core';
import 'package:flutter/material.dart';
import 'package:image_camera_gallery/src/state/imageSelectState.dart';

import '../../photo_gallery_main.dart';

class AppBarGallery extends StatelessWidget implements PreferredSizeWidget {
  final backPress;
  final okPress;
  final String title;
  final String doneBtnText;
  final int selectedItemCount;
  final double profileSize;
  final Color appBarColorOnItemSelected;
  final Color appBarColor;
  final ImageSelectState controllerImageSelectState;

  AppBarGallery(
      {Key key,
      this.backPress,
      this.okPress,
      this.title = "Gallery",
      this.doneBtnText = "Done",
      this.selectedItemCount = 0,
      this.controllerImageSelectState,
      this.profileSize = 0,
      this.appBarColorOnItemSelected = Colors.orange,
      this.appBarColor = Colors.white})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String titleText = title;
    bool isItemSelected = false;
    if (controllerImageSelectState != null &&
        controllerImageSelectState.getSelectedImageCounts > 0) {
      isItemSelected = true;
      titleText =
          "${controllerImageSelectState.getSelectedImageCounts} Selected";
    } else {
      isItemSelected = false;
    }
    Color doneBtnColor = isItemSelected ? Colors.white : Colors.black;
    Color backArrowColor = isItemSelected
        ? appStyle.appBarHighlightColorItems
        : appStyle.appBarColorItems;
    Color titleColor = isItemSelected
        ? appStyle.appBarHighlightColorItems
        : appStyle.appBarColorItems;
    Color appBarBgColor = isItemSelected
        ? appStyle.appBarHighlightColorBg
        : appStyle.appBarColorBg;

    Widget doneBtn() => !isItemSelected
        ? Container()
        : Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                child: Text(
                  "$doneBtnText",
                  style:
                      appStyle.appBarDoneBtnTextStyle(texColor: doneBtnColor),
                ),
                onTap: okPress,
              ),
            ),
          );
    Widget titleWidget() => Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.only(left: 0, right: 0),
            child: Text(
              //  "Home Image ($selectedCount/${imageSelectState.getTotalNumberOfImage})",
              "$titleText",
              style: appStyle.appBarTitleStyle(texColor: titleColor),
            ),
          ),
        );
    return AppBar(
      backgroundColor: appBarBgColor,
      title: titleWidget(),
      leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: backArrowColor,
          ),
          onPressed: () => backPress()),
      actions: <Widget>[
        doneBtn(),
      ],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize {
    return Size.fromHeight(profileSize != null ? profileSize : 56.0);
  }
}
