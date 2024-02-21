import 'package:json_annotation/json_annotation.dart';
import 'package:my_wheater_app/features/wheater/domain/entities/current_wheater_entity.dart';

part 'wheater_model.g.dart';

@JsonSerializable(createToJson: false, fieldRename: FieldRename.snake)
class CurrentWheaterModel extends CurrentWeatherEntity {
  const CurrentWheaterModel({
    required CoordModel super.coord,
    required List<WheaterModel> super.weather,
    required super.basee,
    required MainWheaterModel super.main,
    required super.visibility,
    required WindModel super.wind,
    required CloudsModel super.clouds,
    required super.dt,
    required SysModel super.sys,
    required super.timezone,
    required super.id,
    required super.name,
    required super.cod,
  });

  factory CurrentWheaterModel.fromJson(Map<String, dynamic> json) =>
      _$CurrentWheaterModelFromJson(json);
}

@JsonSerializable(createToJson: false, fieldRename: FieldRename.snake)
class CoordModel extends CoordEntity {
  const CoordModel({super.lon, super.lat});

  factory CoordModel.fromJson(Map<String, dynamic> json) =>
      _$CoordModelFromJson(json);
}

@JsonSerializable(createToJson: false, fieldRename: FieldRename.snake)
class WheaterModel extends WeatherEntity {
  const WheaterModel({
    super.id,
    super.main,
    super.description,
    super.icon,
  });

  factory WheaterModel.fromJson(Map<String, dynamic> json) =>
      _$WheaterModelFromJson(json);
}

@JsonSerializable(createToJson: false, fieldRename: FieldRename.snake)
class MainWheaterModel extends MainWheaterEntity {
  const MainWheaterModel({
    super.temp,
    super.feelsLike,
    super.tempMin,
    super.tempMax,
    super.pressure,
    super.humidity,
    super.seaLevel,
    super.grndLevel,
  });

  factory MainWheaterModel.fromJson(Map<String, dynamic> json) =>
      _$MainWheaterModelFromJson(json);
}

@JsonSerializable(createToJson: false, fieldRename: FieldRename.snake)
class WindModel extends WindEntity {
  const WindModel({
    super.speed,
    super.deg,
    super.gust,
  });

  factory WindModel.fromJson(Map<String, dynamic> json) =>
      _$WindModelFromJson(json);
}

@JsonSerializable(createToJson: false, fieldRename: FieldRename.snake)
class CloudsModel extends CloudsEntity {
  const CloudsModel({super.all});

  factory CloudsModel.fromJson(Map<String, dynamic> json) =>
      _$CloudsModelFromJson(json);
}

@JsonSerializable(createToJson: false, fieldRename: FieldRename.snake)
class SysModel extends SysEntity {
  const SysModel({
    super.type,
    super.id,
    super.country,
    super.sunrise,
    super.sunset,
  });

  factory SysModel.fromJson(Map<String, dynamic> json) =>
      _$SysModelFromJson(json);
}
