import 'package:flutter/material.dart';
import 'package:fullter_main_app/src/all_file_import/app_values_files_link.dart';
class ConformationBottomsheet extends StatelessWidget {
  final headerTitle;
  final    view;
  final     sheetDismissCallback;
  final    screenWidth;
  ConformationBottomsheet({Key key,
    this.headerTitle,
    this.view,
    this.sheetDismissCallback,
    this.screenWidth}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    Widget divider() {
      return Container(
        //height: AppDimens().heightDynamic(value: 5),
        //color: AppColors().appTransColor[700],
        //color: Colors.red,
        color: AppColors().appTransColor[700],
        padding: EdgeInsets.only(
            top: AppDimens()
                .verticalMarginPadding(value: 22),
            bottom: AppDimens()
                .verticalMarginPadding(value: 13),
            left: AppDimens()
                .horizontalMarginPadding(value: 0),
            right: AppDimens()
                .verticalMarginPadding(value: 0)),
        width: AppDimens().widthDynamic(value: 120),
        child: Container(
          height: AppDimens().heightDynamic(value: 4),
          decoration: BoxDecoration(
            color: AppColors().appDividerColor[600],
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.all(Radius.circular(30)),
          ),
        ),
      );
    }

    return  Container(
      color: AppColors().appTransColor[600],
      child: Padding(
        padding: EdgeInsets.only(left: 0, right: 0, top: 0),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40.0),
                topRight: Radius.circular(40.0)),
          ),
          elevation: 0.0,
          margin: EdgeInsets.only(left: 0, right: 0, top: 0),
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              Align(
                alignment: Alignment.topCenter,
                child: GestureDetector(
                  onTap: sheetDismissCallback,
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: AppDimens()
                            .verticalMarginPadding(value: 0)),
                    child: divider(),
                  ),
                ),
              ),
              Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    margin: EdgeInsets.only(
                        top: (headerTitle != null && headerTitle != "")
                            ? AppDimens()
                            .verticalMarginPadding(value: 12)
                            : 0,
                        bottom: AppDimens()
                            .verticalMarginPadding(
                            value:
                            8), // bottom margin also added in divider
                        left: AppDimens()
                            .verticalMarginPadding(value: 25),
                        right: AppDimens()
                            .verticalMarginPadding(value: 25)),
                    child: Text(
                      headerTitle ?? "",
                      style: TextStyle(
                          fontFamily: AppFonts()
                              .mediumFont,
                          fontSize: AppDimens()
                              .fontSize(value: 20),
                          color: AppColors()
                              .textHeadingColor),
                    ),
                  )),
              view
            ],
          ),
        ),
      ),
    );
  }

}
