import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:my_wheater_app/features/wheater/data/models/weather_body.dart';
import 'package:my_wheater_app/features/wheater/domain/entities/current_wheater_entity.dart';
import 'package:my_wheater_app/features/wheater/domain/usecases/get_current_weather_usecase.dart';
import 'package:my_wheater_app/features/wheater/domain/usecases/search_by_city_name_usecase.dart';

part 'wheater_event.dart';
part 'wheater_state.dart';

class WheaterBloc extends Bloc<WheaterEvent, WheaterState> {
  WheaterBloc(this.getCurrentWeatherUsecase, this.searchByCityNameUsecase)
      : super(WheaterInitial()) {
    on<GetCurrentWeather>(
      (event, emit) async {
        emit(WheaterLoading());

        final failureOrSuccess =
            await getCurrentWeatherUsecase.call(event.body);

        failureOrSuccess.fold(
          (error) => emit(WheaterFailure()),
          (r) => emit(WheaterSuccess(response: r)),
        );
      },
    );
    on<SearchByCtyNameEvent>(
      (event, emit) async {
        emit(WheaterLoading());

        final failureOrSuccess = await searchByCityNameUsecase.call(event.body);

        failureOrSuccess.fold(
          (error) => emit(WheaterFailure()),
          (r) => emit(WheaterSuccess(response: r)),
        );
      },
    );
  }

  GetCurrentWeatherUsecase getCurrentWeatherUsecase;
  SearchByCityNameUsecase searchByCityNameUsecase;
}
