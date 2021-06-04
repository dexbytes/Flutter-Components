import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'notification_stream.dart';

class NotificationState extends ChangeNotifier {
  bool couponNotification;
  bool get isCouponNotification => couponNotification;
  set setCouponNotification(bool value) {
    couponNotification = value;
    notifyListeners();
  }

  //Trigger notification on rental record screen when notification come
  void onNotification(NotificationFor notificationFor) {
    //DataRefreshStream.instance.newNotification(notificationFor);
    notifyListeners();
  }
}
