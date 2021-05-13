import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fullter_main_app/src/api_calling/api_constant.dart';
import 'package:fullter_main_app/src/widgets/button_solid.dart';
import 'package:fullter_main_app/src/widgets/card_view.dart';
import 'package:fullter_main_app/src/widgets/common_text_field.dart';
import 'package:fullter_main_app/src/widgets/input_field.dart';
import 'package:fullter_main_app/src/widgets/pop_over/popup_widget_menu.dart';

class CardSignUpPage5 extends StatefulWidget {
  CardSignUpPage5({Key key}) : super(key: key);
  @override
  _CardSignUpPage5State createState() => _CardSignUpPage5State();
}

class _CardSignUpPage5State extends State<CardSignUpPage5> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController confirmPasswordController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  String errorMessagesPassword,
      errorMessagesConfirmPassword,
      errorMessagesEmail;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //Password floating input field
    Widget _buildPassword() {
      return CommonTextField(
        //focusNode: focusNodes['email'],
        showError: true,
        errorText: errorMessagesPassword,
        controllerT: passwordController,
        borderRadius: 8,
        capitalization: 2,
        inputHeight:
            (errorMessagesPassword != null && errorMessagesPassword != "")
                ? 65
                : 50,
        inputKeyboardType: InputKeyboardType.password,
        hintText: "Password",
        // placeHolderTextWidget: Text("Password"),
        onTextChange: (value) {},
        onEndEditing: (value) {},
      );
    }

    Widget _buildPasswordConfirm() {
      return CommonTextField(
        //focusNode: focusNodes['email'],
        showError: true,
        errorText: errorMessagesConfirmPassword,
        controllerT: confirmPasswordController,
        borderRadius: 8,
        capitalization: 2,
        inputHeight: (errorMessagesConfirmPassword != null &&
                errorMessagesConfirmPassword != "")
            ? 65
            : 50,
        inputKeyboardType: InputKeyboardType.password,
        hintText: "Confirm password",
        // placeHolderTextWidget: Text("Confirm password"),
        onTextChange: (value) {},
        onEndEditing: (value) {},
      );
    }

    Widget _buildEmail() {
      return CommonTextField(
        //focusNode: focusNodes['email'],
        showError: true,
        errorText: errorMessagesEmail,
        controllerT: emailController,
        borderRadius: 8,
        capitalization: 2,
        inputHeight:
            (errorMessagesEmail != null && errorMessagesEmail != "") ? 65 : 50,
        inputKeyboardType: InputKeyboardType.email,
        hintText: "Email Address",
        // placeHolderTextWidget: Text("Email Address"),
        onTextChange: (value) {},
        onEndEditing: (value) {},
      );
    }

    //Center View
    Widget _centerView() {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 100),
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
                    SizedBox(
                      height: 20,
                    ),
                    _buildPassword(),
                    SizedBox(
                      height: 20,
                    ),
                    _buildPasswordConfirm(),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              ButtonSolid(
                btnShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                onPressed: () {
                  if (!_formKey.currentState.validate()) {
                    return;
                  }
                  _formKey.currentState.save();
                },
                isAndroid: ConstantC.isAndroidPlatform,
                buttonExpandedType: ButtonExpandedType.BLOCK_WIDTH,
                buttonSize: ButtonSize.LARGE_SIZE,
                height: 50,
                title: " Sign Up ",
              )
            ],
          ),
        ),
      );
    }

    return _centerView();
  }
}
