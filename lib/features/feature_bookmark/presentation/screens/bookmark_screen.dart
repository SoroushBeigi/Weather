import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/features/feature_bookmark/domain/entities/city_entity.dart';
import 'package:weather/features/feature_bookmark/presentation/bloc/bookmark_bloc.dart';
import 'package:weather/features/feature_bookmark/presentation/bloc/get_all_cities_status.dart';
import 'package:weather/features/feature_weather/presentation/bloc/weather_bloc.dart';

class BookmarkScreen extends StatelessWidget {
  final PageController pageController;
  const BookmarkScreen({required this.pageController, super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<BookmarkBloc>(context).add(GetAllCitiesEvent());
    return BlocBuilder<BookmarkBloc, BookmarkState>(
      buildWhen: (previous, current) =>
          previous.getAllCitiesStatus != current.getAllCitiesStatus,
      builder: (context, state) {
        if (state.getAllCitiesStatus is GetAllLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state.getAllCitiesStatus is GetAllError) {
          GetAllError getAllError = state.getAllCitiesStatus as GetAllError;
          return Center(
            child: Text(getAllError.message!),
          );
        }

        if (state.getAllCitiesStatus is GetAllCompleted) {
          GetAllCompleted getAllCompleted =
              state.getAllCitiesStatus as GetAllCompleted;
          final List<City> cities = getAllCompleted.cities;

          return SafeArea(
              child: Column(
            children: [
              const SizedBox(height: 20,),
              const Text(
                'Saved Cities',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                  fontSize: 25,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                  child: cities.isEmpty
                      ?  Center(
                          child: Container(
                            decoration: BoxDecoration(color: Colors.black.withOpacity(0.4), borderRadius: const BorderRadius.all(Radius.circular(20))),
                            padding: const EdgeInsets.all(15),
                            child: const Text(
                              'You can bookmark cities to see them here.',
                              style: TextStyle(color: Colors.white,fontSize: 15),
                            ),
                          ),
                        )
                      : ListView.builder(
                          itemCount: cities.length,
                          itemBuilder: (bContext, index) {
                            City city = cities[index];
                            return GestureDetector(
                              onTap: () {
                                BlocProvider.of<WeatherBloc>(context).add(
                                    LoadCurrentWEvent(cityname: city.name));
                                pageController.animateToPage(0,
                                    duration: const Duration(microseconds: 300),
                                    curve: Curves.easeInOut);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8),
                                child: ClipRect(
                                  child: BackdropFilter(
                                    filter: ImageFilter.blur(
                                      sigmaX: 5,
                                      sigmaY: 5,
                                    ),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      height: 60,
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(20),
                                        ),
                                        color: Colors.black.withOpacity(0.2),
                                      ),
                                      padding: const EdgeInsets.only(left: 20),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            city.name,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 20,
                                            ),
                                          ),
                                          IconButton(
                                              onPressed: () {
                                                BlocProvider.of<BookmarkBloc>(
                                                        context)
                                                    .add(RemoveCityEvent(
                                                        cityName: city.name));
                                                BlocProvider.of<BookmarkBloc>(
                                                        context)
                                                    .add(GetAllCitiesEvent());
                                              },
                                              icon: const Icon(
                                                Icons.delete,
                                                color: Colors.red,
                                              ))
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          })),
            ],
          ));
        }

        return const Center(
          child: Text('Bookmark Screen'),
        );
      },
    );
  }
}
