
import 'package:floor/floor.dart';
import 'package:weather/features/feature_bookmark/domain/entities/city_entity.dart';

@dao
abstract class CityDao{
  
  @Query('SELECT * FROM City')
  Future<List<City>> getAllCities();

  @Query('SELECT * FROM City WHERE name = :name')
  Future<City?> findCity(String name);

  @insert 
  Future<void> insertCity(City city);

  @Query('DELETE FROM City WHERE name = :name')
  Future<void> deleteCity(String name);
}