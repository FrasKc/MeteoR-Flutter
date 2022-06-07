import 'package:intl/intl.dart';

String readTimestampHour(int timestamp) {
  DateTime date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
  return DateFormat('Hm').format(date);
}

String readTimestampDay(int timestamp) {
  DateTime date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
  return DateFormat('EEEE').format(date);
}
