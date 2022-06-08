class Meteo {
  List<Weather> weather;
  Main main;
  Wind wind;
  Clouds clouds;
  int dt;
  Sys sys;
  int id;
  int timeZone;
  String name;
  int cod;

  Meteo(
    this.weather,
    this.main,
    this.wind,
    this.clouds,
    this.dt,
    this.sys,
    this.id,
    this.timeZone,
    this.name,
    this.cod,
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

class Sys {
  late int type;
  late int id;
  late String country;
  late int sunrise;
  late int sunset;

  Sys(this.type, this.id, this.country, this.sunrise, this.sunset);

  Sys.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    id = json['id'];
    country = json['country'];
    sunrise = json['sunrise'];
    sunset = json['sunset'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['id'] = this.id;
    data['country'] = this.country;
    data['sunrise'] = this.sunrise;
    data['sunset'] = this.sunset;
    return data;
  }
}
