import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:my_wheater_app/features/wheater/data/models/weather_body.dart';
import 'package:my_wheater_app/features/wheater/domain/entities/forecast_entity.dart';
import 'package:my_wheater_app/features/wheater/domain/usecases/get_forecast_usecase.dart';

part 'forecast_event.dart';
part 'forecast_state.dart';

class ForecastBloc extends Bloc<ForecastEvent, ForecastState> {
  ForecastBloc(this.getForecastListUsecase) : super(ForecastInitial()) {
    on<GetForecastList>(
      (event, emit) async {
        emit(ForecastLoading());

        final failureOrSuccess = await getForecastListUsecase.call(event.body);

        failureOrSuccess.fold(
          (l) => emit(ForecastFailure()),
          (r) => emit(ForecastSuccess(response: r)),
        );
      },
    );
  }

  final GetForecastListUsecase getForecastListUsecase;
}
