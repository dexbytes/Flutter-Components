import 'package:flutter/material.dart';
import 'package:fullter_main_app/src/api_calling/api_constant.dart';
import 'package:fullter_main_app/src/widgets/avatar_image.dart';
import 'package:fullter_main_app/src/widgets/button_solid.dart';
import 'package:fullter_main_app/src/widgets/input_field.dart';

class UserProfile4 extends StatefulWidget {
  UserProfile4({Key key}) : super(key: key);
  @override
  _UserProfile4State createState() => _UserProfile4State();
}

class _UserProfile4State extends State<UserProfile4> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool readOnly = false;
  bool enabledEdit = false;
  String userId = "1X2Y345CZ";
  String mobileNumber = "+91-9999988888";

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //Profile view
    Widget profileView() {
      return Container(
        color: Colors.greenAccent.withOpacity(0.6),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  AvatarImage(
                    height: 100,
                    width: 100,
                    image:
                        "https://pbs.twimg.com/profile_images/883859744498176000/pjEHfbdn_400x400.jpg",
                    name: "NA",
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    userId,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    mobileNumber,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: ButtonSolid(
                btnBgColor: Colors.transparent,
                btnShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                onPressed: () {
                  setState(() {
                    enabledEdit = !enabledEdit;
                  });
                  ;
                },
                isAndroid: ConstantC.isAndroidPlatform,
                buttonExpandedType: ButtonExpandedType.DEFAULT_WIDTH,
                buttonSize: ButtonSize.SMALL_SIZE,
                title: " ${enabledEdit ? 'Save' : 'Edit'} ",
                textStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w500),
                height: 35,
              ),
            )
          ],
        ),
      );
    }

    //Name filed
    Widget _buildName() {
      return InputFieldWidget(
        focusedBorderColor: Colors.greenAccent.withOpacity(0.8),
        prefixIconConstraintSize: 40,
        enabledEdit: enabledEdit,
        prefixIcon: Container(
          margin: EdgeInsets.only(right: 5),
          child: Icon(
            Icons.person,
            size: 30,
            color: Colors.greenAccent,
          ),
        ),
        keyboardType: KeyboardTypeInputFieldWidget.email,
        isFloatingLabel: true,
        labelText: "Full Name",
        initialValue: "John S.",
      );
    }

    //Email filed
    Widget _buildEmail() {
      return InputFieldWidget(
        focusedBorderColor: Colors.greenAccent.withOpacity(0.8),
        prefixIconConstraintSize: 40,
        enabledEdit: enabledEdit,
        prefixIcon: Container(
          padding: EdgeInsets.only(right: 7),
          child: Icon(
            Icons.email,
            size: 26,
            color: Colors.greenAccent,
          ),
        ),
        keyboardType: KeyboardTypeInputFieldWidget.email,
        isFloatingLabel: true,
        labelText: "Email",
        initialValue: "xyz@gmail.com",
      );
    }

    //Office Address filed
    Widget _buildOfficeAddress() {
      return InputFieldWidget(
        inPutMaxLine: 1,
        focusedBorderColor: Colors.greenAccent.withOpacity(0.8),
        prefixIconConstraintSize: 40,
        enabledEdit: enabledEdit,
        prefixIcon: Container(
          margin: EdgeInsets.only(right: 5),
          child: Icon(
            Icons.location_city,
            size: 30,
            color: Colors.greenAccent,
          ),
        ),
        keyboardType: KeyboardTypeInputFieldWidget.email,
        isFloatingLabel: true,
        labelText: "Office Full Address",
        initialValue: "70/100 Washington Square South ",
      );
    }

    //Home Address filed
    Widget _buildHomeAddress() {
      return InputFieldWidget(
        inPutMaxLine: 2,
        focusedBorderColor: Colors.greenAccent.withOpacity(0.8),
        prefixIconConstraintSize: 40,
        enabledEdit: enabledEdit,
        prefixIcon: Container(
          margin: EdgeInsets.only(right: 5),
          child: Icon(
            Icons.house_sharp,
            size: 30,
            color: Colors.greenAccent,
          ),
        ),
        keyboardType: KeyboardTypeInputFieldWidget.email,
        isFloatingLabel: true,
        labelText: "Home Full Address",
        initialValue:
            "70/100 Washington Square South, New York, XTDS 10018, United States",
      );
    }

    //Center View
    Widget _centerView() {
      return Column(
        children: [
          profileView(),
          SizedBox(
            height: 10,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  _buildName(),
                  SizedBox(
                    height: 10,
                  ),
                  _buildEmail(),
                  SizedBox(
                    height: 10,
                  ),
                  _buildOfficeAddress(),
                  SizedBox(
                    height: 10,
                  ),
                  _buildHomeAddress(),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
        ],
      );
    }

    return _centerView();
  }
}
