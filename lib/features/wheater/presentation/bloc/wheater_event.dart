// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'wheater_bloc.dart';

abstract class WheaterEvent extends Equatable {
  const WheaterEvent();

  @override
  List<Object> get props => [];
}

class GetCurrentWeather extends WheaterEvent {
  final WeatherBody body;
  const GetCurrentWeather({
    required this.body,
  });
}

class SearchByCtyNameEvent extends WheaterEvent {
  final WeatherBody body;
  const SearchByCtyNameEvent({
    required this.body,
  });
}
