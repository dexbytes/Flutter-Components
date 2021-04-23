import 'package:flutter_svg/flutter_svg.dart';
import 'package:fullter_main_app/src/values/app_color.dart';
import 'package:fullter_main_app/src/values/app_dimens.dart';
import 'package:fullter_main_app/src/values/app_fonts.dart';
import 'package:flutter/material.dart';

class LoaderAlert {
  LoaderAlert(
      {Key key,
      @required BuildContext context,
      String alertTitle,
      bool isItForInternet,
      message,
      callBackYes}) {
//    alertPopUp(context,success,msg,callback);
    errorDialog(context, isItForInternet, alertTitle, message, callBackYes);
  }
  alertPopUp(BuildContext context, success, msg, callback) {
    return showDialog(
        context: context,
        builder: (context1) {
          //mContext = context1;
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)), //this r
            content: GestureDetector(
              onTap: () => callback(context1),
              child: Container(
                padding: const EdgeInsets.all(8.0),
                decoration: new BoxDecoration(
                    borderRadius:
                        new BorderRadius.all(new Radius.circular(20.0)),
                    gradient: new LinearGradient(
                        colors: AppColors().gredientColor,
                        begin: const FractionalOffset(0.2, 1.0),
                        end: const FractionalOffset(0.0, 0.75),
                        stops: [0.0, 0.9],
                        tileMode: TileMode.clamp)),
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    Padding(
                        padding: EdgeInsets.only(
                            top: AppDimens().verticalMarginPadding(value: 40),
                            bottom:
                                AppDimens().verticalMarginPadding(value: 0)),
                        child: Align(
                          alignment: Alignment.center,
                          child: SvgPicture.asset(
                              success
                                  ? "assets/images/home/payment_info/success_right.svg"
                                  : "assets/images/home/payment_info/error.svg",
                              width: AppDimens().widthDynamic(value: 87),
                              height: AppDimens().widthDynamic(value: 87),
                              fit: BoxFit.scaleDown),
                        )),
                    Padding(
                        padding: EdgeInsets.only(
                            top: AppDimens().verticalMarginPadding(value: 25),
                            left:
                                AppDimens().horizontalMarginPadding(value: 15),
                            right:
                                AppDimens().horizontalMarginPadding(value: 15),
                            bottom:
                                AppDimens().verticalMarginPadding(value: 40)),
                        child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              msg ?? "",
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontFamily: AppFonts().defaultFont,
                                  color: AppColors().textSubHeadingColor[100],
                                  fontSize: AppDimens().fontSize(value: 20),
                                  fontWeight: FontWeight.w600),
                            )))
                  ],
                ),
              ),
            ),
            contentPadding: EdgeInsets.all(0.0),
          );
          // }
        });
  }

  Future<bool> errorDialog(BuildContext context1, bool isItForInternet,
      String alertTitle, String message, callBackYes) {
    return showDialog(
        context: context1,
        barrierDismissible: !isItForInternet,
        builder: (context1) {
          //mContext = context1;
          return AlertDialog(
            title: new Text(alertTitle,
                style: new TextStyle(
                    color: AppColors().lightBlack, fontSize: 20.0)),
            content: new Text(message ?? ""),
            actions: <Widget>[
              TextButton(
                child: Text("OK", style: new TextStyle(fontSize: 18.0)),
                onPressed: () => callBackYes(context1),
              )
            ],
          );
        });
  }
}
