import 'package:esgi_project/screens/home.dart';
import 'package:esgi_project/screens/login.dart';
import 'package:esgi_project/screens/sign_up.dart';
import 'package:esgi_project/screens/splashscreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:esgi_project/components/bottom_bar.dart';

class Router {

  static const String splashRoute = "/";
  static const String homeRoute = "/home";
  static const String loginRoute = "/login";
  static const String signUpRoute = "/signup";
  static const String bottom_bar = "/bottombar";

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splashRoute:
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case homeRoute:
        return MaterialPageRoute(builder: (_) => Home());
      case loginRoute:
        return MaterialPageRoute(builder: (_) => Login());
      case signUpRoute:
        return MaterialPageRoute(builder: (_) => SignUp());
      case bottom_bar:
        return MaterialPageRoute(builder: (_) => BottomBar());

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text("No route defined for ${settings.name}"),
            ),
          ),
        );
    }
  }
}
