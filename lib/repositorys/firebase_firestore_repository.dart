import 'package:esgi_project/api/firebase_firestore_api.dart';
import 'package:esgi_project/models/event.dart';
import 'package:get/get.dart';
import 'package:esgi_project/models/user.dart';

class FirebaseFirestoreRepository {

  static FirebaseFirestoreRepository get to => Get.put(FirebaseFirestoreRepository());

  final FirebaseFirestoreAPI _firestoreAPI = FirebaseFirestoreAPI();

  Future<User> getUser(String uid) async {
    return await _firestoreAPI.getUser(uid);
  }

  setUser(Map<String, dynamic> user) async {
    await _firestoreAPI.setUser(user);
  }

  addEvent(Map<String, dynamic> event) async {
    await _firestoreAPI.addEvent(event);
  }

  deleteEvent(String id) async {
    await _firestoreAPI.deleteEvent(id);
  }

  Future<List<Event>> getMyEvents(String uid) async {
    return await _firestoreAPI.getMyEvents(uid);
  }

  Future<List<Event>> getPopularEvents() async {
    return await _firestoreAPI.getPopularEvents();
  }

  Future<List<Event>> getEventsWithCategory(String category) async {
    return await _firestoreAPI.getEventsWithCategory(category);
  }

  Future<List<Event>> searchQueryEvent(Map<String, dynamic> search) async {
    return await _firestoreAPI.searchQueryEvent(search);
  }




  Future<List<Event>> getMyFavoritesEvents(String uid) async {
    return await _firestoreAPI.getMyFavoritesEvents(uid);
  }

  addFavoriteEvent(String idUser, Map<String, dynamic> event) async {
    await _firestoreAPI.addFavoriteEvent(idUser, event);
  }

  deleteFavoriteEvent(String idUser, String idEvent) async {
    await _firestoreAPI.deleteFavoriteEvent(idUser, idEvent);
  }

}
