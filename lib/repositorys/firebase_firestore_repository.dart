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

}
