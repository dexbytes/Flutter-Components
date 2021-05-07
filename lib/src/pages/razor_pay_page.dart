import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fullter_main_app/src/api_calling/api_constant.dart';
import 'package:fullter_main_app/src/widgets/alerts/confirmation_alert.dart';
import 'package:fullter_main_app/src/widgets/alerts/inform_alert.dart';
import 'package:fullter_main_app/src/widgets/android_ios_check_box.dart';
import 'package:fullter_main_app/src/widgets/payment_button_widget.dart';

class RazorPayPage extends StatefulWidget {
  RazorPayPage({Key key}) : super(key: key);
  @override
  _RazorPayPageState createState() => _RazorPayPageState();
}

class _RazorPayPageState extends State<RazorPayPage> {
  double amount = 1; //in rupee
  String productName = 'T - Shirt';

  showResponseDialog({title, content}) {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: new Text(title ?? ''),
              content: new Text(content ?? ''),
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(15)),
              actions: <Widget>[
                new FlatButton(
                  child: Text("OK"),
                  textColor: Color(0xFF852539),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    paymentWidgetView() {
      RazorPayRequestModel paymentRequestData = RazorPayRequestModel(
          amount: amount,
          productName: productName,
          description: 'Fine T-Shirt',
          contact: '9926343965',
          email: 'sakshi@dexbytes.com');

      return RazorPaymentButton(
        razorPayRequestData: paymentRequestData,
        razorPayResponseCallback: (responseData) {
          if (responseData != null) {
            RazorPayResponseModel response = responseData;
            print('${response.message}');
            if (response.status && response.response != null) {
              showResponseDialog(
                  title: response.message,
                  content:
                      "Your payment id is: ${response.response.paymentId}");
            } else {
              if (response.response != null) {
                showResponseDialog(
                    title: response.message,
                    content:
                        " ${response.response.code} - ${response.response.message}");
              } else {
                showResponseDialog(
                    title: response.message, content: "Something went wrong");
              }
            }
          } else {
            showResponseDialog(title: 'ERROR', content: "Something went wrong");
          }
        },
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
            /*AndroidIosCheckbox(
              onChanged: () {
                setState(() {});
              },
            ),*/
            ListView(
              shrinkWrap: true,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('Amount : ₹$amount',
                          style: TextStyle(
                              fontSize: 22.0,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF852539))),
                      SizedBox(height: 10.0),
                      Text('Product Name : $productName',
                          style: TextStyle(
                              color: Color(0xFF575E67), fontSize: 18.0)),
                    ],
                  ),
                ),
                SizedBox(height: 50.0),
                paymentWidgetView(),
              ],
            ),
          ],
        ),
      );
    }

    //Back Press
    _onBackPressed() {
      Navigator.pop(context);
    }

    return WillPopScope(
        onWillPop: _onBackPressed,
        child: Container(
            color: Colors.transparent,
            child: SafeArea(
                bottom: false,
                child: Scaffold(
                  backgroundColor: Colors.white.withOpacity(0.8),
                  appBar: AppBar(
                    backgroundColor: Color.fromRGBO(36, 41, 46, 1),
                    title: Text(
                      "Razor Pay",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  body: Container(
                    // color: Colors.white,
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      dragStartBehavior: DragStartBehavior.down,
                      child: _centerView(),
                    ),
                  ),
                ))));
  }
}
