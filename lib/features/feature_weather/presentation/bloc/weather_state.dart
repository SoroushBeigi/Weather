part of 'weather_bloc.dart';

class WeatherState extends Equatable {
  final CWStatus cwStatus;
  final FWStatus fwStatus;

  const WeatherState({required this.cwStatus, required this.fwStatus});

  WeatherState copyWith({CWStatus? newCWStatus, FWStatus? newFWStatus}) {
    return WeatherState(
      cwStatus: newCWStatus ?? cwStatus,
      fwStatus: newFWStatus ?? fwStatus,
    );
  }

  @override
  List<Object?> get props => [cwStatus, fwStatus];
}
