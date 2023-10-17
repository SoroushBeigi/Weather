import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/features/feature_bookmark/domain/entities/city_entity.dart';
import 'package:weather/features/feature_bookmark/presentation/bloc/bookmark_bloc.dart';

class ListItem extends StatelessWidget {
  final City city;
  const ListItem({required this.city, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                      BlocProvider.of<BookmarkBloc>(context)
                          .add(RemoveCityEvent(cityName: city.name));
                      BlocProvider.of<BookmarkBloc>(context)
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
    );
  }
}
