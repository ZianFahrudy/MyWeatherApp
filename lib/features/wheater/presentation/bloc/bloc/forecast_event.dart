// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'forecast_bloc.dart';

sealed class ForecastEvent extends Equatable {
  const ForecastEvent();

  @override
  List<Object> get props => [];
}

class GetForecastList extends ForecastEvent {
  final WeatherBody body;
  const GetForecastList({
    required this.body,
  });
}
