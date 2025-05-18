import 'package:app_utils/utils.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';

void main() {
  group('Utils Date Tests', () {
    test('getCurrentDate returns today\'s date in yyyy-MM-dd format', () {
      final now = DateTime.now();
      final expected = DateFormat('yyyy-MM-dd').format(now);
      final result = Utils.getCurrentDate();
      expect(result, expected);
    });

    test('should return correct date when days are subtracted', () {
      expect(Utils.getPassedDate(1), equals('2025-05-17'));
      expect(Utils.getPassedDate(7), equals('2025-05-11'));
      expect(Utils.getPassedDate(30), equals('2025-04-18'));
    });

    test('should handle zero days', () {
      expect(Utils.getPassedDate(0), equals('2025-05-18'));
    });

    test('should handle negative days (adding days)', () {
      expect(Utils.getPassedDate(-1), equals('2025-05-19'));
    });

    test('should returns empty string for null input', () {
      final result = Utils.formatDate(null);
      expect(result, '');
    });

    test('should returns empty string for empty input', () {
      final result = Utils.formatDate('');
      expect(result, '');
    });

    test('formatDate returns empty string for invalid date string', () {
      final result = Utils.formatDate('invalid-date');
      expect(result, '');
    });
  });
}
