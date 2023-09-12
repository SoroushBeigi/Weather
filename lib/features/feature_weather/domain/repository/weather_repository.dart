import 'package:weather/core/params/forecast_params.dart';
import 'package:weather/core/recources/data_state.dart';
import 'package:weather/features/feature_weather/data/models/city_suggestion_model.dart';
import 'package:weather/features/feature_weather/domain/entities/current_weather_entity.dart';
import 'package:weather/features/feature_weather/domain/entities/forecast_entity.dart';

abstract class WeatherRepository{

  Future<DataState<CurrentWeatherEntity>> fetchCurrentWeatherData(String cityName);
  Future<DataState<ForecastEntity>> fetchForecastWeatherData(ForecastParams params);
  Future<List<Data>> fetchCitySuggestionData(String query);
}