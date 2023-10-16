part of 'bookmark_bloc.dart';

abstract class BookmarkEvent {}

class GetAllCitiesEvent extends BookmarkEvent {}

class SaveCityInitialEvent extends BookmarkEvent {}

class GetCityByNameEvent extends BookmarkEvent {
  final String cityName;
  GetCityByNameEvent({required this.cityName});
}

class SaveCityEvent extends BookmarkEvent {
  final String cityName;
  SaveCityEvent({required this.cityName});
}

class RemoveCityEvent extends BookmarkEvent {
  final String cityName;
  RemoveCityEvent({required this.cityName});
}
