import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:trader_app/src/symbols_list/repo/models/symbols_event.dart';
import 'package:trader_app/src/symbols_list/repo/symbols_repo.dart';
import 'package:trader_app/src/symbols_list/services/symbols/models/symbol_data.dart';
import 'package:trader_app/src/symbols_list/services/symbols/symbols_data_source.dart';
import 'package:trader_app/src/symbols_list/services/trades/models/data_source_event.dart';
import 'package:trader_app/src/symbols_list/services/trades/models/trade_data_type.dart';
import 'package:trader_app/src/symbols_list/services/trades/models/trades_data.dart';
import 'package:trader_app/src/symbols_list/services/trades/trades_data_source.dart';

import 'symbols_repo_test.mocks.dart';

// Generate Mocks for the dependencies
@GenerateNiceMocks(
  [MockSpec<SymbolsDataSource>(), MockSpec<TradesDataSource>()],
)
void main() {
  late SymbolsRepo symbolsRepo;
  late MockSymbolsDataSource mockSymbolsDataSource;
  late MockTradesDataSource mockTradesDataSource;

  setUp(() {
    mockSymbolsDataSource = MockSymbolsDataSource();
    mockTradesDataSource = MockTradesDataSource();
    symbolsRepo = SymbolsRepo(
      symbolsDataSource: mockSymbolsDataSource,
      tradesDatasource: mockTradesDataSource,
    );
  });

  group('SymbolsRepo', () {
    test('should load symbols and update watchlist', () async {
      // Arrange
      final mockSymbols = [
        SymbolData(symbol: 'AAPL', description: 'Apple'),
        SymbolData(symbol: 'GOOG', description: 'Google'),
      ];
      when(mockSymbolsDataSource.symbols('NASDAQ'))
          .thenAnswer((_) async => mockSymbols);

      // Act
      final result = await symbolsRepo.loadSymbols('NASDAQ');

      // Assert
      expect(result, isNotEmpty);
      // expect(symbolsRepo._loadedSymbols['AAPL'], isNotNull);
      // expect(symbolsRepo._loadedSymbols['GOOG'], isNotNull);
      verify(mockTradesDataSource.monitorSymbols(any)).called(1);
    });

    test('should add symbols to the watchlist and notify', () {
      // Arrange
      final symbolData = SymbolData(symbol: 'AAPL', description: 'Apple');
      symbolsRepo.addToWatchList(symbols: [symbolData]);

      // Assert
      // expect(symbolsRepo._watchedSymbols.containsKey('AAPL'), true);
      verify(mockTradesDataSource.monitorSymbols([symbolData])).called(1);
    });

    test('should remove symbols from the watchlist', () {
      // Arrange
      final symbolData = SymbolData(symbol: 'AAPL', description: 'Apple');
      symbolsRepo
        ..addToWatchList(symbols: [symbolData])

        // Act
        ..removeFromWatchList(symbols: [symbolData]);

      // Assert
      // expect(symbolsRepo._watchedSymbols.containsKey('AAPL'), false);
      verify(mockTradesDataSource.ignoreSymbols([symbolData])).called(1);
    });

    test('should toggle symbol watch status', () {
      // Arrange
      final symbolData = SymbolData(symbol: 'AAPL', description: 'Apple');
      symbolsRepo
        ..addToWatchList(symbols: [symbolData])

        // Act
        ..toggleWatch('AAPL');

      // Assert
      verify(mockTradesDataSource.ignoreSymbols([symbolData])).called(1);
    });

    test('should emit trades events', () {
      // Arrange
      final dataEvent = DataSourceEvent.data(
        const TradesData(data: [], type: TradeDataType.trade),
      );
      when(mockTradesDataSource.events)
          .thenAnswer((_) => Stream.fromIterable([dataEvent]));

      // Act
      final result = symbolsRepo.trades;

      // Assert
      expect(result, emits(isA<SymbolsEvent>()));
    });
  });
}
