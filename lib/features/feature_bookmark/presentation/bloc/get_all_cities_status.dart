import 'package:equatable/equatable.dart';
import 'package:weather/features/feature_bookmark/domain/entities/city_entity.dart';

abstract class GetAllCitiesStatus extends Equatable{}

class GetAllLoading extends GetAllCitiesStatus{
  @override
  List<Object?> get props => [];
}

class GetAllCompleted extends GetAllCitiesStatus{
  final List<City> cities;
  GetAllCompleted({required this.cities});
  @override
  List<Object?> get props => [cities];
}

class GetAllError extends GetAllCitiesStatus{
  final String? message;
  GetAllError({required this.message});
  @override
  List<Object?> get props => [message];
}
