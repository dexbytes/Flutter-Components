import 'package:flutter/material.dart';

class CameraOptionImageWidget extends StatelessWidget {
  CameraOptionImageWidget();
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: MediaQuery.of(context).size.width / 2.4,
          height: MediaQuery.of(context).size.height / 7.5,
          decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.white),
                  borderRadius: new BorderRadius.all(new Radius.circular(4))),
              color: Colors.transparent),
          child: Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.camera_alt,
                  color: Colors.white,
                ),
                Text(
                  "Open Camera", //your text here
                  style: new TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.white, //your textColor
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
