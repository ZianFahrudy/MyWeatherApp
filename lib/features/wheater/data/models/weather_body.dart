import 'package:json_annotation/json_annotation.dart';

part 'weather_body.g.dart';

@JsonSerializable(createFactory: false)
class WeatherBody {
  WeatherBody({
    required this.appid,
    this.lat,
    this.lon,
    this.q,
  });
  final String? lat;
  final String? lon;
  final String appid;
  final String? q;

  Map<String, dynamic> toJson() => _$WeatherBodyToJson(this);
}
