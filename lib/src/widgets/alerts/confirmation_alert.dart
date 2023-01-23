import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fullter_main_app/src/all_file_import/app_values_files_link.dart';
import 'package:fullter_main_app/src/values/app_color.dart';

//Selected menu call back function type
typedef ContextCallback = Function(BuildContext alertContext);

class ConfirmationAlert {
  BuildContext context;
  String alertTitle;
  String message;
  String positiveActionText;
  String negativeActionText;
  TextStyle textStylePositiveActionIos;
  TextStyle textStyleNegativeActionIos;

  TextStyle textStyleNegativeActionAndroid;
  TextStyle textStylePositiveActionAndroid;

  ContextCallback callBackYes;
  ContextCallback noCallback;
  bool isAndroid;

  ConfirmationAlert(
      {Key key,
      @required this.context,
      this.alertTitle = "Alert",
      this.positiveActionText = "Yes",
      this.negativeActionText = "No",
      this.message = "This is confirmation alert",
      this.textStylePositiveActionIos,
      this.textStyleNegativeActionIos,
      this.callBackYes,
      this.isAndroid = false,
      this.noCallback})
      : assert(message != null) {
    //Check specific device platform
    if (Platform.isIOS) {
      this.isAndroid = false;
    } else if (Platform.isAndroid) {
      this.isAndroid = true;
    }
    confirmationAlert();
  }

  // Render conformation alert.
  Future<bool> confirmationAlert() {
    return showDialog(
        barrierColor: Colors.transparent,
        context: this.context,
        barrierDismissible: false,
        builder: (alertContext) {
          // Check device platform
          return this.isAndroid
          // This will work for android platform
              ? AlertDialog(
                  title: new Text(this.alertTitle,
                      style: new TextStyle(
                          color: AppColors().lightBlack, fontSize: 20.0)),
                  content: new Text(this.message),
                  actions: <Widget>[
                    // Text button for perform No.
                    TextButton(
                      child: buildTextNegativeAction(),
                      onPressed: () {
                        // Use callback to perform relevant action
                        this.noCallback(alertContext);
                        Navigator.pop(alertContext);
                      },
                    ),
                    // Text button for perform No.
                    TextButton(
                      child: buildTextPositiveAction(),
                      onPressed: () {
                        // Use callback to perform relevant action
                        this.callBackYes(alertContext);
                        Navigator.pop(alertContext);
                      },
                    )
                  ],
                )
              // This will work for iOS platform
              : CupertinoAlertDialog(
                  title: new Text(this.alertTitle,
                      style: new TextStyle(
                          color: AppColors().lightBlack, fontSize: 20.0)),
                  content: new Text(message ?? ""),
                  actions: <Widget>[
                    TextButton(
                      child: buildTextNegativeAction(),
                      onPressed: () {
                        // Use callback to perform relevant action
                        this.noCallback(alertContext);
                        Navigator.pop(alertContext);
                      },
                    ),
                    TextButton(
                      child: buildTextPositiveAction(),
                      onPressed: () {
                        // Use callback to perform relevant action
                        this.callBackYes(alertContext);
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
    textView = textStylePositiveActionIos != null
        ? Text("$positiveActionText", style: textStylePositiveActionIos)
        : Text("$positiveActionText");
    //Android
    if (isAndroid) {
      textView = textStylePositiveActionAndroid != null
          ? Text("$positiveActionText", style: textStylePositiveActionAndroid)
          : Text("$positiveActionText");
    }
    return textView;
  }

  // Build platform platform specific navigation text
  Text buildTextNegativeAction({Color textColorItem}) {
    Text textView;

    //Ios
    textView = textStyleNegativeActionIos != null
        ? Text("$negativeActionText", style: textStyleNegativeActionIos)
        : Text("$negativeActionText");
    //Android
    if (isAndroid) {
      textView = textStyleNegativeActionAndroid != null
          ? Text("$negativeActionText", style: textStylePositiveActionAndroid)
          : Text("$negativeActionText");
    }
    return textView;
  }
}
