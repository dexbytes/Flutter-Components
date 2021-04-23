import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fullter_main_app/src/all_file_import/app_values_files_link.dart';
import 'package:provider/provider.dart';

class SplashPage extends StatefulWidget {
  final isLoggedIn;
  SplashPage({Key key, this.isLoggedIn}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  Timer _timer;
  int _start = 2;
  bool isLogin =  false;
  _SplashPageState(){
    timer();
  }
  @override
  void initState() {
   // WidgetsBinding.instance.addPostFrameCallback((_) {

   // });
    super.initState();
  }

  void timer() async {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
          (Timer timer) => setState(
            () {
          if (_start < 1) {
            isLogin = true;
            timer.cancel();
            Navigator.of(context).pushNamedAndRemoveUntil('/MainPage', ModalRoute.withName('/MainPage'));

          } else {
            _start = _start - 1;
          }
        },
      ),
    );
   /* Future.delayed(Duration(seconds: 1)).then((_) {
      setState(() {
        isLogin = true;
      });
      *//*var state = Provider.of<AuthState>(context, listen: false);
      // state.authStatus = AuthStatus.NOT_DETERMINED;
      state.getCurrentUser();*//*
    });*/
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //var state = Provider.of<AuthState>(context);
    AppDimens  _appDimens = Provider.of<AppDimens>(context);
    AppColors  _appColors = Provider.of<AppColors>(context);
    _appDimens.appDimensFind(context: context);

    Widget _body() {
      var height = 150.0;
      return Container(
        height: _appDimens.heightFullScreen(),
        width: _appDimens.widthFullScreen(),
        child: Container(
          height: height,
          width: height,
          alignment: Alignment.center,
          child: Container(
            padding: EdgeInsets.all(50),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Platform.isIOS
                    ? CupertinoActivityIndicator(
                  radius: 35,
                )
                    : CircularProgressIndicator(
                  strokeWidth: 2,
                ),
                Text("Splash")
              ],
            ),
          ),
        ),
      );
    }


    return Scaffold(
      backgroundColor: _appColors.white,
      body: _body(),
    );
  }

}
