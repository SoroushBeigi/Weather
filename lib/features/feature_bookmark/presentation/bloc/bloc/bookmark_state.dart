part of 'bookmark_bloc.dart';

class BookmarkState extends Equatable {
  final GetCityStatus getCityStatus;
  final SaveCityStatus saveCityStatus;

  const BookmarkState(
      {required this.getCityStatus, required this.saveCityStatus});

  BookmarkState copyWith(
      {GetCityStatus? newGetStatus, SaveCityStatus? newSaveStatus}) {
    return BookmarkState(
      getCityStatus: newGetStatus ?? getCityStatus,
      saveCityStatus: newSaveStatus ?? saveCityStatus,
    );
  }

  @override
  List<Object?> get props => [
        getCityStatus,
        saveCityStatus,
      ];
}
