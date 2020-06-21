import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:esgi_project/models/event.dart';
import 'package:esgi_project/models/user.dart';

class FirebaseFirestoreAPI {
  static final String _collectionUser = "users";
  static final String _collectionEvent = "events";
  static final String _collectionFavorite = "favorites";

  Future<User> getUser(String uid) async {
    final CollectionReference _docRef =
        Firestore.instance.collection(_collectionUser);
    try {
      var doc = await _docRef.document(uid).get();
      if (doc.data != null) {
        return User.fromDocument(doc);
      }
      return null;
    } catch (_) {
      print("ERROR: Firebase Firestore API: GetUser()");
      return null;
    }
  }

  setUser(Map<String, dynamic> user) async {
    await Firestore.instance
        .collection(_collectionUser)
        .document(user["userId"])
        .setData(user, merge: true);
  }

  addEvent(Map<String, dynamic> event) async {
    await Firestore.instance
        .collection(_collectionEvent)
        .document(event["id"])
        .setData(event);
  }

  deleteEvent(String id) async {
    await Firestore.instance.collection(_collectionEvent).document(id).delete();
  }

  Future<List<Event>> getMyEvents(String uid) async {
    final CollectionReference _docRef =
        Firestore.instance.collection(_collectionEvent);
    try {
      List<Event> _listEvent = [];
      _docRef.where("userId", isEqualTo: uid).snapshots().listen((data) {
        data.documents.forEach((event) {
          _listEvent.add(Event.fromDocument(event));
        });
      });
      return _listEvent;
    } catch (_) {
      print("ERROR: Firebase Firestore API: getMyEvents()");
      return null;
    }
  }

  Future<List<Event>> getPopularEvents() async {
    final CollectionReference _docRef =
        Firestore.instance.collection(_collectionEvent);
    try {
      List<Event> _listEvent = [];
      _docRef.limit(25).snapshots().listen((data) {
        data.documents.forEach((event) {
          _listEvent.add(Event.fromDocument(event));
        });
      });
      return _listEvent;
    } catch (_) {
      print("ERROR: Firebase Firestore API: getPopularEvents()");
      return null;
    }
  }

  Future<List<Event>> getMyFavoritesEvents(String idUser) async {
    final CollectionReference _docRef = Firestore.instance
        .collection(_collectionFavorite)
        .document(idUser)
        .collection("events");
    try {
      List<Event> _listEvent = [];
      _docRef.snapshots().listen((doc) {
        doc.documents.forEach((event) {
          _listEvent.add(Event.fromDocument(event));
        });
      });
      print("list fav: ${_listEvent.length}");
      return _listEvent;
    } catch (_) {
      print("ERROR: Firebase Firestore API: getMyFavoritesEvents()");
      return null;
    }
  }

  addFavoriteEvent(String userId, Map<String, dynamic> event) async {
    await Firestore.instance
        .collection(_collectionFavorite)
        .document(userId)
        .collection("events")
        .document(event["id"])
        .setData(event);
  }

  deleteFavoriteEvent(String idUser, String idEvent) async {
    await Firestore.instance
        .collection(_collectionFavorite)
        .document(idUser)
        .collection("events")
        .document(idEvent)
        .delete();
  }
}
