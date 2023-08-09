import 'package:dio/dio.dart';
import 'package:weather/core/utils/constants_private.dart';
import 'package:weather/core/utils/constants_public.dart';

/// We only get data in our data source and return JSON while using the clean architecture. 
/// "PrivateConstants" is in a class ignored by git to protect my own API key. 

class ApiProvider {
  final Dio _dio = Dio();
  final apiKey = PrivateConstants.apiKey;

  Future<dynamic> getCurrentWeather(cityName) async {
    final response =
        await _dio.get('${Constants.baseUrl}/data/2.5/weather', queryParameters: {
      'q': cityName,
      'appid': apiKey,
      'units': 'metric',
    });
    print(response.data);
    return response;
  }
}
