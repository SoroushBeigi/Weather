import 'package:equatable/equatable.dart';
import 'package:weather/features/feature_weather/data/models/city_suggestion_model.dart';

class CitySuggestionEntity extends Equatable {
  final List<Data>? data;
  final Metadata? metadata;

  const CitySuggestionEntity({this.data, this.metadata});

  @override
  List<Object?> get props => [data, metadata];

  @override
  bool? get stringify => true;
}
