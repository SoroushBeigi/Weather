import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/features/feature_weather/presentation/bloc/current_weather_status.dart';
import 'package:weather/features/feature_weather/presentation/bloc/weather_bloc.dart';

class MainWrapper extends StatefulWidget {
  const MainWrapper({super.key});

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<WeatherBloc>(context)
        .add(const LoadCurrentWEvent(cityname: 'tehran'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<WeatherBloc, WeatherState>(
        builder: (context, state) {
          if (state.cwStatus is CWLoading) {
            return const Center(child: Text('Loading...'));
          }
          if (state.cwStatus is CWError) {
            return const Center(child: Text('Error'));
          }
          if (state.cwStatus is CWCompleted) {
            return const Center(child: Text('Completed'));
          }

          return Container();
        },
      ),
    );
  }
}
