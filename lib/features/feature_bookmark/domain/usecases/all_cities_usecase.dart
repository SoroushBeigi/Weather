import 'package:weather/core/recources/data_state.dart';
import 'package:weather/core/usecase/usecase.dart';
import 'package:weather/features/feature_bookmark/domain/entities/city_entity.dart';
import 'package:weather/features/feature_bookmark/domain/repository/city_repository.dart';

class AllCitiesUseCase extends UseCase<DataState<List<City>>, void> {
  final CityRepository cityRepository;

  AllCitiesUseCase({required this.cityRepository});

  @override
  Future<DataState<List<City>>> call(void param) =>
      cityRepository.getAllCitiesFromDB();
}
