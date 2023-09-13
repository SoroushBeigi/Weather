import 'package:weather/core/recources/data_state.dart';
import 'package:weather/core/usecase/usecase.dart';
import 'package:weather/features/feature_bookmark/domain/entities/city_entity.dart';
import 'package:weather/features/feature_bookmark/domain/repository/city_repository.dart';

class SearchCityUsecase extends UseCase<DataState<City?>, String> {
  final CityRepository cityRepository;

  SearchCityUsecase({required this.cityRepository});

  @override
  Future<DataState<City?>> call(String param) =>
      cityRepository.getCityByName(param);
}
