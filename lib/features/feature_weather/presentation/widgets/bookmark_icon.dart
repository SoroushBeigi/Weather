import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/features/feature_bookmark/domain/entities/city_entity.dart';
import 'package:weather/features/feature_bookmark/presentation/bloc/bloc/bookmark_bloc.dart';
import 'package:weather/features/feature_bookmark/presentation/bloc/bloc/get_city_status.dart';
import 'package:weather/features/feature_bookmark/presentation/bloc/bloc/save_city_status.dart';

class BookmarkIcon extends StatelessWidget {
  final String cityName;
  const BookmarkIcon({required this.cityName, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookmarkBloc, BookmarkState>(
      buildWhen: (previous, current) =>
          current.getCityStatus != previous.getCityStatus,
      builder: (context, state) {
        //Initial save, to reset the icon after choosing the next city. (the city is updated and so must the icon!)
        BlocProvider.of<BookmarkBloc>(context).add(SaveCityInitialEvent());

        if (state.getCityStatus is GetLoading) {
          return const CircularProgressIndicator();
        }

        if (state.getCityStatus is GetCompleted) {
          GetCompleted getCityCompleted = state.getCityStatus as GetCompleted;

          //City is nullable, because it may not exist in the database!
          City? city = getCityCompleted.city;

          return BlocConsumer<BookmarkBloc, BookmarkState>(
            buildWhen: (previous, current) =>
                previous.saveCityStatus != current.saveCityStatus,
            listenWhen: (previous, current) =>
                previous.saveCityStatus != current.saveCityStatus,
            listener: (context, cityState) {
              if (cityState.saveCityStatus is SaveError) {
                SaveError saveError = cityState.saveCityStatus as SaveError;
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(saveError.message!),
                  behavior: SnackBarBehavior.floating,
                ));
              }
              if (cityState.saveCityStatus is SaveCompleted) {
                SaveCompleted saveCompleted =
                    cityState.saveCityStatus as SaveCompleted;
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content:
                      Text('${saveCompleted.city.name} added to saved cities!'),
                  behavior: SnackBarBehavior.floating,
                ));
              }
            },
            builder: (context, cityState) {
              if (cityState.saveCityStatus is SaveInitial) {
                return IconButton(
                  onPressed: () => BlocProvider.of<BookmarkBloc>(context).add(
                    SaveCityEvent(
                      cityName: cityName,
                    ),
                  ),
                  icon: Icon(city==null ? Icons.star_border : Icons.star, color: Colors.white, size: 35,));
                
              }

              if (cityState.saveCityStatus is SaveLoading) {
                return const CircularProgressIndicator();
              }

              //Default return for other situations (completed and error).
              return IconButton(
                onPressed: () => BlocProvider.of<BookmarkBloc>(context).add(
                  SaveCityEvent(cityName: cityName),
                ),
                icon: const Icon(
                  Icons.star,
                  color: Colors.white,
                  size: 35,
                ),
              );
            },
          );
        }

        if (state.getCityStatus is GetError) {
          return IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.error,
                color: Colors.white,
                size: 35,
              ));
        }

        return const SizedBox();
      },
    );
  }
}
