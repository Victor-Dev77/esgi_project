import 'package:esgi_project/screens/event_detail.dart';
import 'package:esgi_project/screens/login.dart';
import 'package:esgi_project/screens/my_events.dart';
import 'package:esgi_project/screens/sign_up.dart';
import 'package:esgi_project/screens/splashscreen.dart';
import 'package:esgi_project/screens/squeleton.dart';
import 'package:get/get.dart';

class Router {

  static const String splashRoute = "/";
  static const String homeRoute = "/home";
  static const String loginRoute = "/login";
  static const String signUpRoute = "/signup";
  static const String squeletonRoute = "/squeleton";
  static const String eventDetailRoute = "/eventdetail";
  static const String myEventsRoute = "/settings/my_events";

  static final routes = {
    splashRoute : GetRoute(page: SplashScreen()),
    loginRoute : GetRoute(page: Login()),
    signUpRoute : GetRoute(page: SignUp()),
    squeletonRoute : GetRoute(page: AppSqueleton()),
    eventDetailRoute : GetRoute(page: EventDetail()),
    myEventsRoute : GetRoute(page: MyEvents()),
  };
}
