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

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['userId'],
      mail: map['mail'],
      pseudo: map['pseudo'],
      isOrganizer: map['isOrganizer'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "userId": id,
      "pseudo": pseudo,
      "mail": mail,
      "isOrganizer": isOrganizer,
    };
  }
}
