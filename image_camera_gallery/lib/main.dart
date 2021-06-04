import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'src/state/imageSelectState.dart';

void main() async {
  // if you are using await in main function then add this line
  WidgetsFlutterBinding.ensureInitialized();

  // Restrict for portrait mode only
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  Provider.debugCheckInvalidValueType = null;
  return runApp(MyAppFlutterMain());
}

class MyAppFlutterMain extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyAppFlutterMain> {
  bool isInit = false;

  @override
  void initState() {
    try {
      //  versionCheck(context);
    } catch (e) {
      print(e);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) {
      try {
        // Brightness.light - For status bar icon color white
        // Brightness.dark - For status bar icon color black
        // statusBarColor: Transparent,
        /*SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.light,
            statusBarColor:
                AppColors().appStatusBarColor[700])); */ //top bar icons));
      } catch (e) {
        print(e);
      }
    } else {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
              statusBarIconBrightness: Brightness.dark) // Or Brightness.dark
          );
    }

    return MultiProvider(
        providers: [
          ChangeNotifierProvider<ImageSelectState>(
            create: (_) => ImageSelectState(),
          )
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Base App',
          theme: ThemeData(
            brightness: Brightness.light,
            primarySwatch: Colors.blue,
          ),
          home: mainLandingScreen(),
          //Routes File
          /* routes: Routes.route(),
          onGenerateRoute: (settings) => Routes.onGenerateRoute(settings),
          onUnknownRoute: (settings) => Routes.onUnknownRoute(settings),*/
        ));
  }

  mainLandingScreen() {
    return Container();
  }
}
