import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:retrofit/retrofit.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:trader_app/src/common/api/api_configuration.dart';
import 'package:trader_app/src/symbols_list/services/symbols/models/symbol_data.dart';
import 'package:trader_app/src/symbols_list/services/symbols/symbols_data_source.dart';

part 'symbols_api_data_source.g.dart';

@RestApi(parser: Parser.FlutterCompute)
abstract class SymbolsApiDataSource with SymbolsDataSource {
  factory SymbolsApiDataSource(Dio dio) = _SymbolsApiDataSource;

  @override
  @GET('forex/symbol')
  Future<List<SymbolData>> symbols(@Query('exchange') String exchange);
}

@Riverpod(keepAlive: true)
SymbolsApiDataSource symbolsApiDataSource(SymbolsApiDataSourceRef ref) {
  return SymbolsApiDataSource(ref.watch(traderAppDioProvider));
}
