import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fullter_main_app/src/all_file_import/app_utils_files_link.dart';
import 'package:fullter_main_app/src/all_file_import/app_widget_files_link.dart';
import 'package:fullter_main_app/src/api_calling/api_constant.dart';
import 'package:fullter_main_app/src/api_calling/api_request.dart';
import 'package:fullter_main_app/src/helper/local_constant.dart';
import 'package:fullter_main_app/src/model/app_version_bean.dart';
import 'package:fullter_main_app/src/values/app_string.dart';
abstract class ApiCall {
  //Get otp
  //Future<dynamic> getOtp({Key key,String nationMobile,String nationCode});
  Future<dynamic> loinUser({Key key,context,userDetails});
  Future<dynamic> logOut({Key key,context});
  Future<dynamic> checkAppVersion({Key key});
  Future<dynamic> getAboutUsGet({Key key,context});
  Future<dynamic> dispose() ;
}
class ApiRequest implements ApiCall{
  static String authorization;
  static ApiRequestMain apiRequestMain;

  //Get Auth Token
  Future<String> token({bool isFirstTime}) async {
    //Call First time when
    if (isFirstTime != null && isFirstTime) {
      sharedPreferencesFile.readStr(accessTokenC).then((value) {
        authorization = value;

        return authorization;
      });
    } else if (authorization == null) {
      authorization = await sharedPreferencesFile.readStr(accessTokenC);
    }
    return authorization;
  }

  ApiRequest() {
    apiRequestMain = ApiRequestMain();
    //Get authToken
    token(isFirstTime: true);
    // _userInfoFetcher = PublishSubject<UserInfoBean>();
    projectUtil.printP("Hello");
  }

  @override
  Future dispose() {
    // TODO: implement dispose
    throw UnimplementedError();
  }

  @override
  Future checkAppVersion({Key key,int deviceType}) async {
    try
    {
      try
      {
        authorization = await token();
        //authorization = "70a6ba8d-5c6e-4d23-b9df-24d61613c744";
      }
      catch (e) {
        print(e);
      }
      var requestBody;
      if(deviceType==1){
        requestBody = {
          "deviceType" : "IOS",
        };
      }else{
        requestBody = {
          "deviceType" : "ANDROID",
        };
      }

      String url = checkAppVersionC;
      AppVersionBean mAppVersionBean;
      var result = await  ApiRequestMain().apiRequestGetAuthorize(url:url,bodyData: requestBody, isLoader:false, authorization: authorization);
      if (result.status && result.responseData != null) {
        projectUtil.printP("data"+result.responseData);
        try {
          mAppVersionBean = AppVersionBean.fromJson(json.decode(result.responseData));
          if (mAppVersionBean !=null) {
            return mAppVersionBean;
          }
        } catch (e) {
          print(e);
        }
      }
      else{
        return result;
      }

    }
    catch (e) {
      print(e);
      return null;
    }
  }


  @override
  Future loinUser({Key key,context, userDetails}) async {
    try
    {
      if(userDetails!=null){
        await token(isFirstTime: false);
        //encode Map to JSON
        var requestBody = json.encode(userDetails);
        var response = await apiRequestMain
            .apiRequestPost(
            url: userLoginApiC, bodyData: requestBody, isLoader: false);
        if (response.status && response.responseData != null) {
          try {
           /* UserLoggedInProfileBean mUserLoggedInProfileBean;
            projectUtil.printP(response.responseData);
            mUserLoggedInProfileBean = UserLoggedInProfileBean.fromJson(
                          json.decode(response.responseData));*/
            return null;
          } catch (e) {
            print(e);
            errorPopUp(context: context);
            return null;
          }
        }
        errorPopUp(context: context,response: response);
        return null;
      }
      else{
        errorPopUp(context: context);
        return null;
      }
    }
    catch (e)
    {
      print(e);
      errorPopUp(context: context);
      return null;
    }
  }

  @override
  Future logOut({Key key,context}) async {
    try
    {
      var deviceid =
      await sharedPreferencesFile.readStr(deviceIdC);
      var authorization = await sharedPreferencesFile
          .readStr(accessToken);
      Map data = {"device_id": deviceid};
      //encode Map to JSON
      var requestBody = json.encode(data);
        var response = await apiRequestMain
            .apiRequestPostAuthorize(logoutApiC, requestBody, false, authorization);
        if (response.status) {
            return response;
        }
        errorPopUp(context: context,response: response);
        return null;

    }
    catch (e)
    {
      print(e);
      errorPopUp(context: context);
      return null;
    }
  }

@override
 Future getAboutUsGet({Key key,context}) async {
  try
  {
    var response = await apiRequestMain
          .apiRequestGet(url:aboutUsApiC,bodyData:null, isLoader:false);
      if (response.status && response.responseData!=null) {
        try {

          return null;
        } catch (e) {
          print(e);
          errorPopUp(context: context);
          return null;
        }
      }
      errorPopUp(context: context,response: response);
      return null;
  }
  catch (e)
  {
    print(e);
    errorPopUp(context: context);
    return null;
  }
 }


  //Common Error popup
  Future<void> errorPopUp({context,response,message}){
    if(context!=null && response!=null){
      ErrorAlert(
          context:context,
          isItForInternet:true,
          alertTitle: appString.appName,
          message:response.message, callBackYes:(context) async {
        Navigator.pop(context);
        if (response.statusCode == 401) {
          await sharedPreferencesFile.clearAll();
        }
      });
    }
    else if(context!=null && message!=null){
      ErrorAlert(
          context:context,
          isItForInternet:true,
          alertTitle: appString.appName,
          message:message, callBackYes:(context) async {
        Navigator.pop(context);
        if (response.statusCode == 401) {
          await sharedPreferencesFile.clearAll();
        }
      });
    }
    else if(context!=null){
      String message ="No Data Found";
      ErrorAlert(
          context:context,
          isItForInternet:true,
          alertTitle:appString.appName,
          message:message, callBackYes:(context) async {
        Navigator.pop(context);
        if (response.statusCode == 401) {
          await sharedPreferencesFile.clearAll();
        }
      });
    }

    return null;
  }

  //Common Error popup
  Future<void> loaderPopUp({context}){
    if(context!=null){
      LoaderAlert(
          context:context,
          isItForInternet:true,
          alertTitle: appString.appName);
    }
    return null;
  }

}
final apiRequest = ApiRequest();