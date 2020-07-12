
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomSnackbar {

  static snackbar(String text) {
    Get.snackbar(text, "", snackPosition: SnackPosition.BOTTOM, colorText: Colors.grey[300]);
  }

}