import 'dart:convert';

import '../models/meteo.dart';
import 'package:http/http.dart' as http;

Future<Meteo> getMeteoData() async {
  Meteo meteo = Meteo([], Main(), Wind(), Clouds(), 0, "");
  //https://jsonplaceholder.typicode.com/genre
  //https://api.openweathermap.org/data/2.5/weather?q=lyon&appid=a9cfd822e4f8f61c11082ab1d62a6fda

  var url = Uri.https('api.openweathermap.org', "/data/2.5/weather",
      {"q": "lyon", "appid": "a9cfd822e4f8f61c11082ab1d62a6fda"});
  var response = await http.get(url);
  if (response.statusCode == 200) {
    var jsonResponse = jsonDecode(response.body);
    meteo = Meteo(
        jsonResponse["weather"],
        jsonResponse["main"],
        jsonResponse["wind"],
        jsonResponse["clouds"],
        jsonResponse["id"],
        jsonResponse["name"]);
  } else {
    print("Miam request failed with status: ${response.statusCode}");
  }
  return meteo;
}
