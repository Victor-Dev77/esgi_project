import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:esgi_project/models/user.dart';
import 'package:esgi_project/routes.dart';
import 'package:esgi_project/screens/login.dart';
import 'package:esgi_project/screens/splashscreen.dart';
import 'package:esgi_project/screens/squeleton.dart';
import 'package:esgi_project/utils/constant.dart';
import 'package:esgi_project/utils/constant_color.dart';
import 'package:esgi_project/utils/constant_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  //Assure que le moteur graphique Flutter est init
  WidgetsFlutterBinding.ensureInitialized();
  // Fixe app mode portrait
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isLoading = true;
  bool _isAuth = false;

  @override
  void initState() {
    super.initState();
    checkAuth();
  }

  checkAuth() {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final CollectionReference _docRef = Firestore.instance
            .collection(ConstantFirestore.collectionUser);
    _auth.currentUser().then((FirebaseUser user) async {
      if (user != null) {
        _docRef
            .document("${user.uid}")
            .get()
            .then((DocumentSnapshot doc) {
              if (doc.data != null) {
                Constant.currentUser = User.fromDocument(doc);
                setState(() {
                  _isAuth = true;
                });
                print("loggedin ${user.uid}");
              }
              return;
             });
      }
      setState(() {
        _isLoading = false;
      });
    });
  }

  Widget _handleStartPage() {
    if (_isLoading) return SplashScreen();
    if (_isAuth) return AppSqueleton(isOrganizer: Constant.currentUser.isOrganizer,);
    return Login();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WeMoov',
      theme: ThemeData(
        primaryColor: ConstantColor.primaryColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        scaffoldBackgroundColor: ConstantColor.white,
        //textTheme: TextTheme(

        //)
      ),
      debugShowCheckedModeBanner: false,
      home: _handleStartPage(),
      onGenerateRoute: Router.generateRoute,
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
