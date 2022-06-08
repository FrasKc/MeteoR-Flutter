import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:meteor/services/customListCast.dart';

import '../models/meteo_forecast.dart';
import 'package:http/http.dart' as http;

Future<MeteoForecast> getMeteoDetailsData(String city) async {
  MeteoForecast meteoDetail =
      MeteoForecast("444", 0, 0, [], City(0, "", Coord(), "", 0, 0, 0, 0));
  //https://jsonplaceholder.typicode.com/genre
  //https://api.openweathermap.org/data/2.5/weather?q=lyon&appid=a9cfd822e4f8f61c11082ab1d62a6fda

  var url = Uri.https('api.openweathermap.org', "/data/2.5/forecast",
      {"q": city, "appid": "a9cfd822e4f8f61c11082ab1d62a6fda"});
  var response = await http.get(url);
  if (response.statusCode == 200) {
    var jsonResponse = jsonDecode(response.body);

    City city = City.fromJson(jsonResponse["city"]);

    meteoDetail = MeteoForecast(jsonResponse["cod"], jsonResponse["message"],
        jsonResponse["cnt"], customListDetailCast(jsonResponse["list"]), city);
  } else {
    if (kDebugMode) {
      print("Error request failed with status: ${response.statusCode}");
    }
  }
  return meteoDetail;
}
