// lib/core/utils/time_util.dart
import 'package:intl/intl.dart';

/// Date/time formatting utilities.
abstract final class TimeUtil {
  static String formatTime(DateTime time) {
    return DateFormat('HH:mm').format(time);
  }

  static String formatDate(DateTime time) {
    return DateFormat('EEE, MMM d').format(time);
  }

  static String formatFlipDigit(int digit) => digit.toString();

  static int hour12(DateTime time) {
    final h = time.hour % 12;
    return h == 0 ? 12 : h;
  }
}
