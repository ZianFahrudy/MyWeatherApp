import 'package:dartz/dartz.dart';
import 'package:my_wheater_app/features/wheater/data/models/weather_body.dart';
import 'package:my_wheater_app/features/wheater/domain/entities/forecast_entity.dart';
import 'package:my_wheater_app/features/wheater/domain/repositories/wheater_repository.dart';
import 'package:my_wheater_app/infrastructure/core/usecase/usecase.dart';
import 'package:my_wheater_app/infrastructure/error/failures.dart';

class GetForecastListUsecase extends UseCase<ForecastEntity, WeatherBody> {
  GetForecastListUsecase(this._repository);
  final WeatherRepository _repository;

  @override
  Future<Either<Failure, ForecastEntity>> call(WeatherBody params) {
    return _repository.getForecastWeatherList(params);
  }
}
