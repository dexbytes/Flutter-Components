import 'package:flutter/material.dart';
import 'package:fullter_main_app/src/all_file_import/app_screens_files_link.dart';
import 'package:fullter_main_app/src/config/customRoute.dart';

class Routes{
  static dynamic route(){
      return {
          'SplashPage': (BuildContext context) =>   SplashPage(),
      };
  }
  static void sendNavigationEventToFirebase(String path) {
    if(path != null && path.isNotEmpty){
      // analytics.setCurrentScreen(screenName: path);
    }
  }
  static Route onGenerateRoute(RouteSettings settings) {
     final List<String> pathElements = settings.name.split('/');
     if (pathElements[0] != '' || pathElements.length == 1) {
       return null;
     }
     switch (pathElements[1]) {
      case "MyHomePage":return CustomRoute<bool>(builder:(BuildContext context)=> MyHomePage());
      case "MainPage":return CustomRoute<bool>(builder:(BuildContext context)=> MainPage());
      default:return onUnknownRoute(RouteSettings(name: '/Feature'));
     }
  }

   static Route onUnknownRoute(RouteSettings settings){
     return MaterialPageRoute(
          builder: (_) => Scaffold(
                appBar: AppBar(title: Text('Title'),centerTitle: true,),
                body: Center(
                  child: Text('${settings.name.split('/')[1]} Comming soon..'),
                ),
              ),
        );
   }
}