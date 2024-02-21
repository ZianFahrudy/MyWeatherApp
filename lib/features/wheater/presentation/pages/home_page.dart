// ignore_for_file: use_if_null_to_convert_nulls_to_bools, lines_longer_than_80_chars, inference_failure_on_instance_creation

import 'dart:async';
import 'dart:developer';

import 'package:fl_location/fl_location.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:my_wheater_app/features/wheater/data/models/weather_body.dart';
import 'package:my_wheater_app/features/wheater/presentation/bloc/bloc/forecast_bloc.dart';
import 'package:my_wheater_app/features/wheater/presentation/bloc/wheater_bloc.dart';
import 'package:my_wheater_app/features/wheater/presentation/pages/search_page.dart';
import 'package:my_wheater_app/infrastructure/core/di/injection.dart';
import 'package:my_wheater_app/infrastructure/shared/constants/constants.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final weatherBloc = sl<WheaterBloc>();
  final forecastBloc = sl<ForecastBloc>();

  final latitude = ValueNotifier<double?>(-8.69331173310052);
  final longitude = ValueNotifier<double?>(116.56669154232955);

  final isGetLocation = ValueNotifier<bool>(false);

  final city = ValueNotifier<String>('selong');

  final selectedTemp = ValueNotifier<int>(1);

  Future<bool> _checkAndRequestPermission({bool? background}) async {
    if (!await FlLocation.isLocationServicesEnabled) {
      // Location services are disabled.
      return false;
    }

    var locationPermission = await FlLocation.checkLocationPermission();
    if (locationPermission == LocationPermission.deniedForever) {
      // Cannot request runtime permission because location permission is denied forever.
      return false;
    } else if (locationPermission == LocationPermission.denied) {
      // Ask the user for location permission.
      locationPermission = await FlLocation.requestLocationPermission();
      if (locationPermission == LocationPermission.denied ||
          locationPermission == LocationPermission.deniedForever) return false;
    }

    // Location permission must always be allowed (LocationPermission.always)
    // to collect location data in the background.
    if (background == true &&
        locationPermission == LocationPermission.whileInUse) return false;

    // Location services has been enabled and permission have been granted.

    if (locationPermission != LocationPermission.denied ||
        locationPermission != LocationPermission.deniedForever) {
      // _getLocation();
    }

    // _listenLocationStream();

    return true;
  }

  StreamSubscription<Location>? _locationSubscription;

  Future<void> _listenLocationStream() async {
    isGetLocation.value = true;

    if (await _checkAndRequestPermission()) {
      if (_locationSubscription != null) await _cancelLocationSubscription();

      _locationSubscription = FlLocation.getLocationStream()
          .handleError(_handleError)
          .listen((event) {
        longitude.value = event.longitude;
        latitude.value = event.latitude;

        if (isGetLocation.value) {
          weatherBloc.add(
            GetCurrentWeather(
              body: WeatherBody(
                lat: latitude.value.toString(),
                lon: longitude.value.toString(),
                appid: Constants.apiKey,
              ),
            ),
          );

          forecastBloc.add(
            GetForecastList(
              body: WeatherBody(
                lat: latitude.value.toString(),
                lon: longitude.value.toString(),
                appid: Constants.apiKey,
              ),
            ),
          );
        } else {
          Future<void>.delayed(const Duration(minutes: 60)).then((value) {
            weatherBloc.add(
              GetCurrentWeather(
                body: WeatherBody(
                  lat: latitude.value.toString(),
                  lon: longitude.value.toString(),
                  appid: Constants.apiKey,
                ),
              ),
            );
          });
        }
        isGetLocation.value = false;
      });
    }
  }

  Future<void> _cancelLocationSubscription() async {
    await _locationSubscription?.cancel();
    _locationSubscription = null;
  }

  void _handleError(dynamic error, StackTrace stackTrace) {
    log('error: $error');
  }

  @override
  void initState() {
    // _checkAndRequestPermission();
    _listenLocationStream();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => weatherBloc,
        ),
        BlocProvider(
          create: (context) => forecastBloc,
        ),
      ],
      child: Scaffold(
        backgroundColor: const Color(0xff000435),
        appBar: AppBar(
          backgroundColor: const Color(0xff000435),
          centerTitle: true,
          title: Text(
            DateFormat('EEEE, dd MMMM').format(DateTime.now()),
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.search),
          onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const SearchPage()),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SafeArea(
            child: BlocBuilder<WheaterBloc, WheaterState>(
              builder: (context, state) {
                if (state is WheaterSuccess) {
                  final data = state.response;
                  return Column(
                    children: [
                      Column(
                        children: [
                          Text(
                            data.name!,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            '${data.weather![0].main!} (${data.weather![0].description!})',
                            style: const TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 15,
                              color: Colors.white,
                            ),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.width /
                                              2.2,
                                      child: Image.network(
                                        'https://openweathermap.org/img/wn/${data.weather![0].icon!}@4x.png',
                                      ),
                                    ),
                                    DropdownButtonFormField<int>(
                                      dropdownColor: const Color(0xff000435)
                                          .withOpacity(0.1),
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      value: 1,
                                      items: const [
                                        DropdownMenuItem(
                                          value: 1,
                                          child: Text('Celcius'),
                                        ),
                                        DropdownMenuItem(
                                          value: 2,
                                          child: Text('Fahrenheit'),
                                        ),
                                      ],
                                      onChanged: (v) {
                                        setState(() {
                                          selectedTemp.value = v!;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              const Gap(20),
                              Expanded(
                                child: Column(
                                  // mainAxisAlignment: MainAxisAlignment.center,

                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          selectedTemp.value == 1
                                              ? '${(data.main!.temp! - 273.15).round()}'
                                              : '${(((data.main!.temp! - 273.15) * 9 / 5) + 32).round()}',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                5,
                                            color: Colors.white,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            bottom: 30,
                                          ),
                                          child: Text(
                                            selectedTemp.value == 1
                                                ? '°C'
                                                : '°F',
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  10,
                                              color: Colors.yellow,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      selectedTemp.value == 1
                                          ? 'Feels Like ${(data.main!.feelsLike! - 273.15).round()} °C'
                                          : 'Feels Like ${(((data.main!.temp! - 273.15) * 9 / 5) + 32).round()} °F',
                                      textAlign: TextAlign.start,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const Gap(20),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                              ),
                            ],
                          ),
                        ],
                      ),
                      const Gap(30),
                      BlocBuilder<ForecastBloc, ForecastState>(
                        builder: (context, state) {
                          if (state is ForecastSuccess) {
                            final data = state.response.list;
                            return SizedBox(
                              height: 100,
                              // width: 100,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: data.length,
                                itemBuilder: (context, i) => Container(
                                  margin: const EdgeInsets.only(right: 10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Colors.white,
                                  ),
                                  padding: const EdgeInsets.all(10),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            selectedTemp.value == 1
                                                ? '${(data[i].main.temp! - 273.15).round()}'
                                                : '${(((data[i].main.temp! - 273.15) * 9 / 5) + 32).round()}',
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15,
                                              // color: Colors.white,
                                            ),
                                          ),
                                          Text(
                                            selectedTemp.value == 1
                                                ? '°C'
                                                : '°F',
                                            textAlign: TextAlign.start,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 13,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        data[i].weather[0].main!,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 12,
                                        ),
                                      ),
                                      Text(
                                        DateFormat('EEEE')
                                            .format(data[i].dtTxt),
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        DateFormat('dd MMM HH:mm')
                                            .format(data[i].dtTxt),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          } else {
                            return const CircularProgressIndicator();
                          }
                        },
                      ),
                    ],
                  );
                } else if (state is WheaterFailure) {
                  return const Center(child: Text('Failure'));
                }
                return const Center(child: CircularProgressIndicator());
              },
            ),
          ),
        ),
      ),
    );
  }
}
