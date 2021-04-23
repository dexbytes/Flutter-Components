import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fullter_main_app/src/widgets/date_time_picker/date_picker_custom.dart';

//Selected date call back
typedef DoneCallback = Function(DateTime selectedDateTime);

/// Different display modes of [CupertinoDatePicker].
///
/// See also:
///
///  * [CupertinoDatePicker], the class that implements different display modes
///    of the iOS-style date picker.
///  * [CupertinoPicker], the class that implements a content agnostic spinner UI.
enum PickerType {
  /// Mode that shows the date in hour, minute, and (optional) an AM/PM designation.
  /// The AM/PM designation is shown only if [CupertinoDatePicker] does not use 24h format.
  /// Column order is subject to internationalization.
  ///
  /// Example: ` 4 | 14 | PM `.
  time,

  /// Mode that shows the date in month, day of month, and year.
  /// Name of month is spelled in full.
  /// Column order is subject to internationalization.
  ///
  /// Example: ` July | 13 | 2012 `.
  date
}

class DatePickerBottomSheet {
  DoneCallback
      doneCallBack; //Call back function it call when user click on any menu item button and return index
  VoidCallback
      cancelCallBack; //Call back function it call when user click on cancel button
  BuildContext context;
  PickerType mode;
  bool isAndroid;

  DatePickerBottomSheet({
    @required this.context,
    @required this.cancelCallBack,
    @required this.doneCallBack,
    this.isAndroid = false,
    this.mode = PickerType.date,
  }) {
    //Check device platform
    /*if (Platform.isIOS) {
      this.isAndroid = false;
    } else if (Platform.isAndroid) {
      this.isAndroid = false;
    }*/
    _bottomSheetModal();
  }

  //Title
  Widget actionView({Color itemColor}) {
    TextStyle styleRowItemTemp = buildTextStyleActionText(textColor: itemColor);
    String cancelText = "Cancel";
    String doneText = "Done";
    if (isAndroid) {
      cancelText = cancelText.toUpperCase();
      doneText = doneText.toUpperCase();
    }
    return Align(
      alignment: this.isAndroid ? Alignment.centerLeft : Alignment.center,
      child: Container(
        // margin: itemMarginAllSide,
        padding: EdgeInsets.only(bottom: 10, top: 10, right: 10, left: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: this.isAndroid
                  ? MainAxisAlignment.end
                  : MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    //doneCallBack(selectedDate);
                    Navigator.pop(context, true);
                  },
                  child: Container(
                    child: Text(
                      '$cancelText',
                      style: styleRowItemTemp,
                    ),
                  ),
                ),
                SizedBox(
                  width: 25,
                ),
                InkWell(
                    onTap: () {
                      doneCallBack(selectedDate);
                      Navigator.pop(context, true);
                    },
                    child: Container(
                      child: Text(
                        '$doneText',
                        style: styleRowItemTemp,
                      ),
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }

  DateTime dateTime = DateTime.now();
  DateTime selectedDate = DateTime.now();
  //Date time picker view
  Widget dateTimePickerView() {
    return Align(
      alignment: Alignment.center,
      child: Container(
        height: 216,
        child: DatePickerCustom(
          isAndroid: this.isAndroid,
          mode: mode == PickerType.date
              ? DatePickerCustomMode.date
              : DatePickerCustomMode.time,
          initialDateTime: dateTime,
          onDateTimeChanged: (newDateTime) {
            selectedDate = newDateTime;
          },
        ),
      ),
    );
  }

  Future<void> _bottomSheetModal() {
    return showModalBottomSheet<void>(
      isScrollControlled: false,
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          //height: 600,
          color: Colors.transparent,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.max,
            children: [
              Card(
                elevation: this.isAndroid ? 0 : 1,
                margin: this.isAndroid
                    ? EdgeInsets.all(0)
                    : EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                shape: this.isAndroid
                    ? RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(0.0)),
                      )
                    : RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(0.0)),
                      ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    actionView(),
                    isAndroid
                        ? Container(
                            height: 0,
                          )
                        : Container(
                            height: 1,
                            width: double.infinity,
                            color: Colors.grey,
                          ),
                    dateTimePickerView()
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  TextStyle buildTextStyleActionText({Color textColor}) {
    TextStyle styleText;
    if (textColor == null) {
      textColor = isAndroid ? Colors.blue : Colors.blue;
    }
    //ios
    styleText =
        /*this.styleRowItemIos != null
        ? this.styleRowItemIos
        : */
        TextStyle(color: textColor, fontSize: 18, fontWeight: FontWeight.w500);
    //Android
    if (isAndroid) {
      styleText =
          /*this.styleRowItemAndroid != null
          ? this.styleRowItemAndroid
          :*/
          TextStyle(
              color: textColor, fontSize: 18, fontWeight: FontWeight.w500);
    }
    return styleText;
  }
}
