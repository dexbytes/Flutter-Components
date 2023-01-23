import 'dart:io';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fullter_main_app/src/api_calling/api_constant.dart';
import 'package:fullter_main_app/src/widgets/DraggableFloatingActionButton.dart';
import 'package:fullter_main_app/src/widgets/android_ios_check_box.dart';
import 'package:fullter_main_app/src/widgets/action_bottom_sheet_modal.dart';
import 'package:fullter_main_app/src/widgets/unicorndial.dart';
import 'package:fullter_main_app/src/widgets/unicorndial_new.dart';

class FloatingButtonsPage extends StatefulWidget {
  FloatingButtonsPage({Key key}) : super(key: key);
  @override
  _FloatingButtonsPageState createState() => _FloatingButtonsPageState();
}

class _FloatingButtonsPageState extends State<FloatingButtonsPage> {
  @override
  Widget build(BuildContext context) {
    var childButtons = List<UnicornButton>();

    // Add button to childButtons list
    childButtons.add(
      UnicornButton(
        hasLabel: true,
        labelText: "Choo choo",
        currentButton: FloatingActionButton(
          heroTag: "train",
          backgroundColor: Colors.redAccent,
          mini: true,
          child: Icon(Icons.train),
          onPressed: () {},
        ),
      ),
    );
    childButtons.add(
      UnicornButton(
        currentButton: FloatingActionButton(
          heroTag: "airplane",
          backgroundColor: Colors.greenAccent,
          mini: true,
          child: Icon(Icons.airplanemode_active),
        ),
      ),
    );
    childButtons.add(
      UnicornButton(
        currentButton: FloatingActionButton(
          heroTag: "directions",
          backgroundColor: Colors.orange,
          mini: true,
          child: Icon(Icons.directions_walk),
        ),
      ),
    );
    childButtons.add(
      UnicornButton(
        currentButton: FloatingActionButton(
          heroTag: "directions",
          backgroundColor: Colors.blueAccent,
          mini: true,
          child: Icon(Icons.directions_car),
        ),
      ),
    );

    var childButtons1 = List<UnicornButtonNew>();

    // Add button to childButtons1 list
    childButtons1.add(
      UnicornButtonNew(
        hasLabel: true,
        labelText: "Choo choo",
        currentButton: FloatingActionButton(
          heroTag: "train",
          backgroundColor: Colors.redAccent,
          mini: true,
          child: Icon(Icons.train),
          onPressed: () {},
        ),
      ),
    );
    childButtons1.add(
      UnicornButtonNew(
        currentButton: FloatingActionButton(
          heroTag: "airplane",
          backgroundColor: Colors.greenAccent,
          mini: true,
          child: Icon(Icons.airplanemode_active),
        ),
      ),
    );
    childButtons1.add(
      UnicornButtonNew(
        currentButton: FloatingActionButton(
          heroTag: "directions",
          backgroundColor: Colors.orange,
          mini: true,
          child: Icon(Icons.directions_walk),
        ),
      ),
    );
    childButtons1.add(
      UnicornButtonNew(
        currentButton: FloatingActionButton(
          heroTag: "directions",
          backgroundColor: Colors.blueAccent,
          mini: true,
          child: Icon(Icons.directions_car),
        ),
      ),
    );

    //Render floating button view.
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
            Container(
              height: 500,
              //width: 60,
              child: Stack(
                children: [
                  //R to L
                  Align(
                    alignment: Alignment.bottomRight,
                    child: UnicornDialer(
                        backgroundColor: Colors.transparent,
                        parentButtonBackground: Colors.redAccent,
                        orientation: UnicornOrientation.HORIZONTAL,
                        parentButton: Icon(Icons.chevron_left),
                        childButtons: childButtons),
                  ),
                  //B to T
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Container(
                      child: UnicornDialer(
                          backgroundColor: Colors.transparent,
                          parentButtonBackground: Colors.redAccent,
                          orientation: UnicornOrientation.VERTICAL,
                          parentButton: Icon(Icons.keyboard_arrow_up),
                          childButtons: childButtons),
                    ),
                  ),
                  //L to R
                  Align(
                    alignment: Alignment.topLeft,
                    child: UnicornDialerNew(
                      backgroundColor: Colors.transparent,
                      parentButtonBackground: Colors.blue,
                      orientation: UnicornOrientationNew.HORIZONTAL,
                      parentButton: Icon(Icons.keyboard_arrow_down),
                      childButtons: childButtons1,
                      isAlignBottomOrLeftSide: true,
                    ),
                  ),
                  //T to B
                  Align(
                    alignment: Alignment.topRight,
                    child: UnicornDialerNew(
                      backgroundColor: Colors.transparent,
                      parentButtonBackground: Colors.blue,
                      orientation: UnicornOrientationNew.VERTICAL,
                      parentButton: Icon(Icons.keyboard_arrow_down),
                      childButtons: childButtons1,
                      isAlignBottomOrLeftSide: false,
                    ),
                  ),
                  DraggableFloatingActionButton(
                    appContext: context,
                    data: 'Demo',
                    offset: new Offset(100, 100),
                    // backgroundColor: Theme.of(context).accentColor,
                    child: new Icon(
                      Icons.wb_incandescent,
                      color: Colors.yellow,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      );
    }

    // Handle the back button press action of the mobile.
    _onBackPressed() {
      Navigator.pop(context);
    }

    // Handle the back button press action of the mobile.
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Container(
        color: Colors.transparent,
        child: SafeArea(
          bottom: false,
          child: Scaffold(
            //appBar:_appBar(),
            body: Container(
              // color: Colors.white,
              child: Align(
                alignment: Alignment.topCenter,
                // Default widget
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  dragStartBehavior: DragStartBehavior.down,
                  // Floating button view
                  child: _centerView(),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
