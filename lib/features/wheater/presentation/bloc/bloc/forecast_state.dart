// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'forecast_bloc.dart';

sealed class ForecastState extends Equatable {
  const ForecastState();

  @override
  List<Object> get props => [];
}

final class ForecastInitial extends ForecastState {}

final class ForecastLoading extends ForecastState {}

final class ForecastFailure extends ForecastState {}

class ForecastSuccess extends ForecastState {
  final ForecastEntity response;
  const ForecastSuccess({
    required this.response,
  });
}
