import 'package:flutter/material.dart';
import 'package:weather/core/widgets/main_wrapper.dart';
import 'package:weather/features/feature_bookmark/presentation/bloc/bloc/bookmark_bloc.dart';
import 'package:weather/features/feature_weather/presentation/bloc/weather_bloc.dart';
import 'package:weather/injections.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //Calling GetIt Setup
  await setup();
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => locator<WeatherBloc>(),
          ),
           BlocProvider(
            create: (_) => locator<BookmarkBloc>(),
          ),
        ],
        child: MainWrapper(),
      ),
    ),
  );
}
