import 'package:esgi_project/localization/localization.dart';
import 'package:esgi_project/utils/constant_color.dart';
import 'package:esgi_project/utils/functions.dart';
import 'package:esgi_project/utils/snackbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectDate {

  static Future<String> show(
      TextEditingController editingController, {String beginDate: "", String endDate: ""}) async {
    if (GetPlatform.isAndroid) {
      String date = await _selectDateAndroid(beginDate: beginDate, endDate: endDate);
      if (date != null) {
        editingController.text = date;
        return date;
      }
    } else if (GetPlatform.isIOS) {
      String date = await _selectDateIOS(beginDate: beginDate, endDate: endDate, callback: (date) {
        editingController.text = date;
        return date;
      });
      editingController.text = date;
      return date;
    }
    return null;
  }

  static Future<String> _selectDateAndroid({String beginDate: "", String endDate: ""}) async {
    final now = DateTime.now();
    final DateTime picked = await showDatePicker(
      context: Get.overlayContext,
      initialDate: now,
      firstDate: now,
      lastDate: DateTime(now.year + 1, now.month, now.day),
      locale: Locale('fr', 'FR'),
    );
    if (picked != null) {
      DateTime date = picked.toLocal();
      date = _checkDate(date, beginDate, endDate);
      if (date == null)
        return "";
      TimeOfDay time = await _selectTime();
      date = date.add(Duration(hours: time.hour, minutes: time.minute));
      date = _checkDate(date, beginDate, endDate, addingHour: false);
      if (date == null)
        return "";
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

  static Future<String> _selectDateIOS({String beginDate: "", String endDate: "", @required Function(String) callback}) async {
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
              final dateRes = _checkDate(date, beginDate, endDate, addingHour: false);
              if (dateRes == null)
                callback("");
              else 
                callback(parseDateTime(dateRes.toLocal(), 'dd/MM/yyyy HH:mm'));
            },
          ),
        ),
        isDismissible: true);
    return parseDateTime(now.toLocal(), 'dd/MM/yyyy HH:mm');
  }

  static DateTime _checkDate(DateTime date, String beginDate, String endDate, {bool addingHour: true}) {
    if (beginDate != null && beginDate != "") {
      final dateBegin = parseDateString(beginDate, "dd/MM/yyyy HH:mm");
      final dateWithHour = addingHour ? date.add(Duration(hours: dateBegin.hour, minutes: dateBegin.minute)) : date;
      int diff = differenceBWDateString(parseDateTime(dateBegin.toLocal(), 'dd/MM/yyyy HH:mm'), parseDateTime(dateWithHour.toLocal(), 'dd/MM/yyyy HH:mm'), 'dd/MM/yyyy HH:mm');
      if (diff > 0) {
        CustomSnackbar.snackbar(Localization.errorDateEndNoHighThanDateBegin.tr);
        return null;
      }
    }
    if (endDate != null && endDate != "") {
      final dateBegin = parseDateString(endDate, "dd/MM/yyyy HH:mm");
      final dateWithHour = addingHour ? date.add(Duration(hours: dateBegin.hour, minutes: dateBegin.minute)) : date;
      int diff = differenceBWDateString(parseDateTime(dateBegin.toLocal(), 'dd/MM/yyyy HH:mm'), parseDateTime(dateWithHour.toLocal(), 'dd/MM/yyyy HH:mm'), 'dd/MM/yyyy HH:mm');
      if (diff < 0) {
        CustomSnackbar.snackbar(Localization.errorDateBeginNoLessThanDateEnd.tr);
        return null;
      }
    }
    return date;
  } 

}