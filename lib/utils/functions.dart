import 'package:jiffy/jiffy.dart';

String parseDateTime(DateTime date, String regex) {
  return Jiffy(date).format(regex);
}