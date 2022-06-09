import 'package:intl/intl.dart';
import 'package:meteor/models/meteo_forecast.dart';

String readTimestampHour(MeteoForecast weather, int index) {
  DateTime date = DateTime.fromMillisecondsSinceEpoch(
      (weather.list![index].dt + weather.city!.timezone) * 1000,
      isUtc: true);
  return DateFormat('Hm').format(date);
}

String readTimestampHourClassic(
  int timestamp,
) {
  DateTime date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
  return DateFormat('Hm').format(date);
}

String readTimestampDay(int timestamp) {
  DateTime date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
  return DateFormat('EEEE').format(date);
}
