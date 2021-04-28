import 'package:flutter/material.dart';
import 'package:fullter_main_app/src/api_calling/api_constant.dart';
import 'package:fullter_main_app/src/widgets/android_ios_check_box.dart';
import 'package:fullter_main_app/src/widgets/radio.dart';

class RadioPage extends StatefulWidget {
  RadioPage({Key key}) : super(key: key);
  @override
  _RadioPageState createState() => _RadioPageState();
}

class _RadioPageState extends State<RadioPage> {
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
                RadioCustom(
                  isAndroid: ConstantC.isAndroidPlatform,
                  label: 'This is the label text ',
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  value: _isSelected1,
                  onChanged: (bool newValue) {
                    setState(() {
                      _isSelected1 = newValue;
                    });
                  },
                ),
                RadioCustom(
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
                RadioCustom(
                  radioColor: Colors.blue,
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
                RadioCustom(
                  radioColor: Colors.pink,
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
