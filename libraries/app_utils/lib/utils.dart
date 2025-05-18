import 'package:intl/intl.dart';

class Utils {
  static String _dateFormatter = "yyyy-MM-dd";

  static String getCurrentDate() {
    var now = DateTime.now();
    var formatter = DateFormat(_dateFormatter);
    return formatter.format(now);
  }

  static String getPassedDate(int day) {
    DateTime passed = DateTime.now().subtract(Duration(days: day));
    return DateFormat(_dateFormatter).format(passed);
  }
}
