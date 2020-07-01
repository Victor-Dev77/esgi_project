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

  Rx<FirebaseUser> _currentUser;

  FirebaseAuthRepository _authRepo = FirebaseAuthRepository.to;
  FirebaseFirestoreRepository _bddRepo = FirebaseFirestoreRepository.to;

  @override
  void onInit() async {
    super.onInit();
    _currentUser = Rx(await _authRepo.getCurrentUser());
    _authRepo.onAuthStateChanged.listen((event) async {
      if (event == null) {
        _currentUser.value = null;
        Get.offAllNamed(Router.loginRoute);
      } else {
        _currentUser.value = await _authRepo.getCurrentUser();
        await LocationService.updateLocation(_currentUser.value.uid);
        var user = await _bddRepo.getUser(_currentUser.value.uid);
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
    update(["isOrganizerCheck"]);
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
      var newUser = await _authRepo.signUp(_emailController.text.trim(), _passwordController.text.trim());
      if (newUser != null) {
        await _registerUser(
            newUser.user.uid, _emailController.text.trim(), _pseudoController.text.trim(), _passwordController.text.trim(), _isOrganizerCheckbox);
      }
    } catch (err) {
      print("ERROR: AuthController: signUp()");
    }
  }

  Future<User> _registerUser(String id, String email, String pseudo,
      String password, bool isOrganizer) async {
    var location = await LocationService.getLocation();
    User user = User(id: id, mail: email, pseudo: pseudo, isOrganizer: isOrganizer, location: location);
    await _bddRepo.setUser(user.toMap());
    return user;
  }

  signOut() async {
    await _authRepo.signOut();
  }
}
