import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/core/widgets/background.dart';
import 'package:weather/core/widgets/loading_widget.dart';
import 'package:weather/features/feature_weather/presentation/bloc/current_weather_status.dart';
import 'package:weather/features/feature_weather/presentation/bloc/weather_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final cityName = 'Tehran';

  @override
  void initState() {
    super.initState();
    BlocProvider.of<WeatherBloc>(context)
        .add(LoadCurrentWEvent(cityname: cityName));
  }

  @override
  Widget build(BuildContext context) {
    
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Container(
      color: Colors.black.withOpacity(0.5),
      child: SafeArea(
          child: Column(
        children: [
          BlocBuilder<WeatherBloc, WeatherState>(
            builder: (context, state) {
              if (state.cwStatus is CWLoading) {
                return const Expanded(child: LoadingWidget());
              }
              if (state.cwStatus is CWError) {
                return const Center(child: Text('Error'));
              }
              if (state.cwStatus is CWCompleted) {
                final cwCompleted = state.cwStatus as CWCompleted;
                final currentCityEntity = cwCompleted.currentWeatherEntity;

                return Expanded(
                    child: ListView(
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 50),
                          child: Text(
                            currentCityEntity.name!,
                            style: const TextStyle(
                              fontSize: 30,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Text(
                            currentCityEntity.weather![0].description!,
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.grey[300],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: AppBackground.setIconForMain(
                              currentCityEntity.weather![0].description),
                        ),
                      ],
                    )
                  ],
                ));
              }

              return Container();
            },
          ),
        ],
      )),
    );
  }
}
