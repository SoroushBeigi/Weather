import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:weather/core/params/forecast_params.dart';
import 'package:weather/core/widgets/background.dart';
import 'package:weather/core/widgets/loading_widget.dart';
import 'package:weather/features/feature_weather/data/models/forecast_model.dart';
import 'package:weather/features/feature_weather/domain/entities/current_weather_entity.dart';
import 'package:weather/features/feature_weather/domain/entities/forecast_entity.dart';
import 'package:weather/features/feature_weather/presentation/bloc/current_weather_status.dart';
import 'package:weather/features/feature_weather/presentation/bloc/forecast_weather_status.dart';
import 'package:weather/features/feature_weather/presentation/bloc/weather_bloc.dart';
import 'package:weather/features/feature_weather/presentation/widgets/weekly_weather_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final cityName = 'Tehran';
  final pageController = PageController();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<WeatherBloc>(context)
        .add(LoadCurrentWEvent(cityname: cityName));
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    //final width = MediaQuery.of(context).size.width;

    return Container(
      color: Colors.black.withOpacity(0.5),
      child: SafeArea(
          child: Column(
        children: [
          //BlocBuilder for CurrentWeather loading.
          BlocBuilder<WeatherBloc, WeatherState>(
            buildWhen: (previous, current) {
              if (previous.cwStatus == current.cwStatus) {
                return false;
              }
              return true;
            },
            builder: (context, state) {
              if (state.cwStatus is CWLoading) {
                return const Expanded(child: LoadingWidget());
              }

              if (state.cwStatus is CWCompleted) {
                final CWCompleted cwCompleted = state.cwStatus as CWCompleted;
                final CurrentWeatherEntity currentCityEntity =
                    cwCompleted.currentWeatherEntity;

                final forecastParams = ForecastParams(
                  currentCityEntity.coord!.lat!,
                  currentCityEntity.coord!.lon!,
                );

                BlocProvider.of<WeatherBloc>(context).add(
                  LoadForecastEvent(forecastParams: forecastParams),
                );

                return Expanded(
                    child: ListView(
                  children: [
                    SizedBox(height: height * 0.02),
                    SizedBox(
                      width: double.infinity,
                      height: 400,
                      child: PageView.builder(
                        controller: pageController,
                        physics: const AlwaysScrollableScrollPhysics(),
                        allowImplicitScrolling: true,
                        itemCount: 2,
                        itemBuilder: (c, pos) {
                          if (pos == 0) {
                            return Column(
                              children: [
                                const SizedBox(height: 50),
                                Text(
                                  currentCityEntity.name!,
                                  style: const TextStyle(
                                    fontSize: 30,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Text(
                                  currentCityEntity.weather![0].description!,
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.grey[300],
                                  ),
                                ),
                                const SizedBox(height: 20),
                                AppBackground.setIconForMain(
                                  currentCityEntity.weather![0].description,
                                ),
                                const SizedBox(height: 20),
                                Text(
                                  '${currentCityEntity.main!.temp!.round()}\u00B0',
                                  style: TextStyle(
                                    fontSize: 40,
                                    color: Colors.grey[300],
                                  ),
                                ),
                                const SizedBox(height: 20),
                                IntrinsicHeight(
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
                                            '${currentCityEntity.main!.tempMin!.round()}\u00B0',
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
                                            '${currentCityEntity.main!.tempMax!.round()}\u00B0',
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 20),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          } else {
                            return Container(
                              color: Colors.red,
                            );
                          }
                        },
                      ),
                    ),
                    Center(
                      child: SmoothPageIndicator(
                        controller: pageController,
                        count: 2,
                        effect: const WormEffect(
                          dotHeight: 10,
                          dotWidth: 10,
                          spacing: 10,
                          activeDotColor: Colors.white,
                          dotColor: Colors.grey,
                        ),
                        onDotClicked: (index) {
                          pageController.animateToPage(
                            index,
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.ease,
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      height: 100,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Center(
                          child: BlocBuilder<WeatherBloc, WeatherState>(
                            builder: (BuildContext context, state) {
                              /// show Loading State for Fw
                              if (state.fwStatus is FWLoading) {
                                return const LoadingWidget();
                              }

                              /// show Completed State for Fw
                              if (state.fwStatus is FWCompleted) {
                                /// casting
                                final FWCompleted fwCompleted =
                                    state.fwStatus as FWCompleted;
                                final ForecastEntity forecastDaysEntity =
                                    fwCompleted.forecastEntity;
                                final List<Daily> mainDaily =
                                    forecastDaysEntity.daily!;

                                return SizedBox(
                                  width: double.infinity,
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: 7,
                                    itemBuilder: (
                                      BuildContext context,
                                      int index,
                                    ) {
                                      return WeeklyWeatherItem(
                                        daily: mainDaily[index + 1],
                                      );
                                    },
                                  ),
                                );
                              }

                              /// show Error State for Fw
                              if (state.fwStatus is FWError) {
                                final FWError fwError =
                                    state.fwStatus as FWError;
                                return Center(
                                  child: Text(fwError.message),
                                );
                              }

                              /// show Default State for Fw
                              return Container();
                            },
                          ),
                        ),
                      ),
                    ),
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
