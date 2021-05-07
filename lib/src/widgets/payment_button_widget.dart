import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
/*
Add Dependencies :
razorPay_flutter: ^1.2.2 #Razorpay payment
connectivity: 0.4.2  # Check Status of internet
*/

class RazorPaymentButton extends StatefulWidget {
  final Widget razorButtonWidget;
  final razorPayResponseCallback;
  final RazorPayRequestModel razorPayRequestData;
  final String razorPayKeyId;
  final String razorButtonName;

  const RazorPaymentButton(
      {Key key,
      this.razorButtonWidget,
      this.razorButtonName,
      @required this.razorPayResponseCallback,
      @required this.razorPayRequestData,
      this.razorPayKeyId})
      : super(key: key);

  @override
  _RazorPaymentButtonState createState() => _RazorPaymentButtonState(
      this.razorButtonWidget,
      this.razorPayResponseCallback,
      this.razorPayRequestData,
      this.razorPayKeyId);
}

class _RazorPaymentButtonState extends State<RazorPaymentButton> {
  //Razor Pay unique key id
  String razorPayKeyId = 'rzp_test_Qx0Oxjibs8Vqz2';

  Razorpay _razorPay = Razorpay();
  RazorPayRequestModel razorPayRequestData;
  RazorPayResponseModel paymentResponseData;

  //Razor Pay request/checkout data
  Map<String, dynamic> razorCheckoutData = Map();

  Widget razorButtonWidget;
  Function razorPayResponseCallback;

  _RazorPaymentButtonState(
      razorButtonWidget, response, razorPayRequestData, razorPayKeyId) {
    this.razorButtonWidget = razorButtonWidget;
    this.razorPayResponseCallback = response;
    this.razorPayRequestData = razorPayRequestData;
    if (razorPayKeyId != null && razorPayKeyId.trim() != '') {
      this.razorPayKeyId = razorPayKeyId;
    }
  }

  @override
  void initState() {
    _razorPay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorPay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorPay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    // TODO: implement initState
    super.initState();
  }

  //Handle payment success
  _handlePaymentSuccess(PaymentSuccessResponse response) {
    print("SUCCESS: ${response.paymentId}");
    //paymentResponse.showResponseDialog(title:  "Payment Successful",content: "Your payment id is: ${ response.paymentId}" );
    paymentResponseData = RazorPayResponseModel(
        message: 'Payment Successful', response: response, status: true);
    razorPayResponseCallback(paymentResponseData);
  }

  //Handle payment error
  _handlePaymentError(PaymentFailureResponse response) {
    print("ERROR: ${response.code} - ${response.message}");
    //paymentResponse.showResponseDialog(title:  "ERROR",content: " ${ response.code} - ${response.message}" );
    paymentResponseData = RazorPayResponseModel(
        message: 'ERROR', response: response, status: false);
    razorPayResponseCallback(paymentResponseData);
  }

  //Handle external wallet
  _handleExternalWallet(ExternalWalletResponse response) {
    print("EXTERNAL_WALLET: ${response.walletName}");
    // paymentResponse.showResponseDialog(title:  "EXTERNAL_WALLET",content: " ${ response.walletName}" );
    paymentResponseData = RazorPayResponseModel(
        message: 'EXTERNAL_WALLET', response: response, status: true);
    razorPayResponseCallback(paymentResponseData);
  }

  @override
  Widget build(BuildContext context) {
    //Response Dialog
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
                  new TextButton(
                    child: Text("OK"),
                    //textColor: Color(0xFF852539),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ));
    }

    //Payment checkout method
    paymentCheckout({razorCheckoutData}) async {
      try {
        var connectivityResult = await (Connectivity().checkConnectivity());
        if (connectivityResult == ConnectivityResult.mobile ||
            connectivityResult == ConnectivityResult.wifi) {
          _razorPay.open(razorCheckoutData);
        } else {
          showResponseDialog(
              title: "No Internet",
              content: "Please check your internet connection");
        }
      } catch (e) {
        print(e);
      }
    }

    // Prepare request data or checkout data
    payData() {
      if (razorPayRequestData != null &&
          razorPayKeyId != null &&
          razorPayKeyId.trim() != '' &&
          razorPayRequestData.amount != null &&
          razorPayRequestData.amount > 0 &&
          razorPayRequestData.productName != null &&
          razorPayRequestData.productName.trim() != '' &&
          razorPayRequestData.contact != null &&
          razorPayRequestData.contact.trim() != '' &&
          razorPayRequestData.email != null &&
          razorPayRequestData.email.trim() != '') {
        razorCheckoutData['key'] = razorPayKeyId;
        razorCheckoutData['amount'] = (razorPayRequestData.amount != null &&
                razorPayRequestData.amount > 0)
            ? razorPayRequestData.amount * 100
            : 100;
        razorCheckoutData['name'] = razorPayRequestData.productName ?? '';
        razorCheckoutData['description'] =
            razorPayRequestData.description ?? '';

        if (razorPayRequestData.contact != null &&
            razorPayRequestData.contact != '' &&
            razorPayRequestData.email != null &&
            razorPayRequestData.email != '') {
          razorCheckoutData['prefill'] = {
            'contact': razorPayRequestData.contact,
            'email': razorPayRequestData.email, //'test@razorpay.com'
          };
        }

        if (razorPayRequestData.wallet != null &&
            razorPayRequestData.wallet.length > 0) {
          razorCheckoutData['external'] = {
            'wallets': razorPayRequestData.wallet //'test@razorpay.com'
          };
        }
        paymentCheckout(razorCheckoutData: razorCheckoutData);
      } else {
        showResponseDialog(
            title: "Incomplete Data",
            content: 'Please add all the require data');
      }
    }

    return InkWell(
        onTap: () {
          payData();
        },
        child: razorButtonWidget ??
            Padding(
              padding: const EdgeInsets.only(left: 18.0, right: 18),
              child: Container(
                  width: MediaQuery.of(context).size.width - 50.0,
                  height: 50.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25.0),
                      color: Color(0xFF852539)),
                  child: Center(
                      child: Text(widget.razorButtonName ?? 'Pay With Razor',
                          style: TextStyle(
                              fontFamily: 'nunito',
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)))),
            ));
  }
}

class RazorPayRequestModel {
  final String productName, description, contact, email;
  final double amount;
  final List wallet;

  const RazorPayRequestModel({
    @required this.productName,
    this.description,
    @required this.contact,
    @required this.email,
    @required this.amount,
    this.wallet,
  })  : assert(productName != null && productName != ''),
        assert(contact != null && contact != ''),
        assert(email != null && email != ''),
        assert(email != null && email != ''),
        assert(amount != null && amount > 0);
}

class RazorPayResponseModel {
  bool status;
  var response;
  String message;

  RazorPayResponseModel({this.response, this.message, this.status});
}
