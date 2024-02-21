// ignore_for_file: one_member_abstracts

import 'package:dio/dio.dart';
import 'package:my_wheater_app/features/wheater/data/models/forecast_model.dart';
import 'package:my_wheater_app/features/wheater/data/models/weather_body.dart';
import 'package:my_wheater_app/features/wheater/data/models/wheater_model.dart';
import 'package:my_wheater_app/features/wheater/domain/entities/current_wheater_entity.dart';
import 'package:my_wheater_app/features/wheater/domain/entities/forecast_entity.dart';
import 'package:my_wheater_app/infrastructure/error/exception.dart';
import 'package:my_wheater_app/infrastructure/shared/constants/api_path.dart';

abstract class WeatherRemoteDatasources {
  Future<CurrentWeatherEntity> getCurrentWheater(WeatherBody body);
  Future<ForecastEntity> getForecastList(WeatherBody body);
  Future<CurrentWeatherEntity> searchByCityName(WeatherBody body);
}

class WeatherRemoteDatasourcesImpl implements WeatherRemoteDatasources {
  WeatherRemoteDatasourcesImpl(this._client);
  final Dio _client;
  @override
  Future<CurrentWeatherEntity> getCurrentWheater(WeatherBody body) async {
    try {
      final response = await _client.get<Map<String, dynamic>>(
        ApiPath.wheater,
        queryParameters: body.toJson(),
      );

      return CurrentWheaterModel.fromJson(response.data!);
    } on DioException catch (e) {
      throw DioException(
        requestOptions: e.requestOptions,
        error: e.error,
        response: e.response,
      );
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<ForecastEntity> getForecastList(WeatherBody body) async {
    try {
      final response = await _client.get<Map<String, dynamic>>(
        ApiPath.forecast,
        queryParameters: body.toJson(),
      );

      return ForecastModel.fromJson(response.data!);
    } on DioException catch (e) {
      throw DioException(
        requestOptions: e.requestOptions,
        error: e.error,
        response: e.response,
      );
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<CurrentWeatherEntity> searchByCityName(WeatherBody body) async {
    try {
      final response = await _client.get<Map<String, dynamic>>(
        ApiPath.wheater,
        queryParameters: body.toJson(),
      );

      return CurrentWheaterModel.fromJson(response.data!);
    } on DioException catch (e) {
      throw DioException(
        requestOptions: e.requestOptions,
        error: e.error,
        response: e.response,
      );
    } catch (e) {
      throw ServerException();
    }
  }
}
