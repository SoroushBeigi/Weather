import 'package:flutter/material.dart';
import 'package:weather/core/widgets/main_wrapper.dart';
import 'package:weather/features/feature_weather/data/data_source/remote/api_provider.dart';
import 'package:weather/features/feature_weather/data/repository/weather_repository_impl.dart';
import 'package:weather/features/feature_weather/domain/usecases/get_weather_usecase.dart';
import 'package:weather/injections.dart';

void main() async {

  //Calling GetIt Setup
  await setup();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    GetWeatherUseCase getWeatherUseCase  = GetWeatherUseCase(weatherRepository: WeatherRepositoryImplementation(apiProvider: ApiProvider()));
    getWeatherUseCase('tehran');
    return const MaterialApp(
      home: MainWrapper(),
    );
  }
}

