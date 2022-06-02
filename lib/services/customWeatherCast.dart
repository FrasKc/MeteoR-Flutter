import 'package:meteor/models/meteo.dart';

List<Weather> customWeatherCast(List<dynamic> weather) {
  List<Weather> weatherList = [];
  for (dynamic object in weather) {
    Weather weather = Weather(
        object["id"], object["main"], object["description"], object["icon"]);
    weatherList.add(weather);
  }
  return weatherList;
}
