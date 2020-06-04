import 'package:esgi_project/home.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _auth = FirebaseAuth.instance;
  String email, password, lastName, firstName;

  Future<void> signUserIn() async {
    try {
      final newUser =
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      if (newUser != null) {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Home()),
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
                  padding: const EdgeInsets.symmetric(vertical: 0),
                   child: Image.asset(
                    'assets/logo.png',
                  )
                ),
                TextField(
                    style: TextStyle(fontWeight: FontWeight.w500),
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (value) {
                      email = value; //get the value entered by user.
                    },
                    decoration: InputDecoration(
                        suffixIcon: Icon(Icons.email),
                        hintText: 'Votre Email',
                        labelText: 'Votre Email',
                        labelStyle: TextStyle(fontWeight: FontWeight.w400)
                    )
                ),
                SizedBox(
                  height: 10.0,
                ),
                TextField(
                    style: TextStyle(fontWeight: FontWeight.w500),
                    onChanged: (value) {
                      lastName = value; //get the value entered by user.
                    },
                    decoration: InputDecoration(
                        suffixIcon: Icon(Icons.person),
                        hintText: 'Nom',
                        labelText: 'Nom',
                        labelStyle: TextStyle(fontWeight: FontWeight.w400)
                    )
                ),
                SizedBox(
                  height: 10.0,
                ),
                TextField(
                    style: TextStyle(fontWeight: FontWeight.w500),
                    onChanged: (value) {
                      firstName = value; //get the value entered by user.
                    },
                    decoration: InputDecoration(
                        suffixIcon: Icon(Icons.person),
                        hintText: 'Prénom',
                        labelText: 'Prénom',
                        labelStyle: TextStyle(fontWeight: FontWeight.w400)
                    )
                ),
                SizedBox(
                  height: 10.0,
                ),
                TextField(
                    obscureText: true,
                    style: TextStyle(fontWeight: FontWeight.w500),
                    onChanged: (value) {
                      password = value; //get the value entered by user.
                    },
                    decoration: InputDecoration(
                        suffixIcon: Icon(Icons.lock),
                        hintText: 'Mot de passe',
                        labelText: 'Mot de passe',
                        labelStyle: TextStyle(fontWeight: FontWeight.w400)
                    )
                ),
                SizedBox(
                  height: 10.0,
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
                        "S'inscrire",
                        style: TextStyle(
                            color: Colors.white, 
                            fontWeight: FontWeight.w400
                        ),
                      ),
                    ),
                    elevation: 6.0,
                    fillColor: Colors.purple.shade300,
                    shape: StadiumBorder(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0, bottom: 50),
                  child: RawMaterialButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      child: Text(
                        'Se Connecter',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w400),
                      ),
                    ),
                    elevation: 6.0,
                    fillColor: Colors.purple.shade300,
                    shape: StadiumBorder(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}