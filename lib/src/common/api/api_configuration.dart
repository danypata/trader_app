import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:trader_app/gen/app_config.gen.dart';

part 'api_configuration.g.dart';

const _authHeaderKey = 'X-Finnhub-Token';

@Riverpod(keepAlive: true)
Dio traderAppDio(TraderAppDioRef ref) {
  final headers = <String, String>{
    _authHeaderKey: AppConfig.finhubToken,
  };

  final dio = Dio(
    BaseOptions(
      // the parameter is not loaded yet so the compiler thinks it's empty.
      //ignore: avoid_redundant_argument_values
      baseUrl: AppConfig.finhubApiUrl,
      headers: headers,
      connectTimeout: const Duration(milliseconds: 30000),
      receiveTimeout: const Duration(milliseconds: 61000),
      sendTimeout: const Duration(milliseconds: 30000),
    ),
  );
  dio.interceptors.addAll([
    LogInterceptor(
      responseHeader: false,
      logPrint: (text) {
        if (kDebugMode) {
          debugPrint(text.toString());
        }
      },
    ),
  ]);
  dio.httpClientAdapter = HttpClientAdapter();
  return dio;
}

enum ApiAuthorization { none, basic, token }
