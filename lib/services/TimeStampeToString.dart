import 'package:intl/intl.dart';

String readTimestamp(int timestamp) {
  DateTime date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);

  return DateFormat('Hm').format(date);
}
