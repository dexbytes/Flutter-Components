import 'package:flutter/material.dart';
import 'package:fullter_main_app/src/api_calling/api_constant.dart';
import 'package:fullter_main_app/src/widgets/button_solid.dart';
import 'package:fullter_main_app/src/widgets/input_field.dart';

class NormalSignUpPage extends StatefulWidget {
  NormalSignUpPage({Key key}) : super(key: key);
  @override
  _NormalSignUpPageState createState() => _NormalSignUpPageState();
}

class _NormalSignUpPageState extends State<NormalSignUpPage> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isHidPassword = true;
  bool isHidPasswordConform = true;

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
        isHidPassword: isHidPasswordConform,
        prefixIcon: Container(
          padding: EdgeInsets.only(right: 5),
          child: Icon(
            Icons.lock,
            size: 24,
            color: Colors.blue,
          ),
        ),
        suffixIcon: GestureDetector(
          onTap: () {
            setState(() {
              isHidPasswordConform = !isHidPasswordConform;
            });
          },
          child: Icon(
            !isHidPasswordConform ? Icons.visibility : Icons.visibility_off,
            size: 22,
            color: Colors.grey,
          ),
        ),
        keyboardType: KeyboardTypeInputFieldWidget.password,
        isFloatingLabel: true,
        labelText: "Password",
      );
    }

    Widget _buildPasswordConfirm() {
      return InputFieldWidget(
        isHidPassword: isHidPassword,
        prefixIcon: Container(
          padding: EdgeInsets.only(right: 5),
          child: Icon(
            Icons.lock,
            size: 24,
            color: Colors.blue,
          ),
        ),
        suffixIcon: GestureDetector(
          onTap: () {
            setState(() {
              isHidPassword = !isHidPassword;
            });
          },
          child: Icon(
            !isHidPassword ? Icons.visibility : Icons.visibility_off,
            size: 22,
            color: Colors.grey,
          ),
        ),
        keyboardType: KeyboardTypeInputFieldWidget.password,
        isFloatingLabel: true,
        labelText: "Confirm Password",
      );
    }

    Widget _buildEmail() {
      return InputFieldWidget(
        prefixIcon: Container(
          padding: EdgeInsets.only(right: 5),
          child: Icon(
            Icons.email,
            size: 21,
            color: Colors.blue,
          ),
        ),
        keyboardType: KeyboardTypeInputFieldWidget.email,
        isFloatingLabel: true,
        labelText: "Email Address",
      );
    }

    //Center View
    Widget _centerView() {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Text(
              "Sign Up",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 10,
            ),
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  _buildEmail(),
                  _buildPassword(),
                  _buildPasswordConfirm(),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            ButtonSolid(
              btnShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)),
              onPressed: () {
                if (!_formKey.currentState.validate()) {
                  return;
                }
                _formKey.currentState.save();
              },
              isAndroid: ConstantC.isAndroidPlatform,
              buttonExpandedType: ButtonExpandedType.BLOCK_WIDTH,
              buttonSize: ButtonSize.LARGE_SIZE,
              title: " Sign Up ",
              height: 50,
            )
          ],
        ),
      );
    }

    return _centerView();
  }
}
