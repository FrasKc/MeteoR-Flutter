import 'dart:convert';
import 'package:meteor/services/customListCast.dart';

import '../models/meteo_forecast.dart';
import 'package:http/http.dart' as http;

Future<Meteo_Forecast> getMeteoDetailsData(String city) async {
  Meteo_Forecast meteoDetail =
      Meteo_Forecast("444", 0, 0, [], City(0, "", Coord(), "", 0, 0, 0, 0));
  //https://jsonplaceholder.typicode.com/genre
  //https://api.openweathermap.org/data/2.5/weather?q=lyon&appid=a9cfd822e4f8f61c11082ab1d62a6fda

  var url = Uri.https('api.openweathermap.org', "/data/2.5/forecast",
      {"q": city, "appid": "a9cfd822e4f8f61c11082ab1d62a6fda"});
  var response = await http.get(url);
  if (response.statusCode == 200) {
    var jsonResponse = jsonDecode(response.body);

    City city = City.fromJson(jsonResponse["city"]);

    meteoDetail = Meteo_Forecast(jsonResponse["cod"], jsonResponse["message"],
        jsonResponse["cnt"], customListDetailCast(jsonResponse["list"]), city);
  } else {
    print("Error request failed with status: ${response.statusCode}");
  }
  return meteoDetail;
}
