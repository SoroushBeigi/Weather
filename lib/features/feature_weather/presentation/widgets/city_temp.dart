import 'package:flutter/material.dart';
import 'package:weather/core/widgets/background.dart';
import 'package:weather/features/feature_weather/domain/entities/current_weather_entity.dart';
import 'package:weather/features/feature_weather/presentation/widgets/min_max_temp.dart';

class CityTemp extends StatelessWidget {
  final CurrentWeatherEntity currentWeatherEntity;
  const CityTemp({required this.currentWeatherEntity,super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
                            children: [
                              const SizedBox(height: 10),
                              Text(
                                currentWeatherEntity.name!,
                                style: const TextStyle(
                                  fontSize: 30,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 20),
                              Text(
                                currentWeatherEntity.weather![0].description!,
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.grey[300],
                                ),
                              ),
                              const SizedBox(height: 20),
                              AppBackground.setIconForMain(
                                currentWeatherEntity.weather![0].description,
                              ),
                              const SizedBox(height: 20),
                              Text(
                                '${currentWeatherEntity.main!.temp!.round()}\u00B0',
                                style: TextStyle(
                                  fontSize: 40,
                                  color: Colors.grey[300],
                                ),
                              ),
                              const SizedBox(height: 20),
                            MinMaxTemp(currentWeatherEntity: currentWeatherEntity),
                            ],
                          );
  }
}