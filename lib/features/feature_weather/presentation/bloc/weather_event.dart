part of 'weather_bloc.dart';

sealed class WeatherEvent extends Equatable {
  const WeatherEvent();

  @override
  List<Object> get props => [];
}

class LoadCurrentWEvent extends WeatherEvent{
  final String cityname;
  const LoadCurrentWEvent({required this.cityname});
}

class LoadForecastEvent extends WeatherEvent{
  final ForecastParams forecastParams;
  const LoadForecastEvent({required this.forecastParams});
}

class SuggestionCityEvent extends WeatherEvent{
  final String query;
  const SuggestionCityEvent({required this.query});
}
