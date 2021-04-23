import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fullter_main_app/src/all_file_import/app_providers_files_link.dart';

class NotificationState extends ChangeNotifier {
  bool couponNotification;
  bool get isCouponNotification => couponNotification;
  set setCouponNotification(bool value){
    couponNotification = value;
    notifyListeners();
  }

  //Trigger notification on rental record screen when notification come
  void onNotification(NotificationFor notificationFor){
      NotificationStream.instance.newNotification(notificationFor);
    notifyListeners();
  }
  //Show coupon alert
/*  void showCouponNotification({@required BuildContext context,String message = "You have received coupon!"}){
    if(context!=null && isCouponNotification==false){
      Navigator.of(context).push(CouponPopupAllertWidget(
          alertTitle:AppValuesFilesLink().appValuesString.appName,
          message:message, callBackYes:(context1) {
        Navigator.pop(context1);
        Navigator.push(context, SlideRightRoute(widget: CouponTranslationScreen()));
      }));
    }
  }*/

}
