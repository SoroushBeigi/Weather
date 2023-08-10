import 'package:weather/core/recources/data_state.dart';
import 'package:weather/features/feature_weather/domain/entities/current_weather_entity.dart';

abstract class WeatherRepository{

  Future<DataState<CurrentWeatherEntity>> fetchCurrentWeather(String cityName);
}