import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
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
