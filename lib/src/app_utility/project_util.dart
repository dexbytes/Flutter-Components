import 'dart:convert';
import 'dart:io';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:fullter_main_app/src/all_file_import/app_utils_files_link.dart';
import 'package:fullter_main_app/src/all_file_import/app_values_files_link.dart';
import 'package:fullter_main_app/src/all_file_import/app_widget_files_link.dart';
import 'package:fullter_main_app/src/api_calling/api_constant.dart';
import 'package:flutter/material.dart';
import 'package:fullter_main_app/src/api_calling/app_api_function.dart';
import 'package:get_version/get_version.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart'
    as timeago; //Add this dependancy  timeago: ^2.0.22

class ProjectUtil {
  static var screenSize;
  static DateTime oldDate;
  screenSizeValue(context) {
    screenSize = MediaQuery.of(context).size;
    return screenSize;
  }

  String initials(String givenName, String familyName) {
    return ((givenName?.isNotEmpty == true ? givenName[0] : "") +
        ((familyName?.isNotEmpty == true ? familyName[0] : "")).toUpperCase());
  }

  String getCompareDateStr(String timestamp, String format, int index) {
    String formattedTime = "";
    try {
      if (index <= 0) {
        oldDate = null;
      }
      int time = int.parse(timestamp);
      print('error in formatting $time');
      DateTime date = new DateTime.fromMillisecondsSinceEpoch(time);
      if (oldDate == null) {
        oldDate = date;
        formattedTime = new DateFormat(format).format(oldDate);
      } else {
        String formattedTimeOld = "";
        String formattedTimeCurrent = "";
        formattedTimeOld = new DateFormat(format).format(oldDate);
        formattedTimeCurrent = new DateFormat(format).format(date);
        if (formattedTimeOld == formattedTimeCurrent) {
          formattedTime = null;
        } else {
          oldDate = date;
          formattedTime = new DateFormat(format).format(oldDate);
        }
      }
    } catch (e) {
      formattedTime = "";
      print('error in formatting $e');
    }
    return formattedTime;
  }

  /*================== Convert time from timestamp ===================*/
  String getTime(int timestamp, String format) {
    String formattedTime = "";
    try {
      formattedTime = DateFormat(format)
          .format(DateTime.fromMicrosecondsSinceEpoch(timestamp));
    } catch (e) {
      formattedTime = "";
      printP('error in formatting $e');
    }
    return formattedTime;
  }

  String getCountDownTimer(int timestamp, String format) {
    String formattedTime = "";
    try {
      formattedTime = DateFormat(format)
          .format(DateTime.fromMicrosecondsSinceEpoch(timestamp));
    } catch (e) {
      formattedTime = "";
      printP('error in formatting $e');
    }
    return formattedTime;
  }

  //Print message/response on logcat
  printP(String body) {
    try {
      if (!ConstantC.isProduction) {
        print(body != null ? "$body" : "");
      }
    } catch (e) {
      print(e);
    }
  }

  //get first letter from string
  getFirstLetterFromName(String word) {
    var firstAndLastLetter = "NA";
    if (word != null) {
      if (word.trim() != null && word.trim() != "") {
        List wordSplit = [];
        var firstLetter = "";
        var lastLetter = "";
        if (word.contains(" ")) {
          wordSplit = word.split(" ");
          try {
            firstLetter = String.fromCharCode(word.runes.first);
          } catch (e) {
            print(e);
          }
          if (wordSplit.length > 1) {
            try {
              String lastWordString = wordSplit[1];
              lastLetter = String.fromCharCode(lastWordString.runes.first);
            } catch (e) {
              print(e);
            }
          }
        } else {
          try {
            firstLetter = String.fromCharCode(word.runes.first);
            firstLetter = getDecodedValue(firstLetter);
          } catch (e) {
            print(e);
          }
        }
        firstAndLastLetter = firstLetter.toString().toUpperCase() +
            lastLetter.toString().toUpperCase();
      } else {
        return firstAndLastLetter;
      }
    }
    return firstAndLastLetter;
  }

  //get build version of app
  getVersionName() async {
    String projectVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      projectVersion = await GetVersion.projectVersion;
      printP('$projectVersion');
    } catch (e) {
      projectVersion = '';
      printP('$e');
    }
    return projectVersion;
  }

  //get decoded format
  getDecodedValue(String value) {
    String decodedValue = value;
    try {
      decodedValue = utf8.decode(value.codeUnits);
    } catch (err) {
      printP("$err");
    }
    return decodedValue;
  }

  String getTimeAgo({Key key, @required int timestamp, String format}) {
    //Note /*
    //
    //
    // Add this dependancy
    // timeago: ^2.0.22
    //
    // */
    String formattedTime = "";
    try {
      if (format != null) {
      } else {
        final fifteenAgo = DateTime.fromMillisecondsSinceEpoch(timestamp);
        formattedTime = timeago.format(fifteenAgo, locale: 'en');
      }
    } catch (e) {
      formattedTime = "";
      printP('error in formatting $e');
    }
    return formattedTime;
  }

  //Exit from app
  Future<void> logOutFromAppUnAuthUser({context}) async {
    try {
      await sharedPreferencesFile.clearAll();
      /*  Navigator.pushAndRemoveUntil(
          context,
          SlideRightRoute(
              widget: AppScreensFilesLink().mLoginOptionScreen()),
          ModalRoute.withName(screenLoginScreen));*/
    } catch (e) {
      print(e);
    }
  }

  Future removeBadge() {
    try {
      FlutterAppBadger.removeBadge();
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future addBadge(count) {
    if (count > 0) {
      try {
        try {
          FlutterAppBadger.updateBadgeCount(count);
        } catch (e) {
          print(e);
        }
      } catch (e) {
        print(e);
      }
    } else {
      try {
        removeBadge();
      } catch (e) {
        print(e);
      }
    }

    return null;
  }

  Future<String> checkAppVersion(
      deviceType, versionUpdatePopupCallBack, context) async {
    int deviceType;
    if (Platform.isIOS) {
      deviceType = 1;
    } else if (Platform.isAndroid) {
      deviceType = 2;
    }
    //1 for ios
    apiRequest.checkAppVersion(deviceType: deviceType).then((result) {
      if (result != null) {
        if (result.success && result.result != null) {
          //Android
          if (deviceType == 2) {
            if (result.result.version != null) {
              String playStoreAndroidVersion = result.result.version;
              try {
                GetVersion.projectVersion.then((appVersion) {
                  //String   currentAndroidVersion = appVersion;
                  if (playStoreAndroidVersion != null &&
                      playStoreAndroidVersion != appVersion) {
                    versionUpdatePopupCallBack(true);
                  } else {
                    versionUpdatePopupCallBack(true);
                  }
                });
              } catch (e) {
                print('$e');
              }
            }
          }
          //Ios
          if (deviceType == 1) {
            if (result.result.version != null) {
              String iOSAppStoreVersion = result.result.version;
              try {
                GetVersion.projectCode.then((appVersion) {
                  // String  currentIOSVersion = appVersion;
                  if (iOSAppStoreVersion != null &&
                      iOSAppStoreVersion != appVersion) {
                    versionUpdatePopupCallBack(true);
                  } else {
                    versionUpdatePopupCallBack(true);
                  }
                });
              } catch (e) {
                print(e);
              }
            }
          }
        } else {
          ErrorAlert(
              context: context,
              isItForInternet: true,
              alertTitle: appString.appName,
              message: result.msg,
              callBackYes: (context1) async {
                Navigator.pop(context1);
                if (result.statusCode == -2000) {
                  exit(0);
                  //await sharedPreferencesFile.clearAll();
                }
              });
        }
        return null;
      } else {
        return null;
        //Fluttertoast.showToast(msg: "해당 데이터가 존재하지 않습니다");
      }
    });
    return null;
  }
}

ProjectUtil projectUtil = new ProjectUtil();
