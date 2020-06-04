import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class User {
  final String id;
  final String pseudo;
  final String mail;
  final bool isOrganizer;

  User({
    @required this.id,
    @required this.pseudo,
    @required this.mail,
    @required this.isOrganizer,
  });

  factory User.fromDocument(DocumentSnapshot doc) {
    return User(
        id: doc['userId'],
        mail: doc['mail'],
        pseudo: doc['pseudo'],
        isOrganizer: doc['isOrganizer'],
    );
  }
}
