// ignore_for_file: lines_longer_than_80_chars

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:good_search_appbar/good_search_appbar.dart';
import 'package:my_wheater_app/features/wheater/data/models/weather_body.dart';
import 'package:my_wheater_app/features/wheater/presentation/bloc/wheater_bloc.dart';
import 'package:my_wheater_app/infrastructure/core/di/injection.dart';
import 'package:my_wheater_app/infrastructure/shared/constants/constants.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    final weatherBloc = sl<WheaterBloc>();
    return BlocProvider(
      create: (context) => weatherBloc,
      child: Scaffold(
        appBar: GoodSearchAppBar(
          title: 'Search City Name',
          onSearchChanged: (v) {
            weatherBloc.add(
              SearchByCtyNameEvent(
                body: WeatherBody(appid: Constants.apiKey, q: v),
              ),
            );
          },
        ),
        body: BlocBuilder<WheaterBloc, WheaterState>(
          builder: (context, state) {
            if (state is WheaterSuccess) {
              final data = state.response;
              return Card(
                color: const Color(0xff000435),
                child: Row(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.width / 2.2,
                      child: Image.network(
                        'https://openweathermap.org/img/wn/${data.weather![0].icon!}@4x.png',
                      ),
                    ),
                    const Gap(20),
                    Column(
                      // mainAxisAlignment: MainAxisAlignment.center,

                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '${(data.main!.temp! - 273.15).round()}',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: MediaQuery.of(context).size.width / 5,
                                color: Colors.white,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                bottom: 30,
                              ),
                              child: Text(
                                '°C',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize:
                                      MediaQuery.of(context).size.width / 10,
                                  color: Colors.yellow,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          'Feels Like ${(data.main!.feelsLike! - 273.15).round()} °C',
                          textAlign: TextAlign.start,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: Colors.white,
                          ),
                        ),
                        const Gap(20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          // mainAxisSize: MainAxisSize.min,
                          children: [
                            Column(
                              children: [
                                const Icon(
                                  Icons.air,
                                  color: Colors.white,
                                ),
                                Text(
                                  '${data.wind!.speed!} km/h',
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                const Text(
                                  'Wind',
                                  style: TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                            const Gap(20),
                            Column(
                              children: [
                                const Icon(
                                  Icons.cloud_circle,
                                  color: Colors.white,
                                ),
                                Text(
                                  '${data.main!.humidity!} %',
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                const Text(
                                  'Humidity',
                                  style: TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              );
            } else if (state is WheaterLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            return const Center(
              child: Text('No Data'),
            );
          },
        ),
      ),
    );
  }
}
