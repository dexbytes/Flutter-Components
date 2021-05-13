import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fullter_main_app/src/api_calling/api_constant.dart';
import 'package:fullter_main_app/src/widgets/button_solid.dart';
import 'package:fullter_main_app/src/widgets/card_view.dart';
import 'package:fullter_main_app/src/widgets/input_field.dart';
import 'package:fullter_main_app/src/widgets/pop_over/popup_widget_menu.dart';
import 'package:fullter_main_app/src/widgets/unicorndial.dart';

class CardSignUpWithSocialPage extends StatefulWidget {
  CardSignUpWithSocialPage({Key key}) : super(key: key);
  @override
  _CardSignUpWithSocialPageState createState() =>
      _CardSignUpWithSocialPageState();
}

class _CardSignUpWithSocialPageState extends State<CardSignUpWithSocialPage> {
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

    Widget socialMedia() {
      return Column(
        children: [
          Text(
            "Or using social accounts",
            style:
                TextStyle(fontWeight: FontWeight.w600, color: Colors.blueGrey),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              UnicornDialer(
                  backgroundColor: Colors.transparent,
                  parentButtonBackground: Colors.redAccent,
                  orientation: UnicornOrientation.HORIZONTAL,
                  parentButton: Icon(Icons.face),
                  childButtons: []),
              SizedBox(
                width: 10,
              ),
              UnicornDialer(
                  backgroundColor: Colors.transparent,
                  parentButtonBackground: Colors.redAccent,
                  orientation: UnicornOrientation.HORIZONTAL,
                  parentButton: Icon(Icons.face),
                  childButtons: []),
            ],
          ),
          SizedBox(
            height: 10,
          )
        ],
      );
    }

    //Center View
    Widget _centerView() {
      MediaQueryData _mediaQueryData = MediaQuery.of(context);
      double heightContainer = _mediaQueryData.size.height -
          (_mediaQueryData.padding.top +
              _mediaQueryData.padding.bottom +
              kBottomNavigationBarHeight +
              20);
      return Container(
        height: heightContainer,
        margin: EdgeInsets.symmetric(horizontal: 10),
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Stack(
          children: [
            Column(
              children: [
                CardView(
                  isAndroid: ConstantC.isAndroidPlatform,
                  cardType: CardType.FULL_WIDTH,
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        "Sign Up",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.blue),
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
                        height: 45,
                        title: " Sign Up ",
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      socialMedia()
                    ],
                  ),
                ),
              ],
            ),
            Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: Text(
                    "Already have an account ? SignIn",
                    style: TextStyle(
                        fontWeight: FontWeight.w600, color: Colors.blueGrey),
                  ),
                )),
          ],
        ),
      );
    }

    return _centerView();
  }
}
