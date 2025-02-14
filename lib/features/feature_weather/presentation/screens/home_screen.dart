import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/core/params/forecast_params.dart';
import 'package:weather/core/widgets/loading_widget.dart';
import 'package:weather/features/feature_weather/data/models/forecast_model.dart';
import 'package:weather/features/feature_weather/domain/entities/current_weather_entity.dart';
import 'package:weather/features/feature_weather/domain/entities/forecast_entity.dart';
import 'package:weather/features/feature_weather/domain/usecases/get_suggestion_usecase.dart';
import 'package:weather/features/feature_weather/presentation/bloc/current_weather_status.dart';
import 'package:weather/features/feature_weather/presentation/bloc/forecast_weather_status.dart';
import 'package:weather/features/feature_weather/presentation/bloc/weather_bloc.dart';
import 'package:weather/features/feature_weather/presentation/widgets/bookmark_icon.dart';
import 'package:weather/features/feature_weather/presentation/widgets/city_temp.dart';
import 'package:weather/features/feature_weather/presentation/widgets/city_text_field.dart';
import 'package:weather/features/feature_weather/presentation/widgets/details_row.dart';
import 'package:weather/features/feature_weather/presentation/widgets/weekly_weather_item.dart';
import 'package:weather/injections.dart';

import '../../../feature_bookmark/presentation/bloc/bookmark_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin {
  final controller = TextEditingController();
  GetSuggestionUsecase getSuggestionUsecase =
      GetSuggestionUsecase(weatherRepository: locator());

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
    super.build(context);
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Container(
      color: Colors.black.withOpacity(0.5),
      child: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: height * 0.02,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.03),
              child: Row(
                children: [
                  Expanded(
                    child: CityTextField(
                      onSubmitted: onSubmitted,
                      controller: controller,
                      getSuggestionUsecase: getSuggestionUsecase,
                    ),
                  ),
                  const SizedBox(width: 10),
                  BlocBuilder<WeatherBloc, WeatherState>(
                    buildWhen: (previous, current) =>
                        previous.cwStatus != current.cwStatus,
                    builder: (context, state) {
                      if (state.cwStatus is CWLoading) {
                        return const CircularProgressIndicator();
                      }

                      if (state.cwStatus is CWError) {
                        return IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.error,
                            color: Colors.white,
                            size: 35,
                          ),
                        );
                      }

                      if (state.cwStatus is CWCompleted) {
                        final CWCompleted cwCompleted =
                            state.cwStatus as CWCompleted;
                        BlocProvider.of<BookmarkBloc>(context).add(
                            GetCityByNameEvent(
                                cityName:
                                    cwCompleted.currentWeatherEntity.name!));
                        return BookmarkIcon(
                          cityName: cwCompleted.currentWeatherEntity.name!,
                        );
                      }

                      return const SizedBox();
                    },
                  ),
                ],
              ),
            ),

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
                            height: height * 0.55,
                            child: CityTemp(
                                currentWeatherEntity: currentCityEntity)),
                        const SizedBox(height: 10),
                        // Container(
                        //   color: Colors.grey[300],
                        //   width: double.infinity,
                        //   height: 2,
                        // ),
                        // const SizedBox(height: 5),
                        // SizedBox(
                        //   width: double.infinity,
                        //   height: 100,
                        //   child: Padding(
                        //     padding: const EdgeInsets.only(left: 10.0),
                        //     child: Center(
                        //       //BlocBuilder for Forecast Weather
                        //       child: BlocBuilder<WeatherBloc, WeatherState>(
                        //         builder: (BuildContext context, state) {
                        //           /// show Loading State for Fw
                        //           if (state.fwStatus is FWLoading) {
                        //             return const LoadingWidget();
                        //           }

                        //           /// show Completed State for Fw
                        //           if (state.fwStatus is FWCompleted) {
                        //             /// casting
                        //             final FWCompleted fwCompleted =
                        //                 state.fwStatus as FWCompleted;
                        //             final ForecastEntity forecastDaysEntity =
                        //                 fwCompleted.forecastEntity;
                        //             final List<Daily> mainDaily =
                        //                 forecastDaysEntity.daily!;

                        //             return ListView.builder(
                        //               shrinkWrap: true,
                        //               scrollDirection: Axis.horizontal,
                        //               itemCount: 7,
                        //               itemBuilder: (
                        //                 BuildContext context,
                        //                 int index,
                        //               ) {
                        //                 return WeeklyWeatherItem(
                        //                   daily: mainDaily[index + 1],
                        //                 );
                        //               },
                        //             );
                        //           }

                        //           /// show Error State for Fw
                        //           if (state.fwStatus is FWError) {
                        //             final FWError fwError =
                        //                 state.fwStatus as FWError;
                        //             return Center(
                        //               child: Text(fwError.message),
                        //             );
                        //           }

                        //           /// show Default State for Fw
                        //           return Container();
                        //         },
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        const SizedBox(height: 5),
                        Container(
                          color: Colors.grey[300],
                          width: double.infinity,
                          height: 2,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        DetailsRow(currentCityEntity: currentCityEntity),
                      ],
                    ),
                  );
                }

                return Container();
              },
            ),
          ],
        ),
      ),
    );
  }

  void onSubmitted(String cityName) {
    controller.text = cityName;
    BlocProvider.of<WeatherBloc>(context).add(
      LoadCurrentWEvent(cityname: cityName),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
