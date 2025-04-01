import 'package:intl/intl.dart';

class DatetimeCallback {
  static String formatDateTime(DateTime dateTime) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final tomorrow = today.add(Duration(days: 1));
    final targetDate = DateTime(dateTime.year, dateTime.month, dateTime.day);

    if (targetDate == today) {
      // Return time if today
      return DateFormat('h:mm a').format(dateTime);
    } else if (targetDate == tomorrow) {
      // Return "Tomorrow, time" if tomorrow
      return 'Tomorrow, ${DateFormat('h:mm a').format(dateTime)}';
    } else {
      // Return full date otherwise
      return DateFormat('MMMM d, yyyy').format(dateTime);
    }
  }
}
