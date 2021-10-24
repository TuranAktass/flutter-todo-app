import 'package:intl/intl.dart';

String dateFormat(String dateTime, bool withClock) {
  DateTime date = DateTime.parse(dateTime);
  if (withClock) {
    return DateFormat('yyyy-MM-dd \n kk:mm').format(date);
  }

  return DateFormat('yyyy-MM-dd').format(date);
}
