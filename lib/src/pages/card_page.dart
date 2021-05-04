import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fullter_main_app/src/api_calling/api_constant.dart';
import 'package:fullter_main_app/src/widgets/android_ios_check_box.dart';
import 'package:fullter_main_app/src/widgets/card_view.dart';

class CardPage extends StatefulWidget {
  CardPage({Key key}) : super(key: key);
  @override
  _CardPageState createState() => _CardPageState();
}

class _CardPageState extends State<CardPage> {
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget cardView = CardView(
      isAndroid: ConstantC.isAndroidPlatform,
      cardType: CardType.DEFAULT,
      child: Column(
        //mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 300.0,
            height: 200.0,
            decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                      'https://lh3.googleusercontent.com/RfaTa3bsm8zmVJYznMHpncW4HCNPmPf3fstlmU5hNNm-8j3Mz8nJjUj_avt1Qi0')),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8.0),
                  topRight: Radius.circular(8.0)),
              color: Colors.redAccent,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            // color: Colors.green,
            child: Align(
                alignment: Alignment.centerLeft,
                child: Text('Destination'.toUpperCase(),
                    style: TextStyle(color: Colors.grey, fontSize: 14))),
          ),
          SizedBox(
            height: 0,
          ),
          Text(
            'Madison, WI',
            style: TextStyle(color: Colors.black, fontSize: 20),
            textAlign: TextAlign.start,
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            'Founded in 1828 on an isthums',
            style: TextStyle(color: Colors.grey, fontSize: 15),
            textAlign: TextAlign.start,
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
    //List child head
    Widget listItemHead({String item, int index}) {
      Widget tempRowView = Container(
        color: Colors.blueGrey.withOpacity(0.2),
        height: 45,
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        child: Align(alignment: Alignment.centerLeft, child: Text("$item")),
      );
      return tempRowView;
    }

    //Center View
    Widget _centerView() {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            AndroidIosCheckbox(
              onChanged: () {
                setState(() {});
              },
            ),
            Column(
              children: [cardView],
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
                  appBar: AppBar(
                    backgroundColor: Color.fromRGBO(36, 41, 46, 1),
                    title: Text(
                      "Card",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  body: Container(
                    color: Colors.white,
                    child: SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        dragStartBehavior: DragStartBehavior.down,
                        child: _centerView()),
                  ),
                ))));
  }
}
