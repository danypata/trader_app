import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:trader_app/gen/app_config.gen.dart';
import 'package:trader_app/src/symbols_list/services/symbols/models/symbol_data.dart';
import 'package:trader_app/src/symbols_list/services/symbols/symbols_api_data_source.dart';

void main() {
  final dio = Dio();
  final dioAdapter = DioAdapter(dio: dio);
  late String baseUrl;

  setUp(() {
    dio.httpClientAdapter = dioAdapter;
    baseUrl = AppConfig.finhubApiUrl;
  });

  group('SymbolsApiDataSource', () {
    group('symbols()', () {
      test('Should parse data correctly', () async {
        dioAdapter.onGet(
          '$baseUrl$testPath',
          (request) {
            return request.reply(200, defaultSuccessMessage);
          },
        );

        final service = SymbolsApiDataSource(
          dio,
        );

        final response = await service.symbols('test');

        expect(response.length, 4);

        expect(response, isA<List<SymbolData>>());
      });

      test('Should parse data correctly if other fields are present', () async {
        dioAdapter.onGet(
          '$baseUrl$testPath',
          (request) {
            return request.reply(200, extraFieldsSuccessMessage);
          },
        );

        final service = SymbolsApiDataSource(
          dio,
        );

        final response = await service.symbols('test');

        expect(response.length, 1);
        expect(response, isA<List<SymbolData>>());
        for (final el in response) {
          expect(el.description, isNotNull);
          expect(el.symbol, isNotNull);
          expect(el.displaySymbol, isNotNull);
        }
      });

      test("Null data shouldn't crash parsing", () async {
        dioAdapter.onGet(
          '$baseUrl$testPath',
          (request) {
            return request.reply(200, extraFieldsSuccessMessage);
          },
        );

        final service = SymbolsApiDataSource(
          dio,
        );

        final response = await service.symbols('test');

        expect(response.length, 1);
        expect(response, isA<List<SymbolData>>());
        for (final el in response) {
          expect(el.description, isNotNull);
          expect(el.symbol, isNotNull);
          expect(el.displaySymbol, isNotNull);
        }
      });

      test('Should  throw error if bad status code', () async {
        dioAdapter.onGet(
          '$baseUrl$testPath',
          (request) {
            request.throws(401, DioException(requestOptions: RequestOptions()));
          },
        );

        final service = SymbolsApiDataSource(
          dio,
        );

        expect(
          () => service.symbols('test'),
          throwsA(const TypeMatcher<DioException>()),
        );
      });
    });
  });
}

const extraFieldsSuccessMessage = [
  {
    'description': 'Oanda AUD/USD',
    'displaySymbol': 'AUD/USD',
    'symbol': 'OANDA:AUD_USD',
    'randomField': 'random',
  },
];

const extraFieldsNulled = [
  {
    'description': null,
    'displaySymbol': null,
    'symbol': null,
  },
];

const defaultSuccessMessage = [
  {
    'description': 'Oanda AUD/USD',
    'displaySymbol': 'AUD/USD',
    'symbol': 'OANDA:AUD_USD',
  },
  {
    'description': 'Oanda UK 100',
    'displaySymbol': 'UK100/GBP',
    'symbol': 'OANDA:UK100_GBP',
  },
  {
    'description': 'Oanda GBP/HKD',
    'displaySymbol': 'GBP/HKD',
    'symbol': 'OANDA:GBP_HKD',
  },
  {
    'description': 'Oanda HKD/JPY',
    'displaySymbol': 'HKD/JPY',
    'symbol': 'OANDA:HKD_JPY',
  },
];
const testPath = 'forex/symbol';
