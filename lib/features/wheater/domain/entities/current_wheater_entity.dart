// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

class CurrentWeatherEntity extends Equatable {
  final CoordEntity? coord;
  final List<WeatherEntity>? weather;
  @JsonKey(name: 'base')
  final String? basee;
  final MainWheaterEntity? main;
  final int? visibility;
  final WindEntity? wind;
  final CloudsEntity? clouds;
  final int? dt;
  final SysEntity? sys;
  final int? timezone;
  final int? id;
  final String? name;
  final int? cod;
  const CurrentWeatherEntity({
    this.coord,
    this.weather,
    this.basee,
    this.main,
    this.visibility,
    this.wind,
    this.clouds,
    this.dt,
    this.sys,
    this.timezone,
    this.id,
    this.name,
    this.cod,
  });

  @override
  List<Object?> get props {
    return [
      coord,
      weather,
      main,
      visibility,
      wind,
      clouds,
      dt,
      sys,
      timezone,
      id,
      name,
      cod,
    ];
  }
}

class CoordEntity extends Equatable {
  final double? lon;
  final double? lat;
  const CoordEntity({
    this.lon,
    this.lat,
  });

  @override
  List<Object?> get props => [lon, lat];
}

class WeatherEntity extends Equatable {
  final int? id;
  final String? main;
  final String? description;
  final String? icon;
  const WeatherEntity({
    this.id,
    this.main,
    this.description,
    this.icon,
  });

  @override
  List<Object?> get props => [id, main, description, icon];
}

class MainWheaterEntity extends Equatable {
  final double? temp;
  final double? feelsLike;
  final double? tempMin;
  final double? tempMax;
  final int? pressure;
  final int? humidity;
  final int? seaLevel;
  final int? grndLevel;
  const MainWheaterEntity({
    this.temp,
    this.feelsLike,
    this.tempMin,
    this.tempMax,
    this.pressure,
    this.humidity,
    this.seaLevel,
    this.grndLevel,
  });
  @override
  List<Object?> get props {
    return [
      temp,
      feelsLike,
      tempMin,
      tempMax,
      pressure,
      humidity,
      seaLevel,
      grndLevel,
    ];
  }
}

class WindEntity extends Equatable {
  final double? speed;
  final int? deg;
  final double? gust;
  const WindEntity({
    this.speed,
    this.deg,
    this.gust,
  });

  @override
  List<Object?> get props => [speed, deg, gust];
}

class CloudsEntity extends Equatable {
  final int? all;
  const CloudsEntity({
    this.all,
  });

  @override
  List<Object?> get props => [all];
}

class SysEntity extends Equatable {
  final int? type;
  final int? id;
  final String? country;
  final int? sunrise;
  final int? sunset;
  const SysEntity({
    this.type,
    this.id,
    this.country,
    this.sunrise,
    this.sunset,
  });

  @override
  List<Object?> get props {
    return [
      type,
      id,
      country,
      sunrise,
      sunset,
    ];
  }
}
