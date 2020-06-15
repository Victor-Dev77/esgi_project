import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthAPI {
  Future<FirebaseUser> getCurrentUser() async {
    try {
      return await FirebaseAuth.instance.currentUser();
    } catch (_) {
      print("ERROR: Firebase Auth API: GetCurrentUser()");
      return null;
    }
  }
}
