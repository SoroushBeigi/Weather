import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:weather/features/feature_weather/domain/entities/current_weather_entity.dart';

@immutable
abstract class CWStatus extends Equatable{}

class CWLoading extends CWStatus{
  @override
  List<Object?> get props => [];
}
class CWCompleted extends CWStatus{

  final CurrentWeatherEntity currentWeatherEntity;
  CWCompleted(this.currentWeatherEntity);
  
  @override
  List<Object?> get props => [currentWeatherEntity];

}
class CWError extends CWStatus{
  final String message;

  CWError(this.message);
  
  @override
  List<Object?> get props =>[message];
}