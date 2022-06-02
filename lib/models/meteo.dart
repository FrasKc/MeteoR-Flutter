class Meteo {
  List<Weather>? weather;
  Main? main;
  Wind? wind;
  Clouds? clouds;
  int? id;
  String? name;

  Meteo(
    this.weather,
    this.main,
    this.wind,
    this.clouds,
    this.id,
    this.name,
  );
}

class Weather {
  int? id;
  String? main;
  String? description;
  String? icon;

  Weather({this.id, this.main, this.description, this.icon});
}

class Main {
  double? temp;
  double? feelsLike;
  double? tempMin;
  double? tempMax;
  int? pressure;
  int? humidity;

  Main(
      {this.temp,
      this.feelsLike,
      this.tempMin,
      this.tempMax,
      this.pressure,
      this.humidity});
}

class Wind {
  double? speed;
  int? deg;
  double? gust;

  Wind({this.speed, this.deg, this.gust});
}

class Clouds {
  int? all;

  Clouds({this.all});
}
