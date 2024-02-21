// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:my_wheater_app/features/wheater/domain/entities/current_wheater_entity.dart';

class ForecastEntity extends Equatable {
  final int message;
  final List<DataForecastEntity> list;
  const ForecastEntity({
    required this.message,
    required this.list,
  });
  @override
  List<Object> get props => [message, list];
}

class DataForecastEntity extends Equatable {
  final int dt;
  final MainWheaterEntity main;
  final List<WeatherEntity> weather;
  final DateTime dtTxt;
  const DataForecastEntity({
    required this.dt,
    required this.main,
    required this.weather,
    required this.dtTxt,
  });
  @override
  List<Object> get props => [dt, main, weather, dtTxt];
}
