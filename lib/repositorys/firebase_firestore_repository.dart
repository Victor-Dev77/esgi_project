import 'package:esgi_project/api/firebase_firestore_api.dart';
import 'package:get/get.dart';
import 'package:esgi_project/models/user.dart';

class FirebaseFirestoreRepository {

  static FirebaseFirestoreRepository get to => Get.put(FirebaseFirestoreRepository());

  final FirebaseFirestoreAPI _firestoreAPI = FirebaseFirestoreAPI();

  Future<User> getCurrentUser(String uid) async {
    return await _firestoreAPI.getCurrentUser(uid);
  }

}
