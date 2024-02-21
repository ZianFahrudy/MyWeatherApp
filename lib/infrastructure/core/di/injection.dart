import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:my_wheater_app/features/wheater/data/datasources/wheater_remote_datasources.dart';
import 'package:my_wheater_app/features/wheater/data/repositories/wheater_repository_impl.dart';
import 'package:my_wheater_app/features/wheater/domain/repositories/wheater_repository.dart';
import 'package:my_wheater_app/features/wheater/domain/usecases/get_current_weather_usecase.dart';
import 'package:my_wheater_app/features/wheater/domain/usecases/get_forecast_usecase.dart';
import 'package:my_wheater_app/features/wheater/domain/usecases/search_by_city_name_usecase.dart';
import 'package:my_wheater_app/features/wheater/presentation/bloc/bloc/forecast_bloc.dart';
import 'package:my_wheater_app/features/wheater/presentation/bloc/wheater_bloc.dart';
import 'package:my_wheater_app/infrastructure/core/config/env_config.dart';
import 'package:my_wheater_app/infrastructure/core/network/dio_handler.dart';
import 'package:my_wheater_app/infrastructure/core/prefs/shared_prefs.dart';

final sl = GetIt.instance;

class Injections {
  Future<void> init() async {
    final config = EnvConfig.getInstance();
    final prefs = await SharedPrefs.getInstance();

    // flavor, prefs, dio, etc
    sl
      ..registerLazySingleton(() => config)
      ..registerLazySingleton(() => prefs)
      ..registerLazySingleton<Dio>(() => sl<DioHandler>().dio)
      ..registerLazySingleton(
        () => DioHandler(config: sl(), preferences: sl()),
      )

      //Weather
      ..registerLazySingleton<WeatherRemoteDatasources>(
        () => WeatherRemoteDatasourcesImpl(sl()),
      )
      ..registerLazySingleton<WeatherRepository>(
        () => WeatherRepositoryImpl(
          sl(),
        ),
      )
      ..registerFactory(
        () => WheaterBloc(
          sl(),
          sl(),
        ),
      )
      ..registerFactory(
        () => ForecastBloc(sl()),
      )
      ..registerLazySingleton(() => GetForecastListUsecase(sl()))
      ..registerLazySingleton(() => SearchByCityNameUsecase(sl()))
      ..registerLazySingleton(() => GetCurrentWeatherUsecase(sl()));
  }
}
