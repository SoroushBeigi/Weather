import 'package:weather/core/params/forecast_params.dart';
import 'package:weather/core/recources/data_state.dart';
import 'package:weather/core/usecase/usecase.dart';
import 'package:weather/features/feature_weather/domain/entities/forecast_entity.dart';
import 'package:weather/features/feature_weather/domain/repository/weather_repository.dart';

class GetForecastUseCase extends UseCase <DataState<ForecastEntity>,ForecastParams>{
  final WeatherRepository weatherRepository;

  GetForecastUseCase({required this.weatherRepository});
  
  @override
  Future<DataState<ForecastEntity>> call(ForecastParams param) {
      return weatherRepository.fetchForecastWeather(param);
  }


}
