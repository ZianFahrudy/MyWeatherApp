// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forecast_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ForecastModel _$ForecastModelFromJson(Map<String, dynamic> json) =>
    ForecastModel(
      message: json['message'] as int,
      list: (json['list'] as List<dynamic>)
          .map((e) => DataForecastModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

DataForecastModel _$DataForecastModelFromJson(Map<String, dynamic> json) =>
    DataForecastModel(
      dt: json['dt'] as int,
      main: MainWheaterModel.fromJson(json['main'] as Map<String, dynamic>),
      weather: (json['weather'] as List<dynamic>)
          .map((e) => WheaterModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      dtTxt: DateTime.parse(json['dt_txt'] as String),
    );
