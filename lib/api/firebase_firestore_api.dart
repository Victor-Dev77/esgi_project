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

  updateUserLocation(String idUser, Map<String, dynamic> location) async {
    Firestore.instance
        .collection(_collectionUser)
        .document(idUser)
        .setData(location, merge: true);
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
      QuerySnapshot snap =
          await _docRef.where("userId", isEqualTo: uid).getDocuments();
      snap.documents.forEach((event) {
        _listEvent.add(Event.fromDocument(event));
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
      QuerySnapshot snap = await _docRef.limit(25).getDocuments();
      snap.documents.forEach((event) {
        _listEvent.add(Event.fromDocument(event));
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
      QuerySnapshot snap =
          await _docRef.where("category", isEqualTo: category).getDocuments();
      snap.documents.forEach((event) {
        _listEvent.add(Event.fromDocument(event));
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
      QuerySnapshot snap = await _query(search).getDocuments();
      //TODO: pas filter par distance si = 0
      snap.documents.forEach((doc) {
        Event event = Event.fromDocument(doc);
        _listEvent.add(event);
      });
      return _listEvent;
    } catch (error) {
      print("ERROR: Firebase Firestore API: searchQueryEvent() => $error");
      return null;
    }
  }

  _query(Map<String, dynamic> search) {
    final CollectionReference _docRef =
        Firestore.instance.collection(_collectionEvent);
        Query query;
    if (search["date"] != null) {
      print("timestamp: ${parseDateStringToTimestamp(search["date"], "dd/MM/yyyy HH:mm")}");
      query = _docRef.where('dateEnd',
          isGreaterThan:
              parseDateStringToTimestamp(search["date"], "dd/MM/yyyy HH:mm"));
    }
    if (search["category"].length > 0) {
      if (query == null)
        query = _docRef.where('category', whereIn: search["category"]);
      else
        query = query..where('category', whereIn: search["category"]);
      //  .where('age', isLessThanOrEqualTo: int.parse(me.ageRange['max']))
      //  .orderBy('age', descending: false);
    }
    if (query == null) {
      // recup event avec date du jour par defaut 
      query = _docRef.where('dateEnd',
          isGreaterThan: parseDateTimeToTimestamp(DateTime.now()));
    }
    return query;
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
      QuerySnapshot snap = await _docRef.getDocuments();
      snap.documents.forEach((event) {
        _listEvent.add(Event.fromDocument(event));
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
