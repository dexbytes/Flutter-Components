import 'dart:convert';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:fullter_main_app/src/all_file_import/app_providers_files_link.dart';
import 'package:fullter_main_app/src/all_file_import/app_screens_files_link.dart';
import 'package:fullter_main_app/src/api_calling/api_constant.dart';
import 'package:fullter_main_app/src/app_utility/app_localizations.dart';
import 'package:fullter_main_app/src/helper/local_constant.dart';
import 'package:fullter_main_app/src/helper/shared_preferencesFile.dart';
import 'package:fullter_main_app/src/pages/home_new_page.dart';
import 'package:fullter_main_app/src/state/appState.dart';
import 'package:fullter_main_app/src/state/theme_changer.dart';
import 'package:fullter_main_app/src/state/user_auth_state.dart';
import 'package:provider/provider.dart';
import 'src/all_file_import/app_values_files_link.dart';
import 'package:fullter_main_app/src/config/routes.dart';

void main() async {
  // if you are using await in main function then add this line
  WidgetsFlutterBinding.ensureInitialized();
  //Firebase Crashlytics
  await Firebase.initializeApp();
  FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
  // Pass all uncaught errors to Crashlytics.
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  Provider.debugCheckInvalidValueType = null;
  //Firebase Crashlytics

  // Restrict for portrait mode only
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  bool isLoggedIn = await SharedPreferencesFile().readBool(isUSerLoggedInC);
  Locale mLocale = isLoggedIn ? await lang() : null;

  Provider.debugCheckInvalidValueType = null;
  return runApp(MyAppFlutterMain(isLoggedIn: isLoggedIn, locale: mLocale));
}

Future<Locale> lang() async {
  Locale mLocale = Locale('en', 'US');
  String languageCode, countryCode;
  String value = await SharedPreferencesFile().readStr(languageCodeC);

  if (value != null && value != '') {
    Map localDetails = json.decode(value);
    languageCode = localDetails["languageCode"];
    countryCode = localDetails["countryCode"];
    if (languageCode != null &&
        languageCode != '' &&
        countryCode != null &&
        countryCode != '') {
      mLocale = Locale(languageCode, countryCode);
    } else {
      mLocale = null;
    }
  }
  //First Time User
  else {
    mLocale = null;
    SharedPreferencesFile().saveStr(selectedLanguageC, selectedLanguageKoreanC);
    SharedPreferencesFile().saveBool(isNotFirstTime, true);
  }
  return mLocale;
}

class MyAppFlutterMain extends StatefulWidget {
  final bool isLoggedIn;
  final Locale locale;

  MyAppFlutterMain({Key key, this.isLoggedIn, this.locale}) : super(key: key);

  static void setLocale(BuildContext context, Locale newLocale) async {
    _MyAppState state = context.findAncestorStateOfType<_MyAppState>();
    state.changeLanguage(newLocale);
  }

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyAppFlutterMain> {
  bool isCheckedLang = false;
  bool isInit = false;

  Locale _locale = Locale('en', 'US');
  Locale _localeDefult = Locale('en', 'US');

  _MyAppState() {
    getLanguage();
  }

  String selectedCatName;

  var supportedLocales1 = [
    Locale('en', 'US'),
    Locale('ko', 'KR'),
  ];

  @override
  void initState() {
    try {
      //  versionCheck(context);
    } catch (e) {
      print(e);
    }
    super.initState();
  }

  changeLanguage(Locale locale) {
    setState(() {
      _locale = locale;
      String languageCode = locale.languageCode;
      String countryCode = locale.countryCode;
      var localDetails = {
        "languageCode": languageCode,
        "countryCode": countryCode
      };

      String localDetailsStr = jsonEncode(localDetails);
      SharedPreferencesFile().saveStr(languageCodeC, localDetailsStr);
    });
  }

  getLanguage() async {
    selectedCatName =
        await SharedPreferencesFile().readStr(selectedCategoryNameC);

    SharedPreferencesFile().readBool(isNotFirstTime).then((value) {
      if (value != null && value == false) {
        _locale = _localeDefult;
        SharedPreferencesFile()
            .saveStr(selectedLanguageC, selectedLanguageKoreanC);
        changeLanguage(_locale);
        SharedPreferencesFile().saveBool(isNotFirstTime, true);

      } else {
        String languageCode, countryCode;
        SharedPreferencesFile().readStr(languageCodeC).then((value) {
          if (value != null && value != '') {
            Map localDetails = json.decode(value);
            languageCode = localDetails["languageCode"];
            countryCode = localDetails["countryCode"];
            if (languageCode != null &&
                languageCode != '' &&
                countryCode != null &&
                countryCode != '') {
              setState(() {
                _locale = Locale(languageCode, countryCode);
              });
            } else {
              setState(() {
                _locale = _localeDefult;
              });
            }
          }
        });
        //projectUtil.printP("main","language code2: $languageCode $countryCode");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.locale != null && !isInit) {
      setState(() {
        isInit = true;
        _locale = widget.locale;
      });
    }

    if (Platform.isAndroid) {
      try {
        // Brightness.light - For status bar icon color white
        // Brightness.dark - For status bar icon color black
        // statusBarColor: Transparent,
        SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.light,
            statusBarColor:
                AppColors().appStatusBarColor[700])); //top bar icons));
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
          ChangeNotifierProvider<NotificationState>(
            create: (_) => NotificationState(),
          ),
          ChangeNotifierProvider<AppState>(
            create: (_) => AppState(),
          ),
          ChangeNotifierProvider<UserAuthState>(
            create: (_) => UserAuthState(),
          ), //Manage app status
          ChangeNotifierProvider<ThemeChanger>(
            create: (_) => ThemeChanger(),
          ), //Manage app status
          Provider<AppStyle>(
            create: (context) => AppStyle(),
          ),
          Provider<AppDimens>(
            create: (context) => AppDimens(),
          ),
          Provider<AppColors>(
            create: (context) => AppColors(),
          ),
          Provider<AppFonts>(
            create: (context) => AppFonts(),
          ),
          Provider<AppString>(
            create: (context) => AppString(),
          ),

          /*Provider<UserAuthState>(
            create: (context) => UserAuthState(),*/
          //),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: !ConstantC.isProduction,
          title: 'All Flutter module',
          // List all of the app's supported locales here
          supportedLocales: supportedLocales1,
          locale: _locale,
          theme: ThemeData(
            brightness: Brightness.light,
            primarySwatch: Colors.blue,
          ),

          // These delegates make sure that the localization data for the proper language is loaded
          localizationsDelegates: [
            // THIS CLASS WILL BE ADDED LATER
            // A class which loads the translations from JSON files
            AppLocalizations.delegate,
            // Built-in localization of basic text for Material widgets
            GlobalMaterialLocalizations.delegate,
            // Built-in localization for text direction LTR/RTL
            GlobalWidgetsLocalizations.delegate,
          ],

          // Returns a locale which will be used by the app
          localeResolutionCallback: (locale, supportedLocales) {
            // Check if the current device locale is supported
           // If the locale of the device is not supported, use the first one
          // from the list (English, in this case).
            return _locale != null ? _locale : supportedLocales.first;
          },
          home: (widget.isLoggedIn != null &&
                  widget.isLoggedIn &&
                  selectedCatName != null)
              ? mainLandingScreen()
              : anotherLandingScreen(),
          //Routes File
          routes: Routes.route(),
          onGenerateRoute: (settings) => Routes.onGenerateRoute(settings),
          onUnknownRoute: (settings) => Routes.onUnknownRoute(settings),
        ));
  }

  mainLandingScreen() {
    return MainPage();
  }

  selectCategoryScreen() {
    // return SplashPage(isLoggedIn: widget.isLoggedIn);
    return HomeNewPage();
  }

  anotherLandingScreen() {
    return HomeNewPage();
    // return SplashPage(isLoggedIn: widget.isLoggedIn);
  }
}
