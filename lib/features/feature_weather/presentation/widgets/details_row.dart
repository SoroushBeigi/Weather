import 'package:flutter/material.dart';
import 'package:weather/core/utils/date_converter.dart';
import 'package:weather/features/feature_weather/domain/entities/current_weather_entity.dart';

class DetailsRow extends StatelessWidget {
  final CurrentWeatherEntity currentCityEntity;
  const DetailsRow({required this.currentCityEntity, super.key});

  @override
  Widget build(BuildContext context) {

    //Correcting time format
    final sunrise = DateConverter.changeDtToDateTimeHour(
      currentCityEntity.sys!.sunrise,
      currentCityEntity.timezone,
    );
    final sunset = DateConverter.changeDtToDateTimeHour(
      currentCityEntity.sys!.sunset,
      currentCityEntity.timezone,
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            const Text(
              "wind speed",
              style: TextStyle(
                fontSize: 14,
                color: Colors.amber,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Text(
                "${currentCityEntity.wind!.speed!} m/s",
                style: const TextStyle(
                  fontSize: 13,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Container(
            color: Colors.white24,
            height: 30,
            width: 2,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Column(
            children: [
              const Text(
                "sunrise",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.amber,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Text(
                  sunrise,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Container(
            color: Colors.white24,
            height: 30,
            width: 2,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Column(
            children: [
              const Text(
                "sunset",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.amber,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Text(
                  sunset,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Container(
            color: Colors.white24,
            height: 30,
            width: 2,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Column(
            children: [
              const Text(
                "humidity",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.amber,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Text(
                  "${currentCityEntity.main!.humidity!}%",
                  style: const TextStyle(
                    fontSize: 13,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
