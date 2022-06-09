import 'package:meteor/models/meteo.dart';

String selectFond(Meteo weather) {
  DateTime lever = DateTime.fromMillisecondsSinceEpoch(
      (weather.sys.sunrise + weather.timeZone) * 1000,
      isUtc: true);
  DateTime coucher = DateTime.fromMillisecondsSinceEpoch(
      (weather.sys.sunset + weather.timeZone) * 1000,
      isUtc: true);
  DateTime actuel = DateTime.fromMillisecondsSinceEpoch(
      (weather.dt + weather.timeZone) * 1000,
      isUtc: true);

  if (coucher.hour > actuel.hour && actuel.hour > lever.hour) {
    switch (weather.weather[0].icon) {
      case "01d":
      case "02d":
        return "assets/images/fondSoleil.gif";
      case "03d":
      case "04d":
        return "assets/images/fondCloud.gif";
      case "09d":
      case "10d":
      case "11d":
        return "assets/images/fondPluie.gif";
    }
  } else {
    return "assets/images/fondNight.gif";
  }
  return "assets/images/orage.jpg";
}
