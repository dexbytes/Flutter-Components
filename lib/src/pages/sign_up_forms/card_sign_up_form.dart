import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fullter_main_app/src/api_calling/api_constant.dart';
import 'package:fullter_main_app/src/widgets/button_solid.dart';
import 'package:fullter_main_app/src/widgets/card_view.dart';
import 'package:fullter_main_app/src/widgets/input_field.dart';
import 'package:fullter_main_app/src/widgets/pop_over/popup_widget_menu.dart';

class CardSignUpPage extends StatefulWidget {
  CardSignUpPage({Key key}) : super(key: key);
  @override
  _CardSignUpPageState createState() => _CardSignUpPageState();
}

class _CardSignUpPageState extends State<CardSignUpPage> {
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
            size: 22,
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
            size: 22,
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
            size: 19,
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
        child: CardView(
          isAndroid: ConstantC.isAndroidPlatform,
          cardType: CardType.FULL_WIDTH,
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: Column(
            children: [
              Text(
                "Sign Up",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 5,
              ),
              Divider(),
              SizedBox(
                height: 5,
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
        ),
      );
    }

    return _centerView();
  }
}
