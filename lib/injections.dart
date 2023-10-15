import 'package:get_it/get_it.dart';
import 'package:weather/features/feature_bookmark/data/data_source/local/database.dart';
import 'package:weather/features/feature_bookmark/data/repository/city_repository_impl.dart';
import 'package:weather/features/feature_bookmark/domain/repository/city_repository.dart';
import 'package:weather/features/feature_bookmark/domain/usecases/all_cities_usecase.dart';
import 'package:weather/features/feature_bookmark/domain/usecases/delete_city_usecase.dart';
import 'package:weather/features/feature_bookmark/domain/usecases/save_city_usecase.dart';
import 'package:weather/features/feature_bookmark/domain/usecases/search_city_usecase.dart';
import 'package:weather/features/feature_bookmark/presentation/bloc/bloc/bookmark_bloc.dart';
import 'package:weather/features/feature_weather/data/data_source/remote/api_provider.dart';
import 'package:weather/features/feature_weather/data/repository/weather_repository_impl.dart';
import 'package:weather/features/feature_weather/domain/repository/weather_repository.dart';
import 'package:weather/features/feature_weather/domain/usecases/get_forecast_usecase.dart';
import 'package:weather/features/feature_weather/domain/usecases/get_weather_usecase.dart';
import 'package:weather/features/feature_weather/presentation/bloc/weather_bloc.dart';

GetIt locator = GetIt.I;

setup() async {
  //providers
  locator.registerSingleton<ApiProvider>(ApiProvider());

  //database
  final database =
      await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  locator.registerSingleton<AppDatabase>(database);

  //repositories
  locator.registerSingleton<WeatherRepository>(WeatherRepositoryImplementation(
    apiProvider: locator(),
  ));
  locator.registerSingleton<CityRepository>(CityRepositoryImplementation(
    cityDao: database.cityDao,
  ));

  //use cases
  locator.registerSingleton<GetWeatherUseCase>(GetWeatherUseCase(
    weatherRepository: locator(),
  ));
  locator.registerSingleton<GetForecastUseCase>(GetForecastUseCase(
    weatherRepository: locator(),
  ));

  locator.registerSingleton<AllCitiesUseCase>(AllCitiesUseCase(
    cityRepository: locator(),
  ));
  locator.registerSingleton<DeleteCityUsecase>(DeleteCityUsecase(
    cityRepository: locator(),
  ));
  locator.registerSingleton<SaveCityUsecase>(SaveCityUsecase(
    cityRepository: locator(),
  ));
  locator.registerSingleton<SearchCityUsecase>(SearchCityUsecase(
    cityRepository: locator(),
  ));

  //blocs
  locator.registerSingleton<WeatherBloc>(
    WeatherBloc(
      getWeatherUseCase: locator(),
      getForecastUseCase: locator(),
    ),
  );
  locator.registerSingleton<BookmarkBloc>(
    BookmarkBloc(
      saveCityUsecase: locator(),
      searchCityUsecase: locator(),
    ),
  );
}
