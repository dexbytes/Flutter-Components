import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fullter_main_app/src/all_file_import/app_values_files_link.dart';
import 'package:fullter_main_app/src/values/app_color.dart';

//Selected menu call back function type
typedef ContextCallback = Function(BuildContext alertContext);

class InfoAlert {
  BuildContext context;
  String alertTitle;
  String message;
  String confirmActionText;
  TextStyle textStyleConfirmActionIos;
  TextStyle textStyleConfirmActionAndroid;
  ContextCallback callBackConfirm;
  bool isAndroid;

  InfoAlert(
      {Key key,
      @required this.context,
      this.alertTitle = "Alert",
      this.confirmActionText = "Ok",
      this.message = "This is inform alert",
      this.textStyleConfirmActionIos,
      this.textStyleConfirmActionAndroid,
      this.callBackConfirm,
      this.isAndroid = false})
      : assert(message != null) {
    //Check device platform
    /* if (Platform.isIOS) {
      this.isAndroid = false;
    } else if (Platform.isAndroid) {
      this.isAndroid = true;
    }*/
    infoAlert();
  }
  Future<bool> infoAlert() {
    return showDialog(
        barrierColor: Colors.transparent,
        context: this.context,
        barrierDismissible: false,
        builder: (alertContext) {
          //mContext = context1;
          return this.isAndroid
              ? AlertDialog(
                  // backgroundColor: Colors.transparent,
                  title: new Text(this.alertTitle,
                      style: new TextStyle(
                          color: AppColors().lightBlack, fontSize: 20.0)),
                  content: new Text(this.message),
                  actions: <Widget>[
                    TextButton(
                      child: buildTextPositiveAction(),
                      onPressed: () {
                        this.callBackConfirm(alertContext);
                        Navigator.pop(alertContext);
                      },
                    )
                  ],
                )
              : CupertinoAlertDialog(
                  // backgroundColor: Colors.transparent,
                  title: new Text(this.alertTitle,
                      style: new TextStyle(
                          color: AppColors().lightBlack, fontSize: 20.0)),
                  content: new Text(message ?? ""),
                  actions: <Widget>[
                    TextButton(
                      child: buildTextPositiveAction(),
                      onPressed: () {
                        this.callBackConfirm(alertContext);
                        Navigator.pop(alertContext);
                      },
                    )
                  ],
                );
        });
  }

  Text buildTextPositiveAction({Color textColorItem}) {
    Text textView;
    //Ios
    textView = textStyleConfirmActionIos != null
        ? Text("$confirmActionText", style: textStyleConfirmActionIos)
        : Text("$confirmActionText");
    //Android
    if (isAndroid) {
      textView = textStyleConfirmActionAndroid != null
          ? Text("$confirmActionText", style: textStyleConfirmActionAndroid)
          : Text("$confirmActionText");
    }
    return textView;
  }
}
