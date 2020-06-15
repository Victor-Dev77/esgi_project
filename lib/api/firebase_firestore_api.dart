import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:esgi_project/models/user.dart';

class FirebaseFirestoreAPI {
  static final String _collectionUser = "users";

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
    return null;
  }
}
