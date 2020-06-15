import 'package:esgi_project/screens/home.dart';
import 'package:esgi_project/screens/login.dart';
import 'package:esgi_project/screens/sign_up.dart';
import 'package:esgi_project/screens/splashscreen.dart';
import 'package:esgi_project/screens/squeleton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Router {

  static const String splashRoute = "/";
  static const String homeRoute = "/home";
  static const String loginRoute = "/login";
  static const String signUpRoute = "/signup";
  static const String squeletonRoute = "/squeleton";

  static final routes = {
    splashRoute : GetRoute(page: SplashScreen()),
    homeRoute : GetRoute(page: Home()),
    loginRoute : GetRoute(page: Login()),
    signUpRoute : GetRoute(page: SignUp()),
    squeletonRoute : GetRoute(page: AppSqueleton()),
  };

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
      case squeletonRoute:
        var data = settings.arguments as bool;
        return MaterialPageRoute(builder: (_) => AppSqueleton());

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
