import 'package:esgi_project/controllers/auth_controller.dart';
import 'package:esgi_project/controllers/user_controller.dart';
import 'package:get/get.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(UserController());
    Get.put(AuthController());
  }
}