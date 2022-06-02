import 'package:meteor/models/meteo_forecast.dart';
import 'package:meteor/services/customWeatherDetailCast.dart';

List<Liste> customListDetailCast(List<dynamic> liste) {
  List<Liste> ListeList = [];
  for (dynamic object in liste) {
    Liste list = Liste(
      object["dt"],
      Main.fromJson(object["main"]),
      customWeatherDetailsCast(object["weather"]),
      Clouds.fromJson(object["clouds"]),
      Wind.fromJson(object["wind"]),
      object["visibility"],
      object["pop"].toDouble(),
      Sys.fromJson(object["sys"]),
      object["dt_txt"],
      object['rain'] != null ? new Rain.fromJson(object['rain']) : null,
    );
    ListeList.add(list);
  }
  return ListeList;
}
