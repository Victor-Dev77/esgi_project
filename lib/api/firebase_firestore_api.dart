import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:esgi_project/models/event.dart';
import 'package:esgi_project/models/user.dart';
import 'package:esgi_project/utils/functions.dart';

class FirebaseFirestoreAPI {
  static final CollectionReference _collectionUser =
      Firestore.instance.collection("users");
  static final CollectionReference _collectionEvent =
      Firestore.instance.collection("events");
  static final CollectionReference _collectionFavorite =
      Firestore.instance.collection("favorites");

  Future<User> getUser(String uid) async {
    try {
      var doc = await _collectionUser.document(uid).get();
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
    await _collectionUser.document(user["userId"]).setData(user);
  }

  updateUserLocation(String idUser, Map<String, dynamic> location) async {
    _collectionUser.document(idUser).setData(location, merge: true);
  }

  addEvent(Map<String, dynamic> event) async {
    await _collectionEvent.document(event["id"]).setData(event);
  }

  deleteEvent(String id) async {
    await _collectionEvent.document(id).delete();
  }

  Future<List<Event>> getMyEvents(String uid) async {
    try {
      List<Event> _listEvent = [];
      QuerySnapshot snap =
          await _collectionEvent.where("userId", isEqualTo: uid).getDocuments();
      snap.documents.forEach((event) {
        _listEvent.add(Event.fromDocument(event));
      });
      return _listEvent;
    } catch (_) {
      print("ERROR: Firebase Firestore API: getMyEvents()");
      return [];
    }
  }

  Future<List<Event>> getPopularEvents() async {
    try {
      List<Event> _listEvent = [];
      QuerySnapshot snap = await _collectionEvent.limit(25).getDocuments();
      snap.documents.forEach((event) {
        _listEvent.add(Event.fromDocument(event));
      });
      return _listEvent;
    } catch (_) {
      print("ERROR: Firebase Firestore API: getPopularEvents()");
      return [];
    }
  }

  Future<List<Event>> getEventsWithCategory(String category) async {
    try {
      List<Event> _listEvent = [];
      QuerySnapshot snap = await _collectionEvent
          .where("category", isEqualTo: category)
          .getDocuments();
      snap.documents.forEach((event) {
        _listEvent.add(Event.fromDocument(event));
      });
      return _listEvent;
    } catch (_) {
      print("ERROR: Firebase Firestore API: getEventsWithCategory()");
      return [];
    }
  }

  Future<List<Event>> searchQueryEvent(Map<String, dynamic> search) async {
    try {
      List<Event> _listEvent = [];
      QuerySnapshot snap = await _query(search).getDocuments();
      snap.documents.forEach((doc) {
        Event event = Event.fromDocument(doc);
        if (search["distance"] == 0)
          _listEvent.add(event);
        else if (event.distanceBW <= search["distance"]) _listEvent.add(event);
      });
      return _listEvent;
    } catch (error) {
      print("ERROR: Firebase Firestore API: searchQueryEvent() => $error");
      return [];
    }
  }

  _query(Map<String, dynamic> search) {
    Query query;
    if (search["date"] != null) {
      print(
          "timestamp: ${parseDateStringToTimestamp(search["date"], "dd/MM/yyyy HH:mm")}");
      query = _collectionEvent.where('dateEnd',
          isGreaterThan:
              parseDateStringToTimestamp(search["date"], "dd/MM/yyyy HH:mm"));
    }
    if (search["category"].length > 0) {
      if (query == null)
        query = _collectionEvent.where('category', whereIn: search["category"]);
      else
        query = query..where('category', whereIn: search["category"]);
    }
    if (query == null) {
      // recup event avec date du jour par defaut
      query = _collectionEvent.where('dateEnd',
          isGreaterThan: parseDateTimeToTimestamp(DateTime.now()));
    }
    return query;
  }

  Future<List<Event>> getMyFavoritesEvents(String idUser) async {
    final CollectionReference _docRef =
        _collectionFavorite.document(idUser).collection("events");
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
      return [];
    }
  }

  addFavoriteEvent(String userId, Map<String, dynamic> event) async {
    await _collectionFavorite
        .document(userId)
        .collection("events")
        .document(event["id"])
        .setData(event);
  }

  deleteFavoriteEvent(String idUser, String idEvent) async {
    await _collectionFavorite
        .document(idUser)
        .collection("events")
        .document(idEvent)
        .delete();
  }
}
