import 'package:esgi_project/localization/localization.dart';
import 'package:esgi_project/utils/constant_color.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class Constant {
  static final List<Map<String, dynamic>> category = [
    {
      "title": Localization.barCategory.tr,
      "icon": FontAwesomeIcons.glassMartiniAlt,
    },
    {
      "title": Localization.nightClubCategory.tr,
      "icon": FontAwesomeIcons.compactDisc,
    },
    {
      "title": Localization.concertCategory.tr,
      "icon": FontAwesomeIcons.microphoneAlt,
    },
    {
      "title": Localization.festivalCategory.tr,
      "icon": FontAwesomeIcons.music,
    },
    {
      "title": Localization.museumCategory.tr,
      "icon": FontAwesomeIcons.university,
    },
  ];

  static final List<Locale> languages = [
    Locale("fr", "FR"),
    Locale("en", "US"),
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

  static final Icon dateIcon = Icon(Icons.date_range, color: Colors.orange);
  static final Icon dateIcon18 = Icon(Icons.date_range, color: Colors.orange, size: 18);

  static final Icon placeIcon = Icon(Icons.place, color: Colors.blueAccent);

  static final Icon locationOnIcon = Icon(Icons.location_on, color: Colors.orange, size: 18);

}
