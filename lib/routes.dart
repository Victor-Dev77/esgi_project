import 'package:esgi_project/controllers/bindings/squeleton_binding.dart';
import 'package:esgi_project/screens/event_detail.dart';
import 'package:esgi_project/screens/login.dart';
import 'package:esgi_project/screens/my_events.dart';
import 'package:esgi_project/screens/my_favorite_events.dart';
import 'package:esgi_project/screens/search_result.dart';
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
  static const String searchResultRoute = "/search_result";
  static const String myEventsRoute = "/settings/my_events";
  static const String myFavoriteRoute = "/settings/my_favorite";

  static final routes = [
    GetPage(name: splashRoute, page: () => SplashScreen()),
    GetPage(name: loginRoute, page: () => Login()),
    GetPage(name: signUpRoute, page: () => SignUp()),
    GetPage(name: squeletonRoute, page: () => AppSqueleton(), binding: SqueletonBinding()),
    GetPage(name: eventDetailRoute, page: () => EventDetail()),
    GetPage(name: myEventsRoute, page: () => MyEvents()),
    GetPage(name: myFavoriteRoute, page: () => MyFavoriteEvents()),
    GetPage(name: searchResultRoute, page: () => SearchResult()),
  ];
}
