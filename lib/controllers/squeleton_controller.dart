import 'package:esgi_project/controllers/add_event_controller.dart';
import 'package:esgi_project/controllers/user_controller.dart';
import 'package:esgi_project/screens/add_event.dart';
import 'package:esgi_project/screens/home.dart';
import 'package:esgi_project/screens/map_page.dart';
import 'package:esgi_project/screens/settings.dart';
import 'package:esgi_project/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SqueletonController extends GetxController {
  static SqueletonController get to => Get.find();

  List<Widget> _tabMenu;
  List<Widget> get tabMenu => this._tabMenu;

  List<Widget> _listItemNav;
  List<Widget> get listItemNav => this._listItemNav;

  @override
  void onInit() {
    super.onInit();
    _tabMenu = [Home(), MapPage(), Settings()];
    _listItemNav = [Constant.homeIcon, Constant.mapIcon, Constant.settingsIcon];
    if (UserController.to.user.isOrganizer) {
      _tabMenu.insert(2, AddEvent());
      _listItemNav.insert(2, Constant.addEventIcon);
      Get.put(AddEventController());
    }
  }
}
