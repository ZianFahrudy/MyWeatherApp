// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wheater_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CurrentWheaterModel _$CurrentWheaterModelFromJson(Map<String, dynamic> json) =>
    CurrentWheaterModel(
      coord: CoordModel.fromJson(json['coord'] as Map<String, dynamic>),
      weather: (json['weather'] as List<dynamic>)
          .map((e) => WheaterModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      basee: json['base'] as String?,
      main: MainWheaterModel.fromJson(json['main'] as Map<String, dynamic>),
      visibility: json['visibility'] as int?,
      wind: WindModel.fromJson(json['wind'] as Map<String, dynamic>),
      clouds: CloudsModel.fromJson(json['clouds'] as Map<String, dynamic>),
      dt: json['dt'] as int?,
      sys: SysModel.fromJson(json['sys'] as Map<String, dynamic>),
      timezone: json['timezone'] as int?,
      id: json['id'] as int?,
      name: json['name'] as String?,
      cod: json['cod'] as int?,
    );

CoordModel _$CoordModelFromJson(Map<String, dynamic> json) => CoordModel(
      lon: (json['lon'] as num?)?.toDouble(),
      lat: (json['lat'] as num?)?.toDouble(),
    );

WheaterModel _$WheaterModelFromJson(Map<String, dynamic> json) => WheaterModel(
      id: json['id'] as int?,
      main: json['main'] as String?,
      description: json['description'] as String?,
      icon: json['icon'] as String?,
    );

MainWheaterModel _$MainWheaterModelFromJson(Map<String, dynamic> json) =>
    MainWheaterModel(
      temp: (json['temp'] as num?)?.toDouble(),
      feelsLike: (json['feels_like'] as num?)?.toDouble(),
      tempMin: (json['temp_min'] as num?)?.toDouble(),
      tempMax: (json['temp_max'] as num?)?.toDouble(),
      pressure: json['pressure'] as int?,
      humidity: json['humidity'] as int?,
      seaLevel: json['sea_level'] as int?,
      grndLevel: json['grnd_level'] as int?,
    );

WindModel _$WindModelFromJson(Map<String, dynamic> json) => WindModel(
      speed: (json['speed'] as num?)?.toDouble(),
      deg: json['deg'] as int?,
      gust: (json['gust'] as num?)?.toDouble(),
    );

CloudsModel _$CloudsModelFromJson(Map<String, dynamic> json) => CloudsModel(
      all: json['all'] as int?,
    );

SysModel _$SysModelFromJson(Map<String, dynamic> json) => SysModel(
      type: json['type'] as int?,
      id: json['id'] as int?,
      country: json['country'] as String?,
      sunrise: json['sunrise'] as int?,
      sunset: json['sunset'] as int?,
    );
