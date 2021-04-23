import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fullter_main_app/src/api_calling/api_constant.dart';
import 'package:fullter_main_app/src/widgets/alerts/confirmation_alert.dart';
import 'package:fullter_main_app/src/widgets/alerts/inform_alert.dart';
import 'package:fullter_main_app/src/widgets/android_ios_check_box.dart';

class AlertPage extends StatefulWidget {
  AlertPage({Key key}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<AlertPage> {
  @override
  Widget build(BuildContext context) {
    //Center View
    Widget _centerView() {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            AndroidIosCheckbox(
              onChanged: () {
                setState(() {});
              },
            ),
            ListView(
              shrinkWrap: true,
              children: [
                ElevatedButton(
                  child: const Text('Confirm Alert'),
                  onPressed: () {
                    ConfirmationAlert(
                        isAndroid: ConstantC.isAndroidPlatform,
                        context: context,
                        // message: "",
                        noCallback: (alertContext) {
                          // Navigator.pop(alertContext);
                        },
                        callBackYes: (alertContext) {
                          // Navigator.pop(alertContext);
                        });
                  },
                ),
                ElevatedButton(
                  child: const Text('Info Alert'),
                  onPressed: () {
                    InfoAlert(
                        isAndroid: ConstantC.isAndroidPlatform,
                        context: context,
                        // message: "",
                        callBackConfirm: (alertContext) {
                          // Navigator.pop(alertContext);
                        });
                  },
                )
              ],
            ),
          ],
        ),
      );
    }

    //Back Press
    _onBackPressed() {
      Navigator.pop(context);
    }

    return WillPopScope(
        onWillPop: _onBackPressed,
        child: Container(
            color: Colors.transparent,
            child: SafeArea(
                bottom: false,
                child: Scaffold(
                  backgroundColor: Colors.white.withOpacity(0.8),
                  //appBar:_appBar(),
                  body: Container(
                    // color: Colors.white,
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      dragStartBehavior: DragStartBehavior.down,
                      child: _centerView(),
                    ),
                  ),
                ))));
  }
}
