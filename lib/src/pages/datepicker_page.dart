import 'dart:io';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fullter_main_app/src/api_calling/api_constant.dart';
import 'package:fullter_main_app/src/widgets/android_ios_check_box.dart';
import 'package:fullter_main_app/src/widgets/date_time_picker/date_picker_sheet.dart';

class DatePickerPage extends StatefulWidget {
  DatePickerPage({Key key}) : super(key: key);
  @override
  _DatePickerPageState createState() => _DatePickerPageState();
}

class _DatePickerPageState extends State<DatePickerPage> {
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //List child head
    Widget listItemHead({String item, int index}) {
      Widget tempRowView = Container(
        color: Colors.blueGrey.withOpacity(0.2),
        height: 45,
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        child: Align(alignment: Alignment.centerLeft, child: Text("$item")),
      );
      return tempRowView;
    }

    Widget datePicker = ElevatedButton(
      child: Text('Date Picker'),
      onPressed: () {
        DatePickerBottomSheet(
          isAndroid: ConstantC.isAndroidPlatform,
          context: context,
          doneCallBack: (selectedDateTime) {
            print("$selectedDateTime");
          },
        );
      },
    );

    Widget timePicker = ElevatedButton(
      child: Text('Time Picker'),
      onPressed: () {
        DatePickerBottomSheet(
          isAndroid: ConstantC.isAndroidPlatform,
          mode: PickerType.time,
          context: context,
          doneCallBack: (selectedDateTime) {
            print("$selectedDateTime");
          },
        );
      },
    );
    //Center View
    Widget _centerView() {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Center(
              child: AndroidIosCheckbox(
                onChanged: () {
                  setState(() {});
                },
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 10,
                ),
                datePicker,
                SizedBox(
                  height: 10,
                ),
                timePicker,
              ],
            )
          ],
        ),
      );
    }

    //Back Press
    _onBackPressed() {
      print("ok");
      Navigator.pop(context);
      print("ok");
    }

    return WillPopScope(
        onWillPop: _onBackPressed,
        child: Container(
            color: Colors.transparent,
            child: SafeArea(
                bottom: false,
                child: Scaffold(
                  backgroundColor: Colors.white,
                  //appBar:_appBar(),
                  body: Container(
                    color: Colors.white,
                    child: _centerView(),
                  ),
                ))));
  }
}
