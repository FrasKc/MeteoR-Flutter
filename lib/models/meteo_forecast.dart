class MeteoForecast {
  String? cod;
  int? message;
  int? cnt;
  List<Liste>? list;
  City? city;

  MeteoForecast(this.cod, this.message, this.cnt, this.list, this.city);
}

class Liste {
  late int dt;
  late Main main;
  late List<Weather> weather;
  late Clouds clouds;
  late Wind wind;
  late int visibility;
  late double pop;
  late Rain? rain;
  late Sys sys;
  late String dtTxt;

  Liste(this.dt, this.main, this.weather, this.clouds, this.wind,
      this.visibility, this.pop, this.sys, this.dtTxt,
      [this.rain]);

  Liste.fromJson(Map<String, dynamic> json) {
    dt = json['dt'];
    main = (json['main'] != null ? Main.fromJson(json['main']) : null)!;
    if (json['weather'] != null) {
      weather = <Weather>[];
      json['weather'].forEach((v) {
        weather.add(Weather.fromJson(v));
      });
    }
    clouds = (json['clouds'] != null ? Clouds.fromJson(json['clouds']) : null)!;
    wind = (json['wind'] != null ? Wind.fromJson(json['wind']) : null)!;
    visibility = json['visibility'];
    pop = json['pop'];
    rain = (json['rain'] != null ? Rain.fromJson(json['rain']) : null)!;
    sys = (json['sys'] != null ? Sys.fromJson(json['sys']) : null)!;
    dtTxt = json['dt_txt'];
  }
}

class Main {
  late double temp;
  late double feelsLike;
  late double tempMin;
  late double tempMax;
  late int pressure;
  late int seaLevel;
  late int grndLevel;
  late int humidity;
  late double tempKf;

  Main(this.temp, this.feelsLike, this.tempMin, this.tempMax, this.pressure,
      this.seaLevel, this.grndLevel, this.humidity, this.tempKf);

  Main.fromJson(Map<String, dynamic> json) {
    temp = json['temp'].toDouble();
    feelsLike = json['feels_like'].toDouble();
    tempMin = json['temp_min'].toDouble();
    tempMax = json['temp_max'].toDouble();
    pressure = json['pressure'];
    seaLevel = json['sea_level'];
    grndLevel = json['grnd_level'];
    humidity = json['humidity'];
    tempKf = json['temp_kf'].toDouble();
  }
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

class Clouds {
  int? all;

  Clouds({this.all});

  Clouds.fromJson(Map<String, dynamic> json) {
    all = json['all'];
  }
}

class Wind {
  double? speed;
  int? deg;
  double? gust;

  Wind({this.speed, this.deg, this.gust});

  Wind.fromJson(Map<String, dynamic> json) {
    speed = json['speed'].toDouble();
    deg = json['deg'];
    gust = json['gust'].toDouble();
  }
}

class Rain {
  double? d3h;

  Rain({this.d3h});

  Rain.fromJson(Map<String, dynamic> json) {
    d3h = json['3h'].toDouble();
  }
}

class Sys {
  String? pod;

  Sys({this.pod});

  Sys.fromJson(Map<String, dynamic> json) {
    pod = json['pod'];
  }
}

class City {
  late int id;
  late String name;
  late Coord coord;
  late String country;
  late int population;
  late int timezone;
  late int sunrise;
  late int sunset;

  City(this.id, this.name, this.coord, this.country, this.population,
      this.timezone, this.sunrise, this.sunset);

  City.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    coord = (json['coord'] != null ? Coord.fromJson(json['coord']) : null)!;
    country = json['country'];
    population = json['population'];
    timezone = json['timezone'];
    sunrise = json['sunrise'];
    sunset = json['sunset'];
  }
}

class Coord {
  double? lat;
  double? lon;

  Coord({this.lat, this.lon});

  Coord.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lon = json['lon'];
  }
}
