import 'package:weather/core/recources/data_state.dart';
import 'package:weather/core/usecase/usecase.dart';
import 'package:weather/features/feature_bookmark/domain/repository/city_repository.dart';

class DeleteCityUsecase extends UseCase<DataState<String>, String> {
  final CityRepository cityRepository;

  DeleteCityUsecase({required this.cityRepository});

  @override
  Future<DataState<String>> call(String param) =>
      cityRepository.deleteCity(param);
}
