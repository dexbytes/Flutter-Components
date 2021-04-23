import 'dart:convert';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fullter_main_app/src/all_file_import/app_providers_files_link.dart';
import 'package:fullter_main_app/src/all_file_import/app_utils_files_link.dart';
import 'package:fullter_main_app/src/helper/local_constant.dart';
import 'package:fullter_main_app/src/state/user_auth_state.dart';
import 'package:provider/provider.dart';
// import 'permissions.dart';

class FirebaseNotifications {
  //FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  static BuildContext mContext;
  var updateIcon;
  var messageType = 0;
  var messageTypeID = 0;
  var appInKillState = 1;
  var appInForeground = 2;
  var appInBackground = 3;

  bool isCalled = false;

  void setUpFirebase(BuildContext context, var updateNotificationIcon) {
    firebaseCloudMessagingListeners();
    mContext = context;
    updateIcon = updateNotificationIcon;
  }

  void firebaseCloudMessagingListeners() {
    if (Platform.isIOS) iOSPermission();

    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage message) {
      if (message != null) {}
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      /* RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;*/
      if (message != null) {
        try {
          SharedPreferencesFile().saveBool(anyNewNotificationC, true);
          updateNotificationUnreadCount();
          updateNotificationCount(notificationData: message);
        } catch (e) {
          print(e);
        }
        redirectToScreen(message, appInForeground);
        //Call when new notification Come
        try {
          Provider.of<NotificationState>(mContext, listen: false)
              .onNotification(NotificationFor.anyNotification);
        } catch (e) {
          // TODO
        }
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      if (message != null) {
        try {
          SharedPreferencesFile().saveBool(anyNewNotificationC, true);
          updateNotificationUnreadCount();
          updateNotificationCount(notificationData: message);
        } catch (e) {
          print(e);
        }
        if (!isCalled) {
          isCalled = true;
//            Fluttertoast.showToast(msg: "ONLAUNCH");
          redirectToScreen(message, appInKillState);
        }
      }
    });

    Future.delayed(Duration(seconds: 1), () {
      /*_firebaseMessaging.configure(
        onMessage: (Map<String, dynamic> message) async {
          if (message != null) {
            try {
              SharedPreferencesFile().saveBool(anyNewNotificationC, true);
              updateNotificationUnreadCount();
              updateNotificationCount(notificationData: message);
            } catch (e) {
              print(e);
            }
            redirectToScreen(message, appInForeground);
            //Call when new notification Come
            try {
              Provider.of<NotificationState>(mContext, listen: false)
                  .onNotification(NotificationFor.anyNotification);
            } catch (e) {
              // TODO
            }
          }
        },
        onResume: (Map<String, dynamic> message) async {
          if (message != null) {
            try {
              SharedPreferencesFile().saveBool(anyNewNotificationC, true);
              updateNotificationUnreadCount();
              updateNotificationCount(notificationData: message);
            } catch (e) {
              print(e);
            }
//          Fluttertoast.showToast(msg: "ONRESUME");
            redirectToScreen(message, appInBackground);
          }
        },
        onLaunch: (Map<String, dynamic> message) async {
          if (message != null) {
            try {
              SharedPreferencesFile().saveBool(anyNewNotificationC, true);
              updateNotificationUnreadCount();
              updateNotificationCount(notificationData: message);
            } catch (e) {
              print(e);
            }
            if (!isCalled) {
              isCalled = true;
//            Fluttertoast.showToast(msg: "ONLAUNCH");
              redirectToScreen(message, appInKillState);
            }
          }
        },
//        onBackgroundMessage: myBackgroundMessageHandler,
      );*/
    });
  }

  Future<void> getToken() async {
    // _firebaseMessaging.requestNotificationPermissions();
    //Permissions();
    firebaseCloudMessagingListeners();
    var token = await FirebaseMessaging.instance.getToken();
    //var token = await FirebaseMessaging.instance.getAPNSToken();
    if (token != null) {
      await sharedPreferencesFile.saveStr(deviceTokenC, token);
    }
  }

  updateNotificationUnreadCount() {
    try {
      int unreadCount = Provider.of<UserAuthState>(mContext, listen: false)
          .getNotificationUnreadCount;
      unreadCount = unreadCount + 1;
      Provider.of<UserAuthState>(mContext, listen: false)
          .setNotificationUnreadCount = unreadCount;
    } catch (e) {
      print(e);
    }
  }

  redirectToScreen(notificationData, appStatus) {
//    print('on message 1111111 $notificationData');
//    Fluttertoast.showToast(msg: "Background");
    //var response=  notificationData['data'];
    var response;
    if (Platform.isAndroid) {
      response = notificationData['data'];
    } else {
      response = notificationData;
    }

//    print('on message 333333');
    var parsingBeanData;
    if (response != null) {
      var title = "";
      try {
        title = response['notification_body'];
//        print('on message 44444 $title');
      } catch (e) {
        print(e);
      }
      String notificationData = json.encode(
          response); // Just get string data from notification data key for parsing
      Map<String, dynamic> notificationDataTemp = json.decode(
          notificationData); // Just get string data from notification data key for parsing
      //  print("$notificationDataTemp");
      String redirectionType;
      try {
        redirectionType =
            notificationDataTemp['noti_redirection_type'].toString();
      } catch (e) {
        print(e);
      }
      String userId;
      String alumniName;

      try {
        //In case of refrence user
        if (redirectionType != null && redirectionType == "1") {
          Provider.of<NotificationState>(mContext, listen: false)
              .onNotification(NotificationFor.newPosNotification);
          /* parsingBeanData = CreatePostNotificationBean.fromJson(
          json.decode(notificationData),
        );*/
        }
      } catch (e) {
        print(e);
      }

      try {
        //In case of refrence user
        if (redirectionType != null && redirectionType == "4" ||
            redirectionType != null && redirectionType == "5" ||
            redirectionType != null && redirectionType == "6") {
          Provider.of<NotificationState>(mContext, listen: false)
              .onNotification(NotificationFor.anyNotification);
          /*   parsingBeanData = CreatePostNotificationBean.fromJson(
          json.decode(notificationData),
        );*/
        }
      } catch (e) {
        print(e);
      }

      try {
        //In case of refrence user
        if (redirectionType != null && redirectionType == "3" ||
            redirectionType == "7" ||
            redirectionType == "8" ||
            redirectionType == "9") {
          /* parsingBeanData = CreatePostNotificationBean.fromJson(
          json.decode(notificationData),
        );*/
        }
      } catch (e) {
        print(e);
      }

      if (appStatus == appInForeground) {
        // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
        // If you have skipped STEP 3 then change app_icon to @mipmap/ic_launcher
        /*var initializationSettingsAndroid =
            new AndroidInitializationSettings('@mipmap/notification_icon');
        var initializationSettingsIOS = new IOSInitializationSettings();
        var mcOSInitializationSettings = new MacOSInitializationSettings();*/
/*        var initializationSettings = new InitializationSettings(
            initializationSettingsAndroid, initializationSettingsIOS,mcOSInitializationSettings);*/
        var initializationSettings = new InitializationSettings();
        flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
        flutterLocalNotificationsPlugin.initialize(initializationSettings,
            onSelectNotification: (String payload) async {
          //Following
          if (redirectionType != null && redirectionType == '1') {
            if (parsingBeanData != null) {
              try {
                userId = parsingBeanData.notiRedirectionId;
              } catch (e) {
                print("$e");
              }
            }
            try {
              if (mContext != null && userId != null) {
                /*String myId = await sharedPreferencesFile.readStr(userIdC).then((value) {
                 return value;
                });*/
              }
            } catch (e) {
              print("$e");
            }
          }

          if (redirectionType != null && redirectionType == '3') {
            if (parsingBeanData != null) {
              try {
                userId = parsingBeanData.notiRedirectionId;
              } catch (e) {
                print("$e");
              }
            }
            try {
              if (mContext != null && userId != null) {}
            } catch (e) {
              print("$e");
            }
          }

          if (redirectionType != null && redirectionType == '7' ||
              redirectionType == '8' ||
              redirectionType == '9') {
            String userId = "";
            if (parsingBeanData != null) {
              try {
                userId = parsingBeanData.notiRedirectionId;
              } catch (e) {
                print("$e");
              }
            }
            try {
              if (mContext != null && userId != null && userId != "") {}
            } catch (e) {
              print("$e");
            }
          }

          if (redirectionType != null && redirectionType == '4' ||
              redirectionType != null && redirectionType == '5' ||
              redirectionType != null && redirectionType == '6') {
            if (parsingBeanData != null) {
              try {
                userId = parsingBeanData.notiRedirectionId;
              } catch (e) {
                print("$e");
              }
            }
            try {
              if (mContext != null && userId != null) {}
            } catch (e) {
              print("$e");
            }
          }
        });

        _showNotificationWithDefaultSound(title, title);
      } else if (appStatus == appInBackground) {
//        Fluttertoast.showToast(msg: "Background");
        onSelectNotificationBackground(
            parsingBeanData, redirectionType, alumniName);
      } else if (appStatus == appInKillState) {
        onSelectNotificationBackground(
            parsingBeanData, redirectionType, alumniName);
      }
    }
  }

  local(notificationData, appStatus) {
//    print('on message 55555 $notificationData');
    if (appStatus == appInForeground) {
      // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
      // If you have skipped STEP 3 then change app_icon to @mipmap/ic_launcher
      /*var initializationSettingsAndroid =
          new AndroidInitializationSettings('@mipmap/ic_launcher');
      var initializationSettingsIOS = new IOSInitializationSettings();*/
      /*var initializationSettings = new InitializationSettings(
          initializationSettingsAndroid, initializationSettingsIOS);*/
      var initializationSettings = new InitializationSettings();
      flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
      flutterLocalNotificationsPlugin.initialize(initializationSettings,
          onSelectNotification: (String payload) async {
        //In case of follow un-follow
      });
      _showNotificationWithDefaultSound("dfds", "kxndsjf");
    } else if (appStatus == appInBackground) {
//      Fluttertoast.showToast(msg: "Background");
      //onSelectNotificationBackground(parsingBeanData, notiFor);
    } else if (appStatus == appInKillState) {
      //onSelectNotificationBackground(parsingBeanData, notiFor);
    }
  }

  void iOSPermission() {
    /* _firebaseMessaging.requestNotificationPermissions(
        IosNotificationSettings(sound: true, badge: true, alert: true));*/
    /*_firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });*/

    /* _firebaseMessaging.onIosSettingsRegistered.listen((data) {
      // save the token  OR subscribe to a topic here
    });*/

    /*_firebaseMessaging
        .requestNotificationPermissions(IosNotificationSettings());*/
  }

  // Method 2
  Future _showNotificationWithDefaultSound(title, description) async {
    title = "Highlight App";
    /*var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        'Urgent', 'Urgent', 'your channel description',
        importance: Importance.max, priority: Priority.max);
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails(
        presentAlert: true, presentBadge: true, presentSound: true);*/
    /*var platformChannelSpecifics = new NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);*/

    var platformChannelSpecifics = new NotificationDetails();
    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      description,
      platformChannelSpecifics,
      payload: 'default',
    );
  }

  Future onSelectNotificationBackground(var mNotificationFollowResponse,
      String redirectionType, String alumniName) async {
    //Following
    if (redirectionType != null && redirectionType == '1') {
      String userId = "";
      if (mNotificationFollowResponse != null) {
        try {
          userId = mNotificationFollowResponse.notiRedirectionId;
        } catch (e) {
          print("$e");
        }
      }
      try {
        if (mContext != null && userId != null && userId != "1") {
          String myId =
              await sharedPreferencesFile.readStr(userIdC).then((value) {
            return value;
          });
          SharedPreferencesFile().saveBool(anyNewNotificationC, false);
          /*   Navigator.push(
              mContext,
              SlideRightRoute(
                  widget: PostDetailsPage(
                    postId: userId,
                  )));*/
          if (myId == userId) {
          } else {}
        }
      } catch (e) {
        print("$e");
      }
    }

    if (redirectionType != null && redirectionType == '3') {
      String userId = "";
      if (mNotificationFollowResponse != null) {
        try {
          userId = mNotificationFollowResponse.notiRedirectionId;
        } catch (e) {
          print("$e");
        }
      }
      try {
        if (mContext != null && userId != null && userId != "") {
          SharedPreferencesFile().saveBool(anyNewNotificationC, false);
        }
      } catch (e) {
        print("$e");
      }
    }

    if (redirectionType != null && redirectionType == '4' ||
        redirectionType != null && redirectionType == '5' ||
        redirectionType != null && redirectionType == '6') {
      String userId = "";
      if (mNotificationFollowResponse != null) {
        try {
          userId = mNotificationFollowResponse.notiRedirectionId;
        } catch (e) {
          print("$e");
        }
      }
      try {
        if (mContext != null && userId != null && userId != "") {
          SharedPreferencesFile().saveBool(anyNewNotificationC, false);
        }
      } catch (e) {
        print("$e");
      }
    }

    if (redirectionType != null && redirectionType == '7' ||
        redirectionType == '8' ||
        redirectionType == '9') {
      String userId = "";
      if (mNotificationFollowResponse != null) {
        try {
          userId = mNotificationFollowResponse.notiRedirectionId;
        } catch (e) {
          print("$e");
        }
      }
      try {
        if (mContext != null && userId != null && userId != "") {
          SharedPreferencesFile().saveBool(anyNewNotificationC, false);
        }
      } catch (e) {
        print("$e");
      }
    }
  }

  Future<void> updateNotificationCount({notificationData}) async {
//    print('on message $notificationData');
    int count = await sharedPreferencesFile.readInt(notificationUnreadCountC);
    int countFinal = 0;
    if (count == -1) {
      count = 1;
    } else {
      count = count + 1;
    }
    await sharedPreferencesFile.saveInt(notificationUnreadCountC, count);
    countFinal = countFinal + count;
    projectUtil.addBadge(countFinal);
    try {
      updateIcon(callFromNotification: true);
    } catch (e) {
      print(e);
    }
  }

  Future<void> updateCountOnNotificationClick() async {
    /* await AppUtilsFilesLink().appSharedPreferencesFile.saveInt(anyNewNotificationC, 0);
    AppUtilsFilesLink().appProjectUtilFile.addBadge(0);
    readNotification = false;
    updateIcon(callFromNotification:true);*/
  }
}
