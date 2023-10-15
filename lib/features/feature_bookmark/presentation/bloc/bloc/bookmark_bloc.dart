import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weather/core/recources/data_state.dart';
import 'package:weather/features/feature_bookmark/domain/usecases/save_city_usecase.dart';
import 'package:weather/features/feature_bookmark/domain/usecases/search_city_usecase.dart';
import 'package:weather/features/feature_bookmark/presentation/bloc/bloc/get_city_status.dart';
import 'package:weather/features/feature_bookmark/presentation/bloc/bloc/save_city_status.dart';

part 'bookmark_event.dart';
part 'bookmark_state.dart';

class BookmarkBloc extends Bloc<BookmarkEvent, BookmarkState> {
  SaveCityUsecase saveCityUsecase;
  SearchCityUsecase searchCityUsecase;
  // AllCitiesUseCase allCitiesUseCase;
  // DeleteCityUsecase deleteCityUsecase;
  //We need to set the initial status  here, and the default status for getCity is loading!

  BookmarkBloc({
    required this.saveCityUsecase,
    required this.searchCityUsecase,
    // required this.deleteCityUsecase,
    // required this.allCitiesUseCase,
  }) : super(BookmarkState(
            getCityStatus: GetLoading(), saveCityStatus: SaveInitial())) {
    on<GetCityByNameEvent>(_getCityByName);
    on<SaveCityEvent>(_saveCity);
    on<SaveCityInitialEvent>(_saveCityInitial);
  }

  Future<void> _getCityByName(
      GetCityByNameEvent event, Emitter<BookmarkState> emit) async {
    emit(state.copyWith(newGetStatus: GetLoading()));

    DataState dataState = await searchCityUsecase(event.cityName);

    if (dataState is DataSuccess) {
      emit(state.copyWith(newGetStatus: GetCompleted(city: dataState.data)));
    }

    if (dataState is DataFailed) {
      emit(state.copyWith(newGetStatus: GetError(message: dataState.error)));
    }
  }

  Future<void> _saveCity(
      SaveCityEvent event, Emitter<BookmarkState> emit) async {
    emit(state.copyWith(newSaveStatus: SaveLoading()));

    DataState dataState = await saveCityUsecase(event.cityName);

    if (dataState is DataSuccess) {
      emit(state.copyWith(newSaveStatus: SaveCompleted(city: dataState.data)));
    }

    if (dataState is DataFailed) {
      emit(state.copyWith(newSaveStatus: SaveError(message: dataState.error)));
    }
  }

  //Back to initial state!
  Future<void> _saveCityInitial(
      SaveCityInitialEvent event, Emitter<BookmarkState> emit) async {
    emit(state.copyWith(newSaveStatus: SaveInitial()));
  }
}
