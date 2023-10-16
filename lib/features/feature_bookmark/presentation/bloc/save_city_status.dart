import 'package:equatable/equatable.dart';
import 'package:weather/features/feature_bookmark/domain/entities/city_entity.dart';

abstract class SaveCityStatus extends Equatable{}

class SaveInitial extends SaveCityStatus{
  @override
  List<Object?> get props => [];
}

class SaveLoading extends SaveCityStatus{
  @override
  List<Object?> get props => [];
}

class SaveCompleted extends SaveCityStatus{
  final City city;
  SaveCompleted({required this.city});
  @override
  List<Object?> get props => [city];
}

class SaveError extends SaveCityStatus{
  final String? message;
  SaveError({required this.message});
  @override
  List<Object?> get props => [message];
}

