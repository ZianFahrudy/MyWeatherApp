part of 'wheater_bloc.dart';

abstract class WheaterState extends Equatable {
  const WheaterState();

  @override
  List<Object> get props => [];
}

class WheaterInitial extends WheaterState {}

class WheaterLoading extends WheaterState {}

class WheaterSuccess extends WheaterState {
  const WheaterSuccess({
    required this.response,
  });
  final CurrentWeatherEntity response;
}

class WheaterFailure extends WheaterState {}
