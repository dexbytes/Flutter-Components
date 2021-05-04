import 'dart:io';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fullter_main_app/src/api_calling/api_constant.dart';
import 'package:fullter_main_app/src/widgets/android_ios_check_box.dart';
import 'package:fullter_main_app/src/widgets/badge.dart';
import 'package:fullter_main_app/src/widgets/common_text_field.dart';
import 'package:fullter_main_app/src/widgets/icon_right_with_text.dart';
import 'package:fullter_main_app/src/widgets/input_field.dart';
import 'package:fullter_main_app/src/widgets/labeled_check_box.dart';
import 'package:fullter_main_app/src/widgets/listViewCustom.dart';

class InputFiledPage extends StatefulWidget {
  InputFiledPage({Key key}) : super(key: key);
  @override
  _InputFiledPageState createState() => _InputFiledPageState();
}

class _InputFiledPageState extends State<InputFiledPage> {
  TextEditingController nameController = new TextEditingController();
  String errorMessages;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //Password floating input field
    Widget _buildPassword() {
      return InputFieldWidget(
        keyboardType: KeyboardTypeInputFieldWidget.password,
        isFloatingLabel: true,
        labelText: "Floating Label",
      );
    }

    Widget _buildEmail() {
      return InputFieldWidget(
        keyboardType: KeyboardTypeInputFieldWidget.email,
        isFloatingLabel: false,
        labelText: "Fixed Label",
      );
    }

    Widget _stackedLabelFiled() {
      return InputFieldWidget(
        keyboardType: KeyboardTypeInputFieldWidget.email,
        isFloatingLabel: false,
        stackedLabelColor: true,
        labelText: "Stacked Label",
      );
    }

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
            //_buildNameField(),
            _buildPassword(),
            _buildEmail(),
            _stackedLabelFiled(),
            SizedBox(
              height: 10,
            ),
            CommonTextField(
              //focusNode: focusNodes['email'],
              showError: true,
              errorText: errorMessages,
              controllerT: nameController,
              borderRadius: 8,
              capitalization: 2,
              inputHeight:
                  (errorMessages != null && errorMessages != "") ? 65 : 50,
              inputKeyboardType: InputKeyboardType.email,
              hintText: "Name",
              placeHolderTextWidget: Text("Name"),
              onTextChange: (value) {},
              onEndEditing: (value) {},
            ),
            /*ListView(
              children: [

              ],
            )*/
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
                  appBar: AppBar(
                    backgroundColor: Color.fromRGBO(36, 41, 46, 1),
                    title: Text(
                      "Input Field",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  body: Container(
                    color: Colors.white,
                    child: _centerView(),
                  ),
                ))));
  }
}
