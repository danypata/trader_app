import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:trader_app/src/common/api/api_configuration.dart';
import 'package:trader_app/src/forex/services/forex_exchange_data_source.dart';

part 'forex_exchange_api_data_source.g.dart';

@RestApi(parser: Parser.FlutterCompute)
abstract class ForexExchangeApiDataSource with ForexExchangeDataSource {
  factory ForexExchangeApiDataSource(Dio dio) = _ForexExchangeApiDataSource;

  @override
  @GET('forex/exchange')
  Future<List<String>> forexExchanges();
}

@Riverpod(keepAlive: true)
ForexExchangeApiDataSource forexExchangeApiDataSource(
  ForexExchangeApiDataSourceRef ref,
) {
  return ForexExchangeApiDataSource(ref.watch(traderAppDioProvider));
}
