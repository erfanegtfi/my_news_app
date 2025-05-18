import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

class Utils {
  static final String _dateFormatter = "yyyy-MM-dd";
  static final String _dateTimeFormatter = "yyyy-MM-dd  HH:mm";

  static String getCurrentDate() {
    var now = DateTime.now();
    var formatter = DateFormat(_dateFormatter);
    return formatter.format(now);
  }

  static String getPassedDate(int day) {
    DateTime passed = DateTime.now().subtract(Duration(days: day));
    return DateFormat(_dateFormatter).format(passed);
  }

  static String formatDate(String? date) {
    if (date?.isNotEmpty == true) {
      try {
        DateTime dateTime = DateTime.parse(date!);
        return DateFormat(_dateTimeFormatter).format(dateTime);
      } catch (e) {
        debugPrint(e.toString());
      }
    }
    return "";
  }
}
