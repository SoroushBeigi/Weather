part of 'weather_bloc.dart';

class WeatherState{
  final CWStatus cwStatus;

  WeatherState({required this.cwStatus});

  WeatherState copyWith({CWStatus? newStatus}){
    return WeatherState(cwStatus: newStatus ?? this.cwStatus);
  }
}
