
import 'package:dovui_app/src/presentation/moreapp/more_app.dart';
import 'package:dovui_app/src/presentation/presentation.dart';
import 'package:flutter/material.dart';
import 'homepage/home_screen.dart';
import 'navigation/navigation_screen.dart';

class Routers {
  static const String splash = "/screen";
  static const String homePage = "/homepage";
  static const String moreapp = "/moreapp";



  static Route<dynamic> generateRoute(RouteSettings settings) {
    var arguments = settings.arguments;
    switch (settings.name) {
      case splash:
        return animRoute(SplashScreen(), name: splash);
        break;
      case homePage:
        return animRoute(HomeScreen(),name: homePage);
        break;
      case moreapp:
        return animRoute(MoreApp(),name: moreapp);
      default:
        return animRoute(Container(
            child:
                Center(child: Text('No route defined for ${settings.name}'))
          )
        );
    }
  }

  static Route animRoute(Widget page,
      {Offset beginOffset, String name, Object arguments}) {
    return PageRouteBuilder(
      settings: RouteSettings(name: name, arguments: arguments),
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = beginOffset ?? Offset(0.0, 0.0);
        var end = Offset.zero;
        var curve = Curves.ease;
        var tween = Tween(begin: begin, end: end).chain(
          CurveTween(curve: curve),
        );

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  static Offset center = Offset(0.0, 0.0);
  static Offset top = Offset(0.0, 1.0);
  static Offset bottom = Offset(0.0, -1.0);
  static Offset left = Offset(-1.0, 0.0);
  static Offset right = Offset(1.0, 0.0);
}
