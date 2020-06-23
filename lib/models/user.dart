import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class User {
  final String id;
  final String pseudo;
  final String mail;
  final bool isOrganizer;
  final Map coordinates;

  User({
    @required this.id,
    @required this.pseudo,
    @required this.mail,
    @required this.isOrganizer,
    this.coordinates,
  });

  factory User.fromDocument(DocumentSnapshot doc) {
    return User(
      id: doc['userId'],
      mail: doc['mail'],
      pseudo: doc['pseudo'],
      isOrganizer: doc['isOrganizer'],
      coordinates: doc['location'],
    );
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['userId'],
      mail: map['mail'],
      pseudo: map['pseudo'],
      isOrganizer: map['isOrganizer'],
      coordinates: map['location'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "userId": id,
      "pseudo": pseudo,
      "mail": mail,
      "isOrganizer": isOrganizer,
      "location": coordinates,
    };
  }
}
