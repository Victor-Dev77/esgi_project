import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:esgi_project/models/user.dart';
import 'package:esgi_project/routes.dart';
import 'package:esgi_project/utils/constant_color.dart';
import 'package:esgi_project/utils/constant_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  CollectionReference _docRef =
      Firestore.instance.collection(ConstantFirestore.collectionUser);
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  User _currentUser;

  @override
  void initState() {
    super.initState();
    _getCurrentUser();
  }

  _getCurrentUser() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return _docRef.document("${user.uid}").snapshots().listen((data) async {
      _currentUser = User.fromDocument(data);
      if (mounted) setState(() {});
      return _currentUser;
    });
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        backgroundColor: ConstantColor.primaryColor,
        automaticallyImplyLeading: false, //Permet de 'cacher' le backButton.
      ),
      body: Center(
        child: Column(
          children: <Widget>[

            Padding(
              padding: EdgeInsets.all(15),
              child: Text(_currentUser != null ? _currentUser.pseudo : "Chargement"),
            ),

            RawMaterialButton(
              onPressed: () {
                logOut();
                Navigator.pushNamedAndRemoveUntil(context, Router.loginRoute,
                    ModalRoute.withName(Router.homeRoute));
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
              fillColor: ConstantColor.primaryColor,
              shape: StadiumBorder(),
            ),
          ],
        ),
      ),
    );
  }
}
