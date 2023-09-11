import 'package:dio/dio.dart';
import 'package:weather/core/params/forecast_params.dart';
import 'package:weather/core/recources/data_state.dart';
import 'package:weather/features/feature_weather/data/data_source/remote/api_provider.dart';
import 'package:weather/features/feature_weather/data/models/current_weather_model.dart';
import 'package:weather/features/feature_weather/data/models/forecast_model.dart';
import 'package:weather/features/feature_weather/domain/entities/current_weather_entity.dart';
import 'package:weather/features/feature_weather/domain/entities/forecast_entity.dart';
import 'package:weather/features/feature_weather/domain/repository/weather_repository.dart';

class WeatherRepositoryImplementation extends WeatherRepository {
  ApiProvider apiProvider;
  WeatherRepositoryImplementation({required this.apiProvider});


  @override
  Future<DataState<CurrentWeatherEntity>> fetchCurrentWeather(String cityName) async {
    try {
      Response response = await apiProvider.getCurrentWeather(cityName); 
      if(response.statusCode==200){
        CurrentWeatherEntity currentWeatherEntity = CurrentWeatherModel.fromJson(response.data);
        return DataSuccess(currentWeatherEntity);
      }else{
        return const DataFailed("Something went wrong, try again!");
      }
    } catch (e) {
      return const DataFailed("Connection Error!");
    }
  }

  @override
  Future<DataState<ForecastEntity>> fetchForecastWeather(ForecastParams params) async {
       try {
      Response response = await apiProvider.getWeeklyForecast(params); 
      if(response.statusCode==200){
        ForecastEntity forecastEntity = ForecastModel.fromJson(response.data);
        return DataSuccess(forecastEntity);
      }else{
        return const DataFailed("Something went wrong, try again!");
      }
    } catch (e) {
      return const DataFailed("Connection Error!");
    }
  }
}
