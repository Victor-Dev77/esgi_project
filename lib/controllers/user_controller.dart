import 'package:get/get.dart';
import 'package:esgi_project/models/user.dart';

class UserController extends GetController {

  static UserController get to => Get.find();

  User _user;
  User get user => this._user;
  set user(value) => this._user = value;


}