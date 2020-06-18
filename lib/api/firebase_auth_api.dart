import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthAPI {

  Stream<FirebaseUser> get onAuthStateChanged => FirebaseAuth.instance.onAuthStateChanged;

  Future<FirebaseUser> getCurrentUser() async {
    try {
      return await FirebaseAuth.instance.currentUser();
    } catch (_) {
      print("ERROR: Firebase Auth API: GetCurrentUser()");
      return null;
    }
  }

  Future<AuthResult> signIn(String email, String password) async {
    return await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<AuthResult> signUp(String email, String password) async {
    return await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
  }

  signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
