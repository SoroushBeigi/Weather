import 'package:flutter/material.dart';
import 'package:weather/core/utils/date_converter.dart';
import 'package:weather/core/widgets/background.dart';
import 'package:weather/features/feature_weather/data/models/forecast_model.dart';

class WeeklyWeatherItem extends StatefulWidget {
  final Daily daily;
  const WeeklyWeatherItem({super.key, required this.daily});

  @override
  State<WeeklyWeatherItem> createState() => _WeeklyWeatherItemState();
}

class _WeeklyWeatherItemState extends State<WeeklyWeatherItem>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation animation;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    animation = Tween(
      begin: -1.0,
      end: 0.0,
    ).animate(CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.5, 1, curve: Curves.decelerate)));
    animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    return AnimatedBuilder(
      animation: animationController,
      builder: (context, child) {
        return Transform(
          transform:
              Matrix4.translationValues(animation.value * width, 0.0, 0.0),
          child: Card(
            color: Colors.transparent,
            elevation: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal:1),
              child: SizedBox(
                width: 45,
                height: 45,
                child: Column(
                  children: [
                    Text(
                      DateConverter.changeDtToDateTime(widget.daily.dt),
                      style: TextStyle(fontSize: 12, color: Colors.grey[300]),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    AppBackground.setIconForMain(
                        widget.daily.weather![0].description),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: Text(
                          "${widget.daily.temp!.day!.round()}\u00B0",
                          style:
                              const TextStyle(fontSize: 15, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
}
