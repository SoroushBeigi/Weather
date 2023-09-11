import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:weather/features/feature_weather/domain/entities/forecast_entity.dart';

@immutable
abstract class FWStatus extends Equatable {}

class FWLoading extends FWStatus {
  @override
  List<Object?> get props => [];
}

class FWCompleted extends FWStatus {
  final ForecastEntity forecastEntity;
  FWCompleted(this.forecastEntity);

  @override
  List<Object?> get props => [forecastEntity];
}

class FWError extends FWStatus {
  final String message;
  FWError(this.message);

  @override
  List<Object?> get props => [message];
}
