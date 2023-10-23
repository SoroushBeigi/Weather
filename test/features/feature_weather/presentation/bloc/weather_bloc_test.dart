import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:weather/core/recources/data_state.dart';
import 'package:weather/features/feature_weather/domain/entities/current_weather_entity.dart';
import 'package:weather/features/feature_weather/domain/usecases/get_forecast_usecase.dart';
import 'package:weather/features/feature_weather/domain/usecases/get_weather_usecase.dart';
import 'package:weather/features/feature_weather/presentation/bloc/current_weather_status.dart';
import 'package:weather/features/feature_weather/presentation/bloc/forecast_weather_status.dart';
import 'package:weather/features/feature_weather/presentation/bloc/weather_bloc.dart';

import 'weather_bloc_test.mocks.dart';

@GenerateMocks([GetForecastUseCase, GetWeatherUseCase])
void main() {
  String cityname = 'Tehran';
  MockGetWeatherUseCase mockGetWeatherUseCase = MockGetWeatherUseCase();
  MockGetForecastUseCase mockGetForecastUseCase = MockGetForecastUseCase();

  group('Current weather event test', () {
    blocTest<WeatherBloc, WeatherState>(
      'Weather bloc test to see loading and completed states',
      build: () => WeatherBloc(
          getForecastUseCase: mockGetForecastUseCase,
          getWeatherUseCase: mockGetWeatherUseCase),
      act: (bloc) {
        when(mockGetWeatherUseCase.call(cityname)).thenAnswer(
            (realInvocation) async =>
                Future.value(const DataSuccess(CurrentWeatherEntity())));
        bloc.add(LoadCurrentWEvent(cityname: cityname));
      },
      expect: () => <WeatherState>[
        WeatherState(cwStatus: CWLoading(), fwStatus: FWLoading()),
        WeatherState(
            cwStatus: CWCompleted(const CurrentWeatherEntity()),
            fwStatus: FWLoading())
      ],
    );
    blocTest<WeatherBloc, WeatherState>(
      'Weather bloc test to see error state',
      build: () => WeatherBloc(
          getForecastUseCase: mockGetForecastUseCase,
          getWeatherUseCase: mockGetWeatherUseCase),
      act: (bloc) {
        when(mockGetWeatherUseCase.call(cityname)).thenAnswer(
            (realInvocation) async => Future.value(
                const DataFailed("Something went wrong, try again!")));
        bloc.add(LoadCurrentWEvent(cityname: cityname));
      },
      expect: () => <WeatherState>[
        WeatherState(cwStatus: CWLoading(), fwStatus: FWLoading()),
        WeatherState(
            cwStatus: CWError("Something went wrong, try again!"),
            fwStatus: FWLoading())
      ],
    );

  });
}
