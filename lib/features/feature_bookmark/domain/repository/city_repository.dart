import 'package:weather/core/recources/data_state.dart';
import 'package:weather/features/feature_bookmark/domain/entities/city_entity.dart';

abstract class CityRepository{

  Future<DataState<City>> saveCityToDB(String cityName);
  Future<DataState<List<City>>> getAllCitiesFromDB();
  Future<DataState<City?>> getCityByName(String cityName);
  Future<DataState<String>> deleteCity(String cityName);
  
}