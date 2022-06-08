import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:meteor/services/customWeatherCast.dart';

import '../models/meteo.dart';
import 'package:http/http.dart' as http;

Future<Meteo> getMeteoData(String city) async {
  Meteo meteo = Meteo([], Main(0, 0, 0, 0, 0, 0), Wind(0, 0, 0), Clouds(0), 0,
      Sys(0, 0, "", 0, 0), 0, 0, "", 444);
  //https://jsonplaceholder.typicode.com/genre
  //https://api.openweathermap.org/data/2.5/weather?q=lyon&appid=a9cfd822e4f8f61c11082ab1d62a6fda

  var url = Uri.https('api.openweathermap.org', "/data/2.5/weather",
      {"q": city, "appid": "cc1fb0360be232be857c78980b1a88f8"});
  var response = await http.get(url);
  if (response.statusCode == 200) {
    var jsonResponse = jsonDecode(response.body);
    // List<Weather> listWeather = ConvertWeather(jsonResponse["weather"]);
    List weather = jsonResponse["weather"];
    Main mainConvert = Main.fromJson(jsonResponse["main"]);
    Wind windConvert = Wind.fromJson(jsonResponse["wind"]);
    Clouds cloudsConvert = Clouds.fromJson(jsonResponse["clouds"]);
    Sys sysConvert = Sys.fromJson(jsonResponse["sys"]);

    meteo = Meteo(
        customWeatherCast(weather),
        mainConvert,
        windConvert,
        cloudsConvert,
        jsonResponse["dt"],
        sysConvert,
        jsonResponse["id"],
        jsonResponse["timezone"],
        jsonResponse["name"],
        jsonResponse["cod"]);
  } else {
    if (kDebugMode) {
      print("Request failed with status: ${response.statusCode}");
    }
  }
  return meteo;
}
