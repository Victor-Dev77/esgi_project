import 'package:esgi_project/utils/constant_color.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Constant {

  static final List<Map<String, dynamic>> category = [
      {
        "title": "Bar",
        "icon": FontAwesomeIcons.glassMartiniAlt,
      },
      {
        "title": "Discothèque",
        "icon": FontAwesomeIcons.compactDisc,
      },
      {
        "title": "Concert",
        "icon": FontAwesomeIcons.microphoneAlt,
      },
      {
        "title": "Festival",
        "icon": FontAwesomeIcons.music,
      },
      {
        "title": "Musée",
        "icon": FontAwesomeIcons.university,
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
