import 'package:esgi_project/controllers/auth_controller.dart';
import 'package:esgi_project/localization/localization.dart';
import 'package:esgi_project/routes.dart';
import 'package:esgi_project/utils/constant.dart';
import 'package:esgi_project/utils/constant_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String email, password;

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
                      hintText: Localization.yourEmail.tr,
                      labelText: Localization.yourEmail.tr,
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
                      hintText: Localization.yourPassword.tr,
                      labelText: Localization.yourPassword.tr,
                      labelStyle: TextStyle(fontWeight: FontWeight.w400))),
              Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: RawMaterialButton(
                  onPressed: () {
                    //TODO: gerer champs dans controller, ensuite pas envoyer en
                    // param email, pwd car sera deja dans controller
                    AuthController.to.signIn(email, password);
                   // signUserIn();
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: Text(
                      Localization.signInTitle.tr,
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
                        Localization.signUpTitle.tr,
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
