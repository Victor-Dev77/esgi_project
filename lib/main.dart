import 'package:esgi_project/controllers/auth_controller.dart';
import 'package:esgi_project/controllers/user_controller.dart';
import 'package:esgi_project/routes.dart';
import 'package:esgi_project/utils/constant_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';

void main() async {
  //Assure que le moteur graphique Flutter est init
  WidgetsFlutterBinding.ensureInitialized();
  // Fixe app mode portrait
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'WeMoov',
      theme: ThemeData(
        primaryColor: ConstantColor.primaryColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        scaffoldBackgroundColor: ConstantColor.white,
        //textTheme: TextTheme(

        //)
      ),
      debugShowCheckedModeBanner: false,
      defaultTransition: Transition.fade,
      initialBinding: InitialBinding(),
      namedRoutes: Router.routes,
      initialRoute: Router.splashRoute,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate, // if it's a RTL language
      ],
      supportedLocales: [
        const Locale('fr', 'FR'), // include country code too
      ],
    );
  }
}

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(UserController());
    Get.put(AuthController());
  }
}