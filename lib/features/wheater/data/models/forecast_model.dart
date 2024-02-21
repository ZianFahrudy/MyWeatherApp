import 'package:json_annotation/json_annotation.dart';
import 'package:my_wheater_app/features/wheater/data/models/wheater_model.dart';
import 'package:my_wheater_app/features/wheater/domain/entities/forecast_entity.dart';

part 'forecast_model.g.dart';

@JsonSerializable(createToJson: false)
class ForecastModel extends ForecastEntity {
  const ForecastModel({
    required super.message,
    required List<DataForecastModel> super.list,
  });

  factory ForecastModel.fromJson(Map<String, dynamic> json) =>
      _$ForecastModelFromJson(json);
}

@JsonSerializable(createToJson: false, fieldRename: FieldRename.snake)
class DataForecastModel extends DataForecastEntity {
  const DataForecastModel({
    required super.dt,
    required MainWheaterModel super.main,
    required List<WheaterModel> super.weather,
    required super.dtTxt,
  });

  factory DataForecastModel.fromJson(Map<String, dynamic> json) =>
      _$DataForecastModelFromJson(json);
}
