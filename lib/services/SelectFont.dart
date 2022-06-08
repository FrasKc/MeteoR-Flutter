import 'package:meteor/models/meteo.dart';
import 'package:meteor/services/TimeStampeToString.dart';

String SelectFond(Meteo weather) {
  print(weather.name);
  if (weather.sys.sunset < weather.dt) {
    print("nuit");
    return "assets/images/fondNight.gif";
  } else {
    switch (weather.weather[0].icon) {
      case "01d":
      case "02d":
        return "assets/images/fondSoleil.gif";
    }
  }
  return "";
}
