import 'package:esgi_project/utils/constant_color.dart';
import 'package:esgi_project/utils/functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectDate {

  static Future<String> show(
      TextEditingController editingController) async {
    if (GetPlatform.isAndroid) {
      String date = await _selectDateAndroid();
      if (date != null) {
        editingController.text = date;
        return date;
      }
    } else if (GetPlatform.isIOS) {
      String date = await _selectDateIOS(callback: (date) {
        editingController.text = date;
        return date;
      });
      editingController.text = date;
      return date;
    }
    return null;
  }

  static Future<String> _selectDateAndroid() async {
    final now = DateTime.now();
    final DateTime picked = await showDatePicker(
      context: Get.overlayContext,
      initialDate: now,
      firstDate: now,
      lastDate: DateTime(now.year + 1, now.month, now.day),
      locale: Locale('fr', 'FR'),
    );
    if (picked != null) {
      TimeOfDay time = await _selectTime();
      DateTime date = picked
          .toLocal()
          .add(Duration(hours: time.hour, minutes: time.minute));
      return parseDateTime(date.toLocal(), 'dd/MM/yyyy HH:mm');
    }
    return null;
  }

  static Future<TimeOfDay> _selectTime() async {
    TimeOfDay t = await showTimePicker(
        context: Get.overlayContext, initialTime: TimeOfDay.now());
    if (t != null) return t;
    return TimeOfDay.now();
  }

  static Future<String> _selectDateIOS({@required Function(String) callback}) async {
    final now = DateTime.now();
    Get.bottomSheet(
        SizedBox(
          height: 250,
          child: CupertinoDatePicker(
            initialDateTime: now,
            minimumDate: now,
            maximumDate: DateTime(now.year + 1, now.month, now.day),
            use24hFormat: true,
            backgroundColor: ConstantColor.white,
            onDateTimeChanged: (date) {
               callback(parseDateTime(date.toLocal(), 'dd/MM/yyyy HH:mm'));
             // return parseDateTime(date.toLocal(), 'dd/MM/yyyy HH:mm');
            },
          ),
        ),
        isDismissible: true);
    return parseDateTime(now.toLocal(), 'dd/MM/yyyy HH:mm');
  }
}