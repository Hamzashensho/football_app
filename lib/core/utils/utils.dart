import 'package:intl/intl.dart';

class Utils{
  static String formatDateToTodayOrYesterday(DateTime date) {
    final now = DateTime.now();
    if (date.year == now.year && date.month == now.month && date.day == now.day) {
      return "Today";
    } else if (date.year == now.year && date.month == now.month && date.day == now.day - 1) {
      return "Yesterday";
    } else {
      return DateFormat('dd/MM/yyyy').format(date);
    }
}

}
