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
