import 'package:weather/core/recources/data_state.dart';
import 'package:weather/core/usecase/usecase.dart';
import 'package:weather/features/feature_weather/domain/entities/current_weather_entity.dart';
import 'package:weather/features/feature_weather/domain/repository/weather_repository.dart';

class GetWeatherUseCase extends UseCase <DataState<CurrentWeatherEntity>,String>{
  final WeatherRepository weatherRepository;

  GetWeatherUseCase(this.weatherRepository);
  
  @override
  Future<DataState<CurrentWeatherEntity>> call(String param) {
      return weatherRepository.fetchCurrentWeather(param);
  }


}
