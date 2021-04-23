import 'package:flutter/material.dart';
import 'package:fullter_main_app/src/all_file_import/app_values_files_link.dart';
class ExitConformationAlert{
  ExitConformationAlert({Key key,@required BuildContext context,@required extraMsg,@required msg,@required noCallback,@required callback}){
    alertPopUp(context,extraMsg,msg,noCallback,callback);
  }
   alertPopUp(BuildContext context,extraMsg,msg,noCallback,callback){
    String yesText ="Yes";
    String noText ="No";
    return
      showDialog(
          context: context,
          barrierDismissible: true,
          builder: (context1) {
//            mContext = context1;
            return AlertDialog(

              shape: RoundedRectangleBorder(
                  borderRadius:
                  BorderRadius.circular(30.0)), //this r
              content:GestureDetector(
                onTap:() => noCallback(context1),
                child:  Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: new BoxDecoration(
                    borderRadius: new BorderRadius.all(new Radius.circular(20.0)),
                  ),
                  child:ListView(
                    shrinkWrap: true,
                    children: [
                      Padding(
                          padding: EdgeInsets.only(top: AppDimens().verticalMarginPadding(value: 20),
                              bottom: AppDimens().verticalMarginPadding(value: 0)),
                          child:Align(
                              alignment: Alignment.center,
                              child: Text(
                                msg??"",
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontFamily:
                                    AppFonts().defaultFont,
                                    color: AppColors().textSubHeadingColor[100],
                                    fontSize: AppDimens().fontSize(value: 15),
                                    fontWeight: FontWeight.w600),
                              )
                          )),

                      (extraMsg!=null && extraMsg!="")?Padding(
                          padding: EdgeInsets.only(top: AppDimens().verticalMarginPadding(value: 5),
                              bottom: AppDimens().verticalMarginPadding(value: 0)),
                          child:Align(
                              alignment: Alignment.center,
                              child: Text(
                                extraMsg??"",
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontFamily:
                                    AppFonts().defaultFont,
                                    color: AppColors().textSubHeadingColor[400],
                                    fontSize: AppDimens().fontSize(value: 15),
                                    fontWeight: FontWeight.w500),
                              )
                          )):Container(),
                      Padding(
                          padding: EdgeInsets.only(top: AppDimens().verticalMarginPadding(value: 25),
                              left: AppDimens().horizontalMarginPadding(value: 15),
                              right: AppDimens().horizontalMarginPadding(value: 15),
                              bottom: AppDimens().verticalMarginPadding(value: 20)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              GestureDetector(
                                onTap: ()=>noCallback(context1),
                                child:  Container(
                                  margin: EdgeInsets.only(
                                    right: AppDimens().horizontalMarginPadding(value: 10),),
                                  width: AppDimens().widthDynamic(value: 90),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all( Radius.circular(20),),
                                      color:AppColors().buttonBgColor[100]
                                  ),
                                  alignment: Alignment.center,
                                  child: Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Text(
                                        (noText!=null && noText!='')?noText:AppString().noText,style: TextStyle(
                                        fontFamily: AppFonts().defaultFont,
                                        fontWeight: FontWeight.w500,
                                        fontSize: AppDimens().fontSize(value: 15),
                                        color: AppColors().textNormalColor[1800])),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: ()=>callback(context1),
                                child:  Container(
                                  margin: EdgeInsets.only(
                                    left: AppDimens().horizontalMarginPadding(value: 10),),
                                  width: AppDimens().widthDynamic(value: 90),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all( Radius.circular(20),),
                                      color:AppColors().buttonBgColor[100]
                                  ),
                                  alignment: Alignment.center,
                                  child: Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Text(
                                        (yesText!=null && yesText!='')?yesText:AppString().yesText,
                                        style: TextStyle(
                                            fontFamily: AppFonts().defaultFont,
                                            fontWeight: FontWeight.w500,
                                            fontSize: AppDimens().fontSize(value: 15),
                                            color: AppColors().textNormalColor[1700])),
                                  ),
                                ),
                              ),
                            ],
                          ))
                    ],
                  ),

                ),
              ),
              contentPadding: EdgeInsets.all(0.0),
            );
            // }
          });
  }
}
