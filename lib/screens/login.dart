import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:esgi_project/controllers/login_controller.dart';
import 'package:esgi_project/models/user.dart';
import 'package:esgi_project/routes.dart';
import 'package:esgi_project/utils/constant.dart';
import 'package:esgi_project/utils/constant_color.dart';
import 'package:esgi_project/utils/constant_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
 // final _auth = FirebaseAuth.instance;
  String email, password;

  /*Future<void> signUserIn() async {
    try {
      final newUser = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (newUser != null) {
        await Firestore.instance
            .collection(ConstantFirestore.collectionUser)
            .document("${newUser.user.uid}")
            .get()
            .then((data) {
              User user = User.fromDocument(data);
              Constant.currentUser = user;
              Get.toNamed(Router.squeletonRoute, arguments: user.isOrganizer);
            //  Navigator.pushReplacementNamed(context, Router.squeletonRoute, arguments: user.isOrganizer);
              return;
             });
      }
    } catch (e) {
      print(e);
    }
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(), // enleve clavier si clique ailleurs
          child: Container(
          padding: EdgeInsets.only(top: 0, left: 30.0, right: 30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(vertical: 0.0),
                child: Image.asset(Constant.pathLogoImage),
              ),
              TextField(
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) {
                    email = value; // get value from TextField
                  },
                  style: TextStyle(fontWeight: FontWeight.w500),
                  decoration: InputDecoration(
                      suffixIcon: Icon(Icons.email),
                      hintText: 'Votre Email',
                      labelText: 'Votre Email',
                      labelStyle: TextStyle(fontWeight: FontWeight.w400))),
              SizedBox(height: 20.0),
              TextField(
                  obscureText: true,
                  style: TextStyle(fontWeight: FontWeight.w500),
                  onChanged: (value) {
                    password = value; // get value from TextField
                  },
                  decoration: InputDecoration(
                      suffixIcon: Icon(Icons.lock),
                      hintText: 'Mot de passe',
                      labelText: 'Mot de passe',
                      labelStyle: TextStyle(fontWeight: FontWeight.w400))),
              Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: RawMaterialButton(
                  onPressed: () {
                    LoginController.to.signIn(email, password);
                   // signUserIn();
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: Text(
                      'Se Connecter',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w400),
                    ),
                  ),
                  elevation: 7.0,
                  fillColor: ConstantColor.primaryColor,
                  shape: StadiumBorder(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: GestureDetector(
                  onTap: () => Get.toNamed(Router.signUpRoute),//Navigator.pushNamed(context, Router.signUpRoute),
                  child: Container(
                    height: 50,
                    child: Center(
                      child: Text(
                        "S'inscrire",
                        style: TextStyle(
                          color: ConstantColor.primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        )
      )),
    );
  }
}
