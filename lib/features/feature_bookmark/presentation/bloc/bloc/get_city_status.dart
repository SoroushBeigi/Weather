import 'package:equatable/equatable.dart';
import 'package:weather/features/feature_bookmark/domain/entities/city_entity.dart';

abstract class GetCityStatus extends Equatable{}

class GetInitial extends GetCityStatus{
  @override
  List<Object?> get props => [];
}

class GetLoading extends GetCityStatus{
  @override
  List<Object?> get props => [];
}

class GetCompleted extends GetCityStatus{
  final City? city;
  GetCompleted({required this.city});
  @override
  List<Object?> get props => [city];
}

class GetError extends GetCityStatus{
  final String? message;
  GetError({required this.message});
  @override
  List<Object?> get props => [message];
}

