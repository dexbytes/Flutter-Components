import 'package:flutter/material.dart';
import 'package:fullter_main_app/src/all_file_import/app_values_files_link.dart';

Color mColorT;
bool isBgT;
double heightT = 60;
double widthT = 60;
int loaderTypeT = 0;

class WorkSpace extends StatelessWidget {
  WorkSpace({Key key, bool isBg, Color mcolor, double height, double widht}) {
    isBgT = isBg;
    mColorT = mcolor;
    if (height != null && height > 0) {
      heightT = height;
    }
    if (widht != null && widht > 0) {
      widthT = widht;
    }
  }

  @override
  Widget build(BuildContext context) {
    return loaderTypeT == 1
        ?
    Container(
        alignment: Alignment(0, 0),
        child: Container(
          height: heightT,
          width: widthT,
          decoration: new BoxDecoration(
            color: isBgT
                ? (mColorT != null
                ? mColorT
                : AppColors().loaderBgColor)
                : Colors.transparent,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                    AppColors().loaderColor[100])),
          ),
        ))
        :
        //Normal Loader
        Container(
            alignment: Alignment(0, 0),
            child: Container(
              height: heightT,
              width: widthT,
              decoration: new BoxDecoration(
                color: isBgT
                    ? (mColorT != null
                        ? mColorT
                        : AppColors().loaderBgColor)
                    : Colors.transparent,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                        AppColors().loaderColor[100])),
              ),
            ));
  }
}
