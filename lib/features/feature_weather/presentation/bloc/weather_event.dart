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
