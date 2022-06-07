class Meteo {
  List<Weather> weather;
  Main main;
  Wind wind;
  Clouds clouds;
  int id;
  String name;

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
  late int id;
  late String main;
  late String description;
  late String icon;

  Weather(this.id, this.main, this.description, this.icon);

  Weather.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    main = json['main'];
    description = json['description'];
    icon = json['icon'];
  }
}

class Main {
  late double temp;
  late double feelsLike;
  late double tempMin;
  late double tempMax;
  late int pressure;
  late int humidity;

  Main(this.temp, this.feelsLike, this.tempMin, this.tempMax, this.pressure,
      this.humidity);

  Main.fromJson(Map<String, dynamic> json) {
    temp = json['temp'].toDouble();
    feelsLike = json['feels_like'].toDouble();
    tempMin = json['temp_min'].toDouble();
    tempMax = json['temp_max'].toDouble();
    pressure = json['pressure'];
    humidity = json['humidity'];
  }
}

class Wind {
  late double speed;
  late int deg;
  late double gust;

  Wind(this.speed, this.deg, this.gust);

  Wind.fromJson(Map<String, dynamic> json) {
    speed = json['speed'];
    deg = json['deg'];
    gust = json['gust'];
  }
}

class Clouds {
  late int all;

  Clouds(this.all);

  Clouds.fromJson(Map<String, dynamic> json) {
    all = json['all'];
  }
}
