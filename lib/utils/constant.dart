import 'package:esgi_project/utils/constant_color.dart';
import 'package:flutter/material.dart';

class Constant {

  static final List<Map<String, dynamic>> category = [
      {
        "title": "Bar",
        "icon": Icons.local_drink,
      },
      {
        "title": "Discothèque",
        "icon": Icons.android,
      },
      {
        "title": "Concert",
        "icon": Icons.local_movies,
      },
      {
        "title": "Festival",
        "icon": Icons.android,
      },
      {
        "title": "Musée",
        "icon": Icons.local_movies,
      },
    ];

  // IMAGE
  static final String pathLogoImage = "assets/logo.png";

  // ICONS
  static final Icon homeIcon = Icon(
    Icons.home,
    size: 30,
    color: ConstantColor.white,
  );

  static final Icon mapIcon = Icon(
    Icons.map,
    size: 30,
    color: ConstantColor.white,
  );

  static final Icon addEventIcon = Icon(
    Icons.add,
    size: 30,
    color: ConstantColor.white,
  );

  static final Icon settingsIcon = Icon(
    Icons.settings,
    size: 30,
    color: ConstantColor.white,
  );

}
