part of 'bookmark_bloc.dart';

class BookmarkState extends Equatable {
  final GetCityStatus getCityStatus;
  final SaveCityStatus saveCityStatus;
  final GetAllCitiesStatus getAllCitiesStatus;
  final DeleteCityStatus deleteCityStatus;

  const BookmarkState({
    required this.getCityStatus,
    required this.saveCityStatus,
    required this.getAllCitiesStatus,
    required this.deleteCityStatus,
  });

  BookmarkState copyWith({
    GetCityStatus? newGetStatus,
    SaveCityStatus? newSaveStatus,
    GetAllCitiesStatus? newGetAllStatus,
    DeleteCityStatus? newDeleteCityStatus,
  }) {
    return BookmarkState(
      getCityStatus: newGetStatus ?? getCityStatus,
      saveCityStatus: newSaveStatus ?? saveCityStatus,
      getAllCitiesStatus: newGetAllStatus ?? getAllCitiesStatus,
      deleteCityStatus: newDeleteCityStatus ?? deleteCityStatus,
    );
  }

  @override
  List<Object?> get props => [
        getCityStatus,
        saveCityStatus,
        deleteCityStatus,
        getAllCitiesStatus,
      ];
}
