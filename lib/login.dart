import 'package:esgi_project/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:esgi_project/home.dart';


class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final _auth = FirebaseAuth.instance;
  String email, password;

  Future<void> signUserIn() async {
    try {
      final newUser = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
          print(newUser.toString());
        if (newUser != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Home()
            ),
          );
        }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(top: 0, left: 30.0, right: 30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 0.0),
                  child: Image.asset(
                    'assets/logo.png',
                  ),
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
                      labelStyle: TextStyle(fontWeight: FontWeight.w400)
                    )
                ),
                SizedBox(
                  height: 20.0,
                ),
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
                      labelStyle: TextStyle(fontWeight: FontWeight.w400)
                    )
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                  child: RawMaterialButton(
                    onPressed: () {
                      signUserIn();
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      child: Text(
                        'Se Connecter',
                        style: TextStyle(
                            color: Colors.white, 
                            fontWeight: FontWeight.w400
                        ),
                      ),
                    ),
                    elevation: 7.0,
                    fillColor: Colors.purple.shade300,
                    shape: StadiumBorder(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: RawMaterialButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SignUp()
                        )
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      child: Text(
                        "S'inscrire",
                        style: TextStyle(
                            color: Colors.white, 
                            fontWeight: FontWeight.w400
                        ),
                      ),
                    ),
                    elevation: 7.0,
                    fillColor: Colors.purple.shade300,
                    shape: StadiumBorder(),
                  ),
                ),
              ],
            ),
          ),
        )),
    );
  }
}