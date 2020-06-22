import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:esgi_project/models/user.dart';
import 'package:esgi_project/utils/functions.dart';
import 'package:flutter/material.dart';

class Event {
  final String id, userId;
  final User userOrganizer;
  String title, content, category, address, dateStart, dateEnd;
  int price;
  List<String> pictures;
  final bool preview;

  Event({
    this.id,
    this.userId,
    this.title,
    this.content,
    this.category,
    this.address,
    this.dateStart,
    this.dateEnd,
    this.userOrganizer,
    this.price,
    this.pictures,
    this.preview: false,
  });

  factory Event.fromDocument(DocumentSnapshot doc) {
    print(doc["dateStart"]);
    return Event(
      id: doc["id"],
      userId: doc['userId'],
      title: doc['title'],
      content: doc['content'],
      category: doc['category'],
      address: doc['address'],
      dateStart: parseDateTime(doc["dateStart"].toDate(), "dd/MM/yyyy HH:mm"),
      dateEnd: parseDateTime(doc["dateEnd"].toDate(), "dd/MM/yyyy HH:mm"),
      price: doc["price"],
      userOrganizer: User.fromMap(doc["userOrganizer"]),
      pictures: List.generate(doc['pictures'].length, (index) {
        return doc['pictures'][index] as String;
      }),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "userId": userId,
      "title": title,
      "content": content,
      "category": category,
      "address": address,
      "dateStart": parseDateString(dateStart, "dd/MM/yyyy HH:mm"),
      "dateEnd": parseDateString(dateEnd, "dd/MM/yyyy HH:mm"),
      "price": price,
      "userOrganizer": userOrganizer.toMap(),
      "pictures": pictures
    };
  }
}
