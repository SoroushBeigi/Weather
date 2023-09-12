import 'package:weather/core/usecase/usecase.dart';
import 'package:weather/features/feature_weather/data/models/city_suggestion_model.dart';
import 'package:weather/features/feature_weather/domain/repository/weather_repository.dart';

class GetSuggestionUsecase extends UseCase<List<Data>, String> {
  final WeatherRepository weatherRepository;

  GetSuggestionUsecase({required this.weatherRepository});

  @override
  Future<List<Data>> call(String param) =>
      weatherRepository.fetchCitySuggestionData(param);
}
