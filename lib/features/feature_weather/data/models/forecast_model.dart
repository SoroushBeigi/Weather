
import 'package:weather/features/feature_weather/domain/entities/forecast_entity.dart';

class ForecastModel extends ForecastEntity{
  const ForecastModel({
      double? lat, 
      double? lon, 
      String? timezone, 
      int? timezoneOffset, 
      Current? current, 
      List<Daily>? daily, 
      List<Alerts>? alerts,}) : super(
    lat: lat,
    lon: lon,
    timezone: timezone,
    timezoneOffset: timezoneOffset,
    current: current,
    daily: daily,
    alerts: alerts
  );

  factory ForecastModel.fromJson(dynamic json) {

    /// convert daily from json
    List<Daily> daily = [];
    if (json['daily'] != null) {
      json['daily'].forEach((v) {
        daily.add(Daily.fromJson(v));
      });
    }
    List<Alerts> alerts = [];
    if (json['alerts'] != null) {
      json['alerts'].forEach((v) {
        alerts.add(Alerts.fromJson(v));
      });
    }

    return ForecastModel(
      lat: json['lat'].toDouble(),
      lon: json['lon'].toDouble(),
      timezone: json['timezone'],
      timezoneOffset: json['timezone_offset'],
      current: json['current'] != null ? Current.fromJson(json['current']) : null,
      daily: daily,
      alerts: alerts
    );


  }

}

class Alerts {
  Alerts({
      String? senderName, 
      String? event, 
      int? start, 
      int? end, 
      String? description, 
      List<String>? tags,}){
    _senderName = senderName;
    _event = event;
    _start = start;
    _end = end;
    _description = description;
    _tags = tags;
}

  Alerts.fromJson(dynamic json) {
    _senderName = json['sender_name'];
    _event = json['event'];
    _start = json['start'];
    _end = json['end'];
    _description = json['description'];
    _tags = json['tags'] != null ? json['tags'].cast<String>() : [];
  }
  String? _senderName;
  String? _event;
  int? _start;
  int? _end;
  String? _description;
  List<String>? _tags;

  String? get senderName => _senderName;
  String? get event => _event;
  int? get start => _start;
  int? get end => _end;
  String? get description => _description;
  List<String>? get tags => _tags;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['sender_name'] = _senderName;
    map['event'] = _event;
    map['start'] = _start;
    map['end'] = _end;
    map['description'] = _description;
    map['tags'] = _tags;
    return map;
  }

}


class Daily {
  Daily({
      int? dt,
      int? sunrise,
      int? sunset,
      int? moonrise, 
      int? moonset, 
      double? moonPhase, 
      Temp? temp, 
      FeelsLike? feelsLike, 
      int? pressure, 
      int? humidity, 
      double? dewPoint, 
      double? windSpeed, 
      int? windDeg, 
      double? windGust, 
      List<Weather>? weather, 
      int? clouds, 
      double? pop, 
      double? rain, 
      double? uvi,}){
    _dt = dt;
    _sunrise = sunrise;
    _sunset = sunset;
    _moonrise = moonrise;
    _moonset = moonset;
    _moonPhase = moonPhase;
    _temp = temp;
    _feelsLike = feelsLike;
    _pressure = pressure;
    _humidity = humidity;
    _dewPoint = dewPoint;
    _windSpeed = windSpeed;
    _windDeg = windDeg;
    _windGust = windGust;
    _weather = weather;
    _clouds = clouds;
    _pop = pop;
    _rain = rain;
    _uvi = uvi;
}

  Daily.fromJson(dynamic json) {
    _dt = json['dt'];
    _sunrise = json['sunrise'];
    _sunset = json['sunset'];
    _moonrise = json['moonrise'];
    _moonset = json['moonset'];
    _moonPhase = json['moon_phase'].toDouble();
    _temp = json['temp'] != null ? Temp.fromJson(json['temp']) : null;
    _feelsLike = json['feels_like'] != null ? FeelsLike.fromJson(json['feels_like']) : null;

    _pressure = json['pressure'];

    _humidity = json['humidity'];
    _dewPoint = json['dew_point'].toDouble();

    _windSpeed = json['wind_speed'].toDouble();
    _windDeg = json['wind_deg'];
    _windGust = json['wind_gust'].toDouble();
    if (json['weather'] != null) {
      _weather = [];
      json['weather'].forEach((v) {
        _weather?.add(Weather.fromJson(v));
      });
    }
    _clouds = json['clouds'];
    // _pop = json['pop'].toDouble();
    // _rain = json['rain'].toDouble();
    // _uvi = json['uvi'].toDouble();
  }
  int? _dt;
  int? _sunrise;
  int? _sunset;
  int? _moonrise;
  int? _moonset;
  double? _moonPhase;
  Temp? _temp;
  FeelsLike? _feelsLike;
  int? _pressure;
  int? _humidity;
  double? _dewPoint;
  double? _windSpeed;
  int? _windDeg;
  double? _windGust;
  List<Weather>? _weather;
  int? _clouds;
  double? _pop;
  double? _rain;
  double? _uvi;

  int? get dt => _dt;
  int? get sunrise => _sunrise;
  int? get sunset => _sunset;
  int? get moonrise => _moonrise;
  int? get moonset => _moonset;
  double? get moonPhase => _moonPhase;
  Temp? get temp => _temp;
  FeelsLike? get feelsLike => _feelsLike;
  int? get pressure => _pressure;
  int? get humidity => _humidity;
  double? get dewPoint => _dewPoint;
  double? get windSpeed => _windSpeed;
  int? get windDeg => _windDeg;
  double? get windGust => _windGust;
  List<Weather>? get weather => _weather;
  int? get clouds => _clouds;
  double? get pop => _pop;
  double? get rain => _rain;
  double? get uvi => _uvi;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['dt'] = _dt;
    map['sunrise'] = _sunrise;
    map['sunset'] = _sunset;
    map['moonrise'] = _moonrise;
    map['moonset'] = _moonset;
    map['moon_phase'] = _moonPhase;
    if (_temp != null) {
      map['temp'] = _temp?.toJson();
    }
    if (_feelsLike != null) {
      map['feels_like'] = _feelsLike?.toJson();
    }
    map['pressure'] = _pressure;
    map['humidity'] = _humidity;
    map['wind_speed'] = _windSpeed;
    map['wind_deg'] = _windDeg;
    map['wind_gust'] = _windGust;
    if (_weather != null) {
      map['weather'] = _weather?.map((v) => v.toJson()).toList();
    }
    map['clouds'] = _clouds;
    map['pop'] = _pop;
    map['rain'] = _rain;
    map['uvi'] = _uvi;
    return map;
  }

}

class Weather {
  Weather({
      int? id, 
      String? main, 
      String? description, 
      String? icon,}){
    _id = id;
    _main = main;
    _description = description;
    _icon = icon;
}

  Weather.fromJson(dynamic json) {
    _id = json['id'];
    _main = json['main'];
    _description = json['description'];
    _icon = json['icon'];
  }
  int? _id;
  String? _main;
  String? _description;
  String? _icon;

  int? get id => _id;
  String? get main => _main;
  String? get description => _description;
  String? get icon => _icon;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['main'] = _main;
    map['description'] = _description;
    map['icon'] = _icon;
    return map;
  }

}

class FeelsLike {
  FeelsLike({
      double? day, 
      double? night, 
      double? eve, 
      double? morn,}){
    _day = day;
    _night = night;
    _eve = eve;
    _morn = morn;
}

  FeelsLike.fromJson(dynamic json) {
    _day = json['day'].toDouble();
    _night = json['night'].toDouble();
    _eve = json['eve'].toDouble();
    _morn = json['morn'].toDouble();
  }
  double? _day;
  double? _night;
  double? _eve;
  double? _morn;

  double? get day => _day;
  double? get night => _night;
  double? get eve => _eve;
  double? get morn => _morn;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['day'] = _day;
    map['night'] = _night;
    map['eve'] = _eve;
    map['morn'] = _morn;
    return map;
  }

}

class Temp {
  Temp({
      double? day, 
      double? min, 
      double? max, 
      double? night, 
      double? eve, 
      double? morn,}){
    _day = day;
    _min = min;
    _max = max;
    _night = night;
    _eve = eve;
    _morn = morn;
}

  Temp.fromJson(dynamic json) {
    _day = json['day'].toDouble();
    _min = json['min'].toDouble();
    _max = json['max'].toDouble();
    _night = json['night'].toDouble();
    _eve = json['eve'].toDouble();
    _morn = json['morn'].toDouble();
  }
  double? _day;
  double? _min;
  double? _max;
  double? _night;
  double? _eve;
  double? _morn;

  double? get day => _day;
  double? get min => _min;
  double? get max => _max;
  double? get night => _night;
  double? get eve => _eve;
  double? get morn => _morn;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['day'] = _day;
    map['min'] = _min;
    map['max'] = _max;
    map['night'] = _night;
    map['eve'] = _eve;
    map['morn'] = _morn;
    return map;
  }

}

/// dt : 1654413279
/// sunrise : 1654392221
/// sunset : 1654451279
/// temp : 20.73
/// feels_like : 20.58
/// pressure : 1017
/// humidity : 66
/// dew_point : 14.15
/// uvi : 3.4
/// clouds : 99
/// visibility : 10000
/// wind_speed : 1.84
/// wind_deg : 31
/// wind_gust : 2.13
/// weather : [{"id":804,"main":"Clouds","description":"overcast clouds","icon":"04d"}]

class Current {
  Current({
      int? dt,
      int? sunrise,
      int? sunset,
      double? temp, 
      double? feelsLike, 
      int? pressure, 
      int? humidity, 
      double? dewPoint, 
      double? uvi, 
      int? clouds, 
      int? visibility, 
      double? windSpeed, 
      int? windDeg, 
      double? windGust, 
      List<Weather>? weather,}){
    _dt = dt;
    _sunrise = sunrise;
    _sunset = sunset;
    _temp = temp;
    _feelsLike = feelsLike;
    _pressure = pressure;
    _humidity = humidity;
    _dewPoint = dewPoint;
    _uvi = uvi;
    _clouds = clouds;
    _visibility = visibility;
    _windSpeed = windSpeed;
    _windDeg = windDeg;
    _windGust = windGust;
    _weather = weather;
}

  Current.fromJson(dynamic json) {
    _dt = json['dt'];
    _sunrise = json['sunrise'];
    _sunset = json['sunset'];
    _temp = json['temp'].toDouble();
    _feelsLike = json['feels_like'].toDouble();

    _pressure = json['pressure'];
    _humidity = json['humidity'];
    _dewPoint = json['dew_point'].toDouble();
    _uvi = json['uvi'].toDouble();
    _clouds = json['clouds'];
    _visibility = json['visibility'];

    _windSpeed = json['wind_speed'].toDouble();
    _windDeg = json['wind_deg'];
    // _windGust = json['wind_gust'].toDouble() ?? 0;

    if (json['weather'] != null) {
      _weather = [];
      json['weather'].forEach((v) {
        _weather?.add(Weather.fromJson(v));
      });
    }

  }
  int? _dt;
  int? _sunrise;
  int? _sunset;
  double? _temp;
  double? _feelsLike;
  int? _pressure;
  int? _humidity;
  double? _dewPoint;
  double? _uvi;
  int? _clouds;
  int? _visibility;
  double? _windSpeed;
  int? _windDeg;
  double? _windGust;
  List<Weather>? _weather;

  int? get dt => _dt;
  int? get sunrise => _sunrise;
  int? get sunset => _sunset;
  double? get temp => _temp;
  double? get feelsLike => _feelsLike;
  int? get pressure => _pressure;
  int? get humidity => _humidity;
  double? get dewPoint => _dewPoint;
  double? get uvi => _uvi;
  int? get clouds => _clouds;
  int? get visibility => _visibility;
  double? get windSpeed => _windSpeed;
  int? get windDeg => _windDeg;
  double? get windGust => _windGust;
  List<Weather>? get weather => _weather;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['dt'] = _dt;
    map['sunrise'] = _sunrise;
    map['sunset'] = _sunset;
    map['temp'] = _temp;
    map['feels_like'] = _feelsLike;
    map['pressure'] = _pressure;
    map['humidity'] = _humidity;
    // map['dew_point'] = _dewPoint;
    map['uvi'] = _uvi;
    map['clouds'] = _clouds;
    map['visibility'] = _visibility;
    map['wind_speed'] = _windSpeed;
    map['wind_deg'] = _windDeg;
    map['wind_gust'] = _windGust;
    if (_weather != null) {
      map['weather'] = _weather?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}