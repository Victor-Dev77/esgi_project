import 'package:esgi_project/login.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Future<void> logOut() async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Home'
        ),
        backgroundColor: Colors.purple.shade300,
        automaticallyImplyLeading: false, //Permet de 'cacher' le backButton.
      ),
      body: Center(
        child: RawMaterialButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Login()),
            );
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: Text(
              'Se Déconnecter',
              style: TextStyle(
                  color: Colors.white, fontWeight: FontWeight.w400),
            ),
          ),
          elevation: 6.0,
          fillColor: Colors.purple.shade300,
          shape: StadiumBorder(),
        ),
      ),
    );
  }
}
