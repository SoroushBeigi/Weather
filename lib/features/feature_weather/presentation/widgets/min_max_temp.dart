import 'package:flutter/material.dart';
import 'package:weather/features/feature_weather/domain/entities/current_weather_entity.dart';

class MinMaxTemp extends StatelessWidget {
  final CurrentWeatherEntity currentWeatherEntity;
  const MinMaxTemp({required this.currentWeatherEntity,super.key});

  @override
  Widget build(BuildContext context) {
    return   IntrinsicHeight(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Column(
                                      children: [
                                        Text(
                                          'min',
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.grey[300]),
                                        ),
                                        const SizedBox(height: 10),
                                        Text(
                                          '${currentWeatherEntity.main!.tempMin!.round()}\u00B0',
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 20),
                                        )
                                      ],
                                    ),
                                    const VerticalDivider(
                                      width: 20,
                                      thickness: 1.5,
                                      indent: 20,
                                      endIndent: 0,
                                      color: Colors.white,
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          'max',
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.grey[300]),
                                        ),
                                        const SizedBox(height: 10),
                                        Text(
                                          '${currentWeatherEntity.main!.tempMax!.round()}\u00B0',
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 20),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              );
  }
}