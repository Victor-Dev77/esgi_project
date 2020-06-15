import 'package:esgi_project/controllers/user_controller.dart';
import 'package:esgi_project/repositorys/firebase_auth_repository.dart';
import 'package:esgi_project/repositorys/firebase_firestore_repository.dart';
import 'package:get/get.dart';
import 'package:esgi_project/routes.dart';
import 'package:esgi_project/models/user.dart';

class AuthController extends GetController {

  // sert a acceder a ce controller partout
  static AuthController get to => Get.put(AuthController());

  FirebaseAuthRepository _authRepo = FirebaseAuthRepository.to;
  FirebaseFirestoreRepository _bddRepo = FirebaseFirestoreRepository.to;

    //TODO; faire verif de chaque champs 

  signIn(String email, String password) async {
    // TODO: Methode final a appeler quand tt les champs sont Ok.
    // doit incasseble de l'extérieur --> rendre private.
    try {
      var result = await _authRepo.signIn(email, password);
      if (result != null) {
        var user = await _bddRepo.getUser(result.user.uid);
        UserController.to.user = user; //set user dans controller
        print(UserController.to.user.pseudo);
        Get.toNamed(Router.squeletonRoute);
      }
    } catch (err) {
      print("ERROR: AuthController: signin()");
    }
  }

  signUp(String email, String pseudo, String password, bool isOrganizer) async {
    try {
      var newUser = await _authRepo.signUp(email, password);
      if (newUser != null) {
        var user = await _registerUser(newUser.user.uid, email, pseudo, password, isOrganizer);
        UserController.to.user = user; //set user dans controller
        print(UserController.to.user.pseudo);
        Get.toNamed(Router.squeletonRoute);
      }
    } catch (err) {
      print("ERROR: AuthController: signUp()");
    }
  }

  Future<User> _registerUser(String id, String email, String pseudo, String password, bool isOrganizer) async {
    Map<String, dynamic> data = {
      "userId": id,
      "pseudo": pseudo,
      "mail": email,
      "isOrganizer": isOrganizer,
    };
    await _bddRepo.setUser(data);
    return User(id: id, mail: email, pseudo: pseudo, isOrganizer: isOrganizer);
  }
}
