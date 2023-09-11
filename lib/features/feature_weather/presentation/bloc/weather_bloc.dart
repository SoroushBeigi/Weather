// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weather/core/params/forecast_params.dart';
import 'package:weather/core/recources/data_state.dart';
import 'package:weather/features/feature_weather/domain/usecases/get_forecast_usecase.dart';
import 'package:weather/features/feature_weather/domain/usecases/get_weather_usecase.dart';
import 'package:weather/features/feature_weather/presentation/bloc/current_weather_status.dart';
import 'package:weather/features/feature_weather/presentation/bloc/forecast_weather_status.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final GetWeatherUseCase getWeatherUseCase;
  final GetForecastUseCase getForecastUseCase;

  WeatherBloc({required this.getForecastUseCase, required this.getWeatherUseCase})
      : super(WeatherState(cwStatus: CWLoading(), fwStatus: FWLoading())) {

    on<LoadCurrentWEvent>((event, emit) async {
      emit(state.copyWith(newCWStatus: CWLoading()));
      DataState dataState = await getWeatherUseCase(event.cityname);

      if (dataState is DataSuccess) {
        emit(state.copyWith(newCWStatus: CWCompleted(dataState.data)));
      }
      if (dataState is DataFailed) {
        emit(state.copyWith(newCWStatus: CWError(dataState.error!)));
      }
    });

    on<LoadForecastEvent>((event, emit) async {
      emit(state.copyWith(newFWStatus: FWLoading()));
      DataState dataState = await getForecastUseCase(event.forecastParams);

      if (dataState is DataSuccess) {
        emit(state.copyWith(newFWStatus: FWCompleted(dataState.data)));
      }
      if (dataState is DataFailed) {
        emit(state.copyWith(newFWStatus: FWError(dataState.error!)));
      }
    });
  }
}
