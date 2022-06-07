import 'package:meteor/models/meteo_forecast.dart';
import 'package:meteor/services/TimeStampeToString.dart';

List<Liste> daysFilter(List<Liste> list) {
  late List<Liste> resultListe = [];
  late List<String> semiResult = [];
  for (Liste data in list) {
    if (semiResult.contains(readTimestampDay(data.dt)) == false) {
      semiResult.add(readTimestampDay(data.dt));
      resultListe.add(data);
      print(readTimestampDay(data.dt));
    }
  }
  return resultListe;
}
