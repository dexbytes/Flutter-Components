import 'package:flutter/material.dart';
import 'package:fullter_main_app/src/api_calling/api_constant.dart';
import 'package:fullter_main_app/src/widgets/avatar_image.dart';
import 'package:fullter_main_app/src/widgets/button_solid.dart';
import 'package:fullter_main_app/src/widgets/card_view.dart';
import 'package:fullter_main_app/src/widgets/input_field.dart';

import 'flip_card.dart';

class UserProfile1 extends StatefulWidget {
  UserProfile1({Key key}) : super(key: key);
  @override
  _UserProfile1State createState() => _UserProfile1State();
}

class _UserProfile1State extends State<UserProfile1> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  FocusNode focusNode;
  GlobalKey<FlipCardState> flipCardKey = GlobalKey<FlipCardState>();
  bool readOnly = false;
  bool enabledEdit = false;
  String userId = "1X2Y345CZ";
  String mobileNumber = "9999988888";

  @override
  void initState() {
    super.initState();

    focusNode = FocusNode();
    focusNode.addListener(() {
      print('Listener');
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //Profile view
    Widget profileView() {
      double profileViewHeight = MediaQuery.of(context).size.height / 3.5;
      return Container(
        height: profileViewHeight,
        //color: Colors.blueAccent.withOpacity(0.6),
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(
                'https://www.mceldrewyoung.com/wp-content/uploads/2020/09/coyle.png'),
            colorFilter: new ColorFilter.mode(
                Colors.blueAccent.withOpacity(0.8), BlendMode.darken),
          ),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8.0), topRight: Radius.circular(8.0)),
          color: Colors.blueAccent.withOpacity(0.8),
        ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.all(0),
                child: AvatarImage(
                  height: 100,
                  width: 100,
                  image:
                      "https://www.mceldrewyoung.com/wp-content/uploads/2020/09/coyle.png",
                  name: "NA",
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 15.0, bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      userId,
                      style: TextStyle(
                          color: Colors.white70,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      mobileNumber,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
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
                  flipCardKey.currentState.toggleCard();
                },
                isAndroid: ConstantC.isAndroidPlatform,
                buttonExpandedType: ButtonExpandedType.DEFAULT_WIDTH,
                buttonSize: ButtonSize.SMALL_SIZE,
                title: " ${enabledEdit ? 'Save' : 'Edit'} ",
                textStyle: TextStyle(
                    color: Colors.white,
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
        focusNode: focusNode,
        focusedBorderColor: Colors.blueAccent.withOpacity(0.8),
        prefixIconConstraintSize: 40,
        enabledEdit: enabledEdit,
        prefixIcon: Container(
          margin: EdgeInsets.only(right: 5),
          child: Icon(
            Icons.person,
            size: 30,
            color: Colors.blueAccent.withOpacity(0.9),
          ),
        ),
        keyboardType: KeyboardTypeInputFieldWidget.email,
        isFloatingLabel: true,
        labelText: "Full Name",
        initialValue: "John rockefeller",
      );
    }

    //Email filed
    Widget _buildEmail() {
      return InputFieldWidget(
        focusedBorderColor: Colors.blueAccent.withOpacity(0.8),
        prefixIconConstraintSize: 40,
        enabledEdit: enabledEdit,
        prefixIcon: Container(
          padding: EdgeInsets.only(right: 7),
          child: Icon(
            Icons.email,
            size: 26,
            color: Colors.blueAccent.withOpacity(0.9),
          ),
        ),
        keyboardType: KeyboardTypeInputFieldWidget.email,
        isFloatingLabel: true,
        labelText: "Email",
        initialValue: "2xyz@gmail.com",
      );
    }

    //Office Address filed
    Widget _buildOfficeAddress() {
      return InputFieldWidget(
        inPutMaxLine: 1,
        focusedBorderColor: Colors.blueAccent.withOpacity(0.9).withOpacity(0.8),
        prefixIconConstraintSize: 40,
        enabledEdit: enabledEdit,
        prefixIcon: Container(
          margin: EdgeInsets.only(right: 5),
          child: Icon(
            Icons.location_city,
            size: 30,
            color: Colors.blueAccent.withOpacity(0.9),
          ),
        ),
        keyboardType: KeyboardTypeInputFieldWidget.email,
        isFloatingLabel: true,
        labelText: "Office Full Address",
        initialValue: "80/100 Washington East, ",
      );
    }

    //Home Address filed
    Widget _buildHomeAddress() {
      return InputFieldWidget(
        inPutMaxLine: 2,
        focusedBorderColor: Colors.blueAccent.withOpacity(0.8),
        prefixIconConstraintSize: 40,
        enabledEdit: enabledEdit,
        prefixIcon: Container(
          margin: EdgeInsets.only(right: 5),
          child: Icon(
            Icons.house_sharp,
            size: 30,
            color: Colors.blueAccent.withOpacity(0.9),
          ),
        ),
        keyboardType: KeyboardTypeInputFieldWidget.email,
        isFloatingLabel: true,
        labelText: "Home Full Address",
        initialValue:
            "25/100 Washington West, New York, ABCD 10012, United States",
      );
    }

    //Center View
    Widget _centerView() {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 0),
        child: CardView(
          isAndroid: ConstantC.isAndroidPlatform,
          cardType: CardType.FULL_WIDTH,
          padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
          child: Column(
            children: [
              profileView(),
              SizedBox(
                height: 10,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
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
          ),
        ),
      );
    }

    //Common text view for show Data
    Widget commonTextView({String detail}) {
      return Container();
    }

    Widget _centerView2() {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 0),
        child: CardView(
          isAndroid: ConstantC.isAndroidPlatform,
          cardType: CardType.FULL_WIDTH,
          padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
          child: Column(
            children: [
              profileView(),
              SizedBox(
                height: 10,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: Form(
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
          ),
        ),
      );
    }

    Widget _buildFlipAnimation1() {
      return FlipCard(
        key: flipCardKey,
        flipOnTouch: false,
        speed: 800,
        onFlip: () {},
        onFlipDone: (value) {
          if (enabledEdit) {
            focusNode.requestFocus();
          }
        },
        direction: FlipDirection.HORIZONTAL, // default
        front: _centerView(),
        back: _centerView2(),
      );
    }

    return _buildFlipAnimation1();
  }
}
