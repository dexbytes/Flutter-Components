import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_camera_gallery/src/state/imageSelectState.dart';
import 'package:photo_manager/photo_manager.dart';
import '../../photo_gallery_main.dart';

typedef SelectPhotoOptionCallback = Function(
    {String selectedOption, int itemIndex});

class PhotoPickerOptionWidget extends StatefulWidget {
  final SelectPhotoOptionCallback selectPhotoOptionCallback;
  PhotoPickerOptionWidget({this.selectPhotoOptionCallback});
  @override
  _PhotoPickerOptionWidgetState createState() =>
      _PhotoPickerOptionWidgetState();
}

class _PhotoPickerOptionWidgetState extends State<PhotoPickerOptionWidget> {
  double listHeight = 50;
  int selectedIndex = 0;
  List<String> photoPickerOptionList = [
    "Gallery",
    "Photo",
    "Video",
    "Downloads",
    "Other"
  ];
  void initState() {
    return super.initState();
  }

  void dispose() {
    super.dispose();
  }

  void clickAction(int index) {
    setState(() {
      // if(selectedIndex==-1){
      selectedIndex = index;
      /*}
      else if(selectedIndex==index){
        selectedIndex = -1
      }*/
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
      height: listHeight,
      color: appStyle.screenBgColor,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: photoPickerOptionList.length,
          itemBuilder: (context, index) {
            Color selectedItemColor =
                selectedIndex == index ? Colors.white : Colors.white70;
            return InkWell(
              onTap: () {
                clickAction(index);
                if (widget.selectPhotoOptionCallback != null) {
                  widget.selectPhotoOptionCallback(
                      selectedOption: '${photoPickerOptionList[index]}',
                      itemIndex: index);
                }
              },
              child: Container(
                //color: Colors.greenAccent,
                margin: EdgeInsets.symmetric(horizontal: 5),
                child: Align(
                  alignment: Alignment.center,
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 0),
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      '${photoPickerOptionList[index]}',
                      style: TextStyle(color: selectedItemColor),
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
