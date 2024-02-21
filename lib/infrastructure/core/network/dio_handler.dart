import 'package:dio/dio.dart';
import 'package:my_wheater_app/infrastructure/core/config/env_config.dart';
import 'package:my_wheater_app/infrastructure/core/prefs/shared_prefs.dart';
import 'package:my_wheater_app/infrastructure/shared/constants/prefs_key.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioHandler {
  DioHandler({required this.config, required this.preferences});

  final EnvConfig config;
  final SharedPrefs preferences;

  Dio get dio => _getDio();

  Dio _getDio() {
    final header = <String, dynamic>{
      'isToken': preferences.isKeyExists(PrefsKey.accessToken),
    };

    final options = BaseOptions(
      baseUrl: config.apiBaseUrl ?? '',
      receiveDataWhenStatusError: true,
      headers: header,
    );

    final dio = Dio(options);

    dio.interceptors.addAll(<Interceptor>[
      _loggingInterceptor(),
      PrettyDioLogger(
        requestBody: true,
        requestHeader: true,
        responseHeader: true,
      ),
    ]);

    return dio;
  }

  Interceptor _loggingInterceptor() {
    return InterceptorsWrapper(
      onRequest: (options, handler) {
        final storageToken = preferences.getString(PrefsKey.accessToken);
        final headers = {
          'Authorization': 'Bearer $storageToken',
          'Accept': 'application/json',
        };

        if (options.headers.containsKey('isToken')) {
          options.headers.remove('isToken');
          options.headers.addAll(headers);
        }

        return handler.next(options); //continue
      },
      onResponse: (response, handler) {
        return handler.next(response); // continue
      },
      onError: (error, handler) async {
        return handler.next(error); //continue
      },
    );
  }
}
