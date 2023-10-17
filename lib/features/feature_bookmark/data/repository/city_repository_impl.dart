import 'package:flutter/foundation.dart';
import 'package:weather/core/recources/data_state.dart';
import 'package:weather/features/feature_bookmark/data/data_source/local/city_dao.dart';
import 'package:weather/features/feature_bookmark/domain/entities/city_entity.dart';
import 'package:weather/features/feature_bookmark/domain/repository/city_repository.dart';

class CityRepositoryImplementation extends CityRepository {
  final CityDao cityDao;

  CityRepositoryImplementation({required this.cityDao});

  @override
  Future<DataState<String>> deleteCity(String cityName) async {
    try {
      await cityDao.deleteCity(cityName);
      return DataSuccess(cityName);
    } catch (e) {
      final exception = e.toString();
      debugPrint(exception);
      return DataFailed(exception);
    }
  }

  @override
  Future<DataState<List<City>>> getAllCitiesFromDB() async {
    try {
      final cities = await cityDao.getAllCities();
      return DataSuccess(cities);
    } catch (e) {
      final exception = e.toString();
      debugPrint(exception);
      return DataFailed(exception);
    }
  }

  @override
  Future<DataState<City?>> getCityByName(String cityName) async {
    try {
      final city = await cityDao.findCity(cityName);
      return DataSuccess(city);
    } catch (e) {
      final exception = e.toString();
      debugPrint(exception);
      return DataFailed(exception);
    }
  }

  @override
  Future<DataState<City>> saveCityToDB(String cityName) async {
    try {

      //Checking if the city is in the database
      final city = await cityDao.findCity(cityName);
      if (city != null) {
        return DataFailed('$cityName exists in database');
      }

      //City is not in the database, so we insert it
      final savingCity = City(name: cityName);
      await cityDao.insertCity(savingCity);
      return DataSuccess(savingCity);
    } catch (e) {

      final exception = e.toString();
      debugPrint(exception);
      return DataFailed(exception);
    }
  }
}
