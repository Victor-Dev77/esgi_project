import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:esgi_project/models/event.dart';
import 'package:esgi_project/models/user.dart';
import 'package:esgi_project/utils/functions.dart';

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

  Future<List<Event>> getEventsWithCategory(String category) async {
    final CollectionReference _docRef =
        Firestore.instance.collection(_collectionEvent);
    try {
      List<Event> _listEvent = [];
      _docRef.where("category", isEqualTo: category).snapshots().listen((data) {
        data.documents.forEach((event) {
          _listEvent.add(Event.fromDocument(event));
        });
      });
      return _listEvent;
    } catch (_) {
      print("ERROR: Firebase Firestore API: getEventsWithCategory()");
      return null;
    }
  }

  Future<List<Event>> searchQueryEvent(Map<String, dynamic> search) async {
    final CollectionReference _docRef =
        Firestore.instance.collection(_collectionEvent);
    try {
      List<Event> _listEvent = [];
      await _query(search).snapshots().listen((data) {
        data.documents.forEach((doc) {
          Event event = Event.fromDocument(doc);
          _listEvent.add(event);
          print("in boucle: $_listEvent");
        });
      });
      print("after query: $_listEvent");
      return _listEvent;
    } catch (error) {
      print("ERROR: Firebase Firestore API: searchQueryEvent() => $error");
      return null;
    }
  }

  _query(Map<String, dynamic> search) {
    final CollectionReference _docRef =
        Firestore.instance.collection(_collectionEvent);
    if (search["category"].length > 0) {
      return _docRef.where('category', whereIn: search["category"]);
      //  .where('age', isLessThanOrEqualTo: int.parse(me.ageRange['max']))
      //  .orderBy('age', descending: false);
    }
    if (search["date"] != null) {
      print("timestamp: ${parseDateStringToTimestamp(search["date"], "dd/MM/yyyy HH:mm")}");
      return _docRef.where('dateEnd',
          isGreaterThan:
              parseDateStringToTimestamp(search["date"], "dd/MM/yyyy HH:mm"));
    }
    /*else {
      return docRef
          .where('sex', isEqualTo: me.searchSex)
          .where(
            'age',
            isGreaterThanOrEqualTo: int.parse(me.ageRange['min']),
          )
          .where('age', isLessThanOrEqualTo: int.parse(me.ageRange['max']))
          //FOR FETCH USER WHO MATCH WITH USER SEXUAL ORIENTAION
          // .where('sexualOrientation.orientation',
          //     arrayContainsAny: currentUser.sexualOrientation)
          .orderBy('age', descending: false);
    }*/
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
