import 'package:flutter/material.dart';
import 'package:weather/features/feature_weather/domain/entities/current_weather_entity.dart';

@immutable
abstract class CWStatus{}

class CWLoading extends CWStatus{}
class CWCompleted extends CWStatus{

  final CurrentWeatherEntity currentWeatherEntity;
  CWCompleted(this.currentWeatherEntity);

}
class CWError extends CWStatus{
  final String message;

  CWError(this.message);
}