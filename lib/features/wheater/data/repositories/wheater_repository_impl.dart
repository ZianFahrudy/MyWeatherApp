import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:my_wheater_app/features/wheater/data/datasources/wheater_remote_datasources.dart';
import 'package:my_wheater_app/features/wheater/data/models/weather_body.dart';
import 'package:my_wheater_app/features/wheater/domain/entities/current_wheater_entity.dart';
import 'package:my_wheater_app/features/wheater/domain/entities/forecast_entity.dart';
import 'package:my_wheater_app/features/wheater/domain/repositories/wheater_repository.dart';
import 'package:my_wheater_app/infrastructure/error/failures.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  WeatherRepositoryImpl(this.remoteDatasources);
  final WeatherRemoteDatasources remoteDatasources;

  @override
  Future<Either<Failure, CurrentWeatherEntity>> getCurrentWheater(
    WeatherBody body,
  ) async {
    try {
      final remoteLogin = await remoteDatasources.getCurrentWheater(body);

      return Right(remoteLogin);
    } on DioException catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        return Left(
          ServerFailure.fromJson(e.response!.data as Map<String, dynamic>),
        );
      } else {
        // Something happened in setting up or sending the request
        //that triggered an Error
        return Left(ServerFailure(e.message!));
      }
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ForecastEntity>> getForecastWeatherList(
    WeatherBody body,
  ) async {
    try {
      final remoteLogin = await remoteDatasources.getForecastList(body);

      return Right(remoteLogin);
    } on DioException catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        return Left(
          ServerFailure.fromJson(e.response!.data as Map<String, dynamic>),
        );
      } else {
        // Something happened in setting up or sending the request
        //that triggered an Error
        return Left(ServerFailure(e.message!));
      }
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, CurrentWeatherEntity>> searchByCityName(
    WeatherBody body,
  ) async {
    try {
      final remoteLogin = await remoteDatasources.searchByCityName(body);

      return Right(remoteLogin);
    } on DioException catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        return Left(
          ServerFailure.fromJson(e.response!.data as Map<String, dynamic>),
        );
      } else {
        // Something happened in setting up or sending the request
        //that triggered an Error
        return Left(ServerFailure(e.message!));
      }
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
