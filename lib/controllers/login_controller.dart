import 'package:esgi_project/controllers/user_controller.dart';
import 'package:esgi_project/repositorys/firebase_auth_repository.dart';
import 'package:esgi_project/repositorys/firebase_firestore_repository.dart';
import 'package:get/get.dart';
import 'package:esgi_project/routes.dart';

class LoginController extends GetController {

  // sert a acceder a ce controller partout
  static LoginController get to => Get.put(LoginController());

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
      print("ERROR: LoginController: signin()");
    }
  }
}
