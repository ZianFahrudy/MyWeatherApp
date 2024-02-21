// ignore_for_file: one_member_abstracts

import 'package:dartz/dartz.dart';
import 'package:my_wheater_app/features/wheater/data/models/weather_body.dart';
import 'package:my_wheater_app/features/wheater/domain/entities/current_wheater_entity.dart';
import 'package:my_wheater_app/features/wheater/domain/entities/forecast_entity.dart';
import 'package:my_wheater_app/infrastructure/error/failures.dart';

abstract class WeatherRepository {
  Future<Either<Failure, CurrentWeatherEntity>> getCurrentWheater(
    WeatherBody body,
  );
  Future<Either<Failure, ForecastEntity>> getForecastWeatherList(
    WeatherBody body,
  );
  Future<Either<Failure, CurrentWeatherEntity>> searchByCityName(
    WeatherBody body,
  );
}
