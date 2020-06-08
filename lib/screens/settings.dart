import 'package:esgi_project/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:esgi_project/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:esgi_project/components/card_settings.dart';
import 'package:esgi_project/routes.dart';



class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {

  User _currentUser;

  @override
  void initState() {
    super.initState();
    _currentUser = Constant.currentUser;
  }

  Future<void> logOut() async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
            children: <Widget>[
              Container(
                alignment: Alignment.topLeft,
                child: Padding(
                    padding: EdgeInsets.all(25),
                    child: Text(
                      (_currentUser != null
                          ? "Vous-revoilà, " + _currentUser.pseudo + " 😉"
                          : "Chargement"),
                      style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold
                      ),
                      textAlign: TextAlign.left,
                    )
                ),
              ),
              SizedBox(height: 20.0),
              Center(
                  child: CardSettings(
                    text: 'Salut',
                    action: (){
                      print("Salut");
                    },
                  )
              ),
              SizedBox(height: 20.0),
              Center(
                  child: CardSettings(
                    text: 'Salut 2',
                    action: (){
                      print("Salut 2");
                    },
                  )
              ),
              SizedBox(height: 20.0),
              Center(
                  child: CardSettings(
                    text: 'Salut 3',
                    action: (){
                      print("Salut 3");
                    },
                  )
              ),
              SizedBox(height: 20.0),
              Center(
                  child: CardSettings(
                    text: 'Se déconnecter',
                    action: (){
                      logOut();
                      Navigator.pushNamedAndRemoveUntil(context, Router.loginRoute,
                          ModalRoute.withName(Router.homeRoute));
                    },
                  )
              )
            ]
        )
    );
  }
}
