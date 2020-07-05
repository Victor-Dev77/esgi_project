import 'dart:async';

import 'package:esgi_project/controllers/user_controller.dart';
import 'package:esgi_project/repositorys/firebase_auth_repository.dart';
import 'package:esgi_project/repositorys/firebase_firestore_repository.dart';
import 'package:esgi_project/services/location_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:esgi_project/routes.dart';
import 'package:esgi_project/models/user.dart';

class AuthController extends GetxController {
  // sert a acceder a ce controller partout
  static AuthController get to => Get.find();


  Stream<FirebaseUser> _onAuthStateChanged;

  FirebaseAuthRepository _authRepo = FirebaseAuthRepository.to;
  FirebaseFirestoreRepository _bddRepo = FirebaseFirestoreRepository.to;

  @override
  void onInit() async {
    super.onInit();
    //_currentUser = Rx(await _authRepo.getCurrentUser());
    _onAuthStateChanged = _authRepo.onAuthStateChanged;
    _onAuthStateChanged.listen((event) async {
      if (event == null) {
        //_currentUser.value = null;
        Get.offAllNamed(Router.loginRoute);
      } else {
        FirebaseUser _currentUser = await _authRepo.getCurrentUser();
        User user = await _bddRepo.getUser(_currentUser.uid);
        if (user == null) {
          user = await _registerUser(_currentUser.uid, _emailController.text.trim(), _pseudoController.text.trim(), _passwordController.text.trim(), _isOrganizerCheckbox);
        }
        else {
          var location = await LocationService.updateLocation(_currentUser.uid);
          user.location = location;
        }
        if (user != null) {
          UserController.to.initUser(user);
          Get.offAllNamed(Router.squeletonRoute);
        } else {
          Get.offAllNamed(Router.loginRoute);
        }
      }
    });
  }

  final TextEditingController _emailController = TextEditingController();
  TextEditingController get emailController => this._emailController;

  final TextEditingController _pseudoController = TextEditingController();
  TextEditingController get pseudoController => this._pseudoController;

  final TextEditingController _passwordController = TextEditingController();
  TextEditingController get passwordController => this._passwordController;

  bool _isOrganizerCheckbox = false;
  bool get isOrganizerCheckbox => this._isOrganizerCheckbox;

  changeIsOrganizerCheck(bool value) {
    _isOrganizerCheckbox = value;
    update();
  }
  

  signIn() async {
    try {
      await _authRepo.signIn(_emailController.text.trim(), _passwordController.text.trim());
    } catch (err) {
      print("ERROR: AuthController: signin()");
    }
  }

  signUp() async {
    try {
      await _authRepo.signUp(_emailController.text.trim(), _passwordController.text.trim());
    } catch (err) {
      print("ERROR: AuthController: signUp() - $err");
    }
  }

  Future<User> _registerUser(String id, String email, String pseudo,
      String password, bool isOrganizer) async {
    var location = await LocationService.getLocation();
    User user = User(id: id, mail: email, pseudo: pseudo, isOrganizer: isOrganizer, location: location);
    UserController.to.initUser(user);
    await _bddRepo.setUser(user.toMap());
    print("user in bdd: $user");
    return user;
  }

  signOut() async {
    await _authRepo.signOut();
  }
}
