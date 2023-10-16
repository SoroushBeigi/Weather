import 'package:equatable/equatable.dart';

abstract class DeleteCityStatus extends Equatable{}

class DeleteInitial extends DeleteCityStatus{
  @override
  List<Object?> get props => [];
}

class DeleteLoading extends DeleteCityStatus{
  @override
  List<Object?> get props => [];
}

class DeleteCompleted extends DeleteCityStatus{
  final String cityName;
  DeleteCompleted({required this.cityName});
  @override
  List<Object?> get props => [cityName];
}

class DeleteError extends DeleteCityStatus{
  final String? message;
  DeleteError({required this.message});
  @override
  List<Object?> get props => [message];
}

