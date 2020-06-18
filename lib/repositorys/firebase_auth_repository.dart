import 'package:esgi_project/api/firebase_auth_api.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class FirebaseAuthRepository {

  static FirebaseAuthRepository get to => Get.put(FirebaseAuthRepository());

  final FirebaseAuthAPI _authAPI = FirebaseAuthAPI();

  Stream<FirebaseUser> get onAuthStateChanged => this._authAPI.onAuthStateChanged;

  Future<FirebaseUser> getCurrentUser() async {
    return await _authAPI.getCurrentUser();
  }

  Future<AuthResult> signIn(String email, String password) async {
    return await _authAPI.signIn(email, password);
  }

  Future<AuthResult> signUp(String email, String password) async {
    return await _authAPI.signUp(email, password);
  }

  signOut() async {
    await _authAPI.signOut();
  }

}
