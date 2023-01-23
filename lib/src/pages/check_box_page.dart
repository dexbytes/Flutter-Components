import 'package:flutter/material.dart';
import 'package:fullter_main_app/src/api_calling/api_constant.dart';
import 'package:fullter_main_app/src/widgets/android_ios_check_box.dart';
import 'package:fullter_main_app/src/widgets/labeled_check_box.dart';

class CheckBoxPage extends StatefulWidget {
  CheckBoxPage({Key key}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<CheckBoxPage> {
  bool _isSelected = false;
  bool _isSelected1 = false;
  bool _isSelected2 = true;
  bool _isSelected3 = false;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //Render check box.
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
                // Create label check box.
                LabeledCheckbox(
                  isAndroid: ConstantC.isAndroidPlatform,
                  label: 'This is the label text ',
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  // Set the selected value of checkbox
                  value: _isSelected1,
                  // Catch the change value of check box, while tap.
                  onChanged: (bool newValue) {
                    // Set the change value of checkbox.
                    setState(() {
                      _isSelected1 = newValue;
                    });
                  },
                ),
                LabeledCheckbox(
                  isAndroid: ConstantC.isAndroidPlatform,
                  label: 'This is the label text ',
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  value: _isSelected,
                  disabled: true,
                  onChanged: (bool newValue) {
                    setState(() {
                      _isSelected = newValue;
                    });
                  },
                ),
                LabeledCheckbox(
                  checkFillColor: Colors.blue,
                  isAndroid: ConstantC.isAndroidPlatform,
                  label: 'This is the label text ',
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  value: _isSelected2,
                  disabled: false,
                  onChanged: (bool newValue) {
                    setState(() {
                      _isSelected2 = newValue;
                    });
                  },
                ),
                LabeledCheckbox(
                  checkFillColor: Colors.pink,
                  isAndroid: ConstantC.isAndroidPlatform,
                  label: 'This is the label text ',
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  value: _isSelected3,
                  disabled: false,
                  onChanged: (bool newValue) {
                    setState(() {
                      _isSelected3 = newValue;
                    });
                  },
                ),
              ],
            )
          ],
        ),
      );
    }

    // Handle the back button press action of the mobile.
    _onBackPressed() {
      print("ok");
      Navigator.pop(context);
      print("ok");
    }

    // Handle the back button press action of the mobile.
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
          ),
        ),
      ),
    );
  }
}
