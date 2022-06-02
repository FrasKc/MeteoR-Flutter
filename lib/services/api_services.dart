import 'dart:convert';
import '../models/meteo.dart';
import 'package:http/http.dart' as http;

Future<Meteo> getMeteoData(String city) async {
  Meteo meteo =
      Meteo([], Main(0, 0, 0, 0, 0, 0), Wind(0, 0, 0), Clouds(0), 0, "");
  //https://jsonplaceholder.typicode.com/genre
  //https://api.openweathermap.org/data/2.5/weather?q=lyon&appid=a9cfd822e4f8f61c11082ab1d62a6fda

  var url = Uri.https('api.openweathermap.org', "/data/2.5/weather",
      {"q": city, "appid": "a9cfd822e4f8f61c11082ab1d62a6fda"});
  var response = await http.get(url);
  if (response.statusCode == 200) {
    var jsonResponse = jsonDecode(response.body);
    // List<Weather> listWeather = ConvertWeather(jsonResponse["weather"]);
    List weather = jsonResponse["weather"];
    Main mainConvert = Main.fromJson(jsonResponse["main"]);
    Wind windConvert = Wind.fromJson(jsonResponse["wind"]);
    Clouds cloudsConvert = Clouds.fromJson(jsonResponse["clouds"]);

    meteo = Meteo(customCast(weather), mainConvert, windConvert, cloudsConvert,
        jsonResponse["id"], jsonResponse["name"]);
  } else {
    print("Miam request failed with status: ${response.statusCode}");
  }
  return meteo;
}

List<Weather> customCast(List<dynamic> weather) {
  List<Weather> weatherList = [];
  for (dynamic object in weather) {
    Weather weather = Weather(
        object["id"], object["main"], object["description"], object["icon"]);
    weatherList.add(weather);
  }
  return weatherList;
}
