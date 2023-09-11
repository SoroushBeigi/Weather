import 'package:dio/dio.dart';
import 'package:weather/core/params/forecast_params.dart';
import 'package:weather/core/utils/constants_private.dart';
import 'package:weather/core/utils/constants_public.dart';

/// We only get data in our data source and return JSON while using the clean architecture.
/// "PrivateConstants" is in a class ignored by git to protect my own API key.

class ApiProvider {
  final Dio _dio = Dio();
  final apiKey = PrivateConstants.apiKey;

  Future<dynamic> getCurrentWeather(cityName) async {

    final response = await _dio
        .get('${Constants.baseUrl}/data/2.5/weather', queryParameters: {
      'q': cityName,
      'appid': apiKey,
      'units': 'metric',
    });

    return response;
  }

  Future<dynamic> getWeeklyForecast(ForecastParams params) async {

    // final response = await _dio.get(
    //   '${Constants.baseUrl}/data/2.5/onecall',
    //   queryParameters: {
    //     'lat': params.lat,
    //     'lon': params.long,
    //     'exclude': 'minutely,hourly',
    //     'appid': apiKey,
    //     'units': 'metric'
    //   },
    // );
      var response = await _dio.get(
        "${Constants.baseUrl}/data/2.5/onecall",
        queryParameters: {
          'lat': params.lat,
          'lon': params.lon,
          'exclude': 'minutely,hourly',
          'appid': apiKey,
          'units': 'metric'
        },
        );
      
    return response;
  }
}
