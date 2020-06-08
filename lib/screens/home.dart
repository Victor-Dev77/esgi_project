import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:esgi_project/models/user.dart';
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

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(15),
              child: Text(_currentUser != null ? _currentUser.pseudo : "Chargement"),
            )
          ],
        ),
      ),
    );
  }
}
