import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jiffy/jiffy.dart';

String parseDateTime(DateTime date, String regex) {
  return Jiffy(date).format(regex);
}

DateTime parseDateString(String date, String regex) {
  return Jiffy(date, regex).dateTime;//.utc();
}

Timestamp parseDateStringToTimestamp(String date, String regex) {
  return Timestamp.fromMillisecondsSinceEpoch(parseDateString(date, regex).millisecondsSinceEpoch);
}

Timestamp parseDateTimeToTimestamp(DateTime date) {
  return Timestamp.fromDate(date);
}

int differenceBWDateString(String date1, String date2, String regex) {
  return Jiffy(date1, regex).diff(Jiffy(date2, regex));
}


double calculateDistance(lat1, lon1, lat2, lon2) {
  var p = 0.017453292519943295;
  var c = cos;
  var a = 0.5 -
      c((lat2 - lat1) * p) / 2 +
      c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
  return 12742 * asin(sqrt(a));
}