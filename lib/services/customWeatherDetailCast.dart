import 'package:meteor/models/meteo_forecast.dart';

List<Weather> customWeatherDetailsCast(List<dynamic> weather) {
  List<Weather> weatherList = [];
  for (dynamic object in weather) {
    Weather weather = Weather(
        object["id"], object["main"], object["description"], object["icon"]);
    weatherList.add(weather);
  }
  return weatherList;
}
