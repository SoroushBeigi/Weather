import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weather/core/recources/data_state.dart';
import 'package:weather/features/feature_weather/domain/usecases/get_weather_usecase.dart';
import 'package:weather/features/feature_weather/presentation/bloc/current_weather_status.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {

  final GetWeatherUseCase getWeatherUseCase;

  WeatherBloc({required this.getWeatherUseCase}) : super(WeatherState(cwStatus: CWLoading())) { 

    on<LoadCurrentWEvent>((event, emit) async {

      emit(state.copyWith(newStatus: CWLoading()));
      DataState dataState = await getWeatherUseCase(event.cityname);

      if(dataState is DataSuccess){
        emit(state.copyWith(newStatus: CWCompleted(dataState.data)));
      }
      if(dataState is DataFailed){
        emit(state.copyWith(newStatus: CWError(dataState.error!)));
      }

    });
  }
}
