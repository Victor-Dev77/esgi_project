import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:esgi_project/models/user.dart';
import 'package:flutter/material.dart';

class Event {
  final String userId, title, content, address, dateStart, dateEnd;
  final User userOrganizer;
  final int price;
  final List<String> pictures;

  Event({
    this.userId,
    this.title,
    this.content,
    this.address,
    this.dateStart,
    this.dateEnd,
    this.userOrganizer,
    this.price,
    this.pictures,
  });

  factory Event.fromDocument(DocumentSnapshot doc) {
    return Event(
      userId: doc['userId'],
      title: doc['title'],
      content: doc['content'],
      address: doc['address'],
      dateStart: doc["dateStart"],
      dateEnd: doc["dateEnd"],
      price: doc["price"],
      userOrganizer: User.fromMap(doc["userOrganizer"]),
      pictures: List.generate(doc['pictures'].length, (index) {
        return doc['pictures'][index] as String;
      }),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "userId": userId,
      "title": title,
      "content": content,
      "address": address,
      "dateStart": dateStart,
      "dateEnd": dateEnd,
      "price": price,
      "userOrganizer": userOrganizer.toMap(),
      "pictures": pictures
    };
  }
}
