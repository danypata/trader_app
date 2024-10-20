import 'dart:async';
import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:trader_app/src/symbols_list/services/symbols/models/symbol_data.dart';
import 'package:trader_app/src/symbols_list/services/trades/models/data_source_event.dart';
import 'package:trader_app/src/symbols_list/services/trades/models/trades_data.dart';
import 'package:trader_app/src/symbols_list/services/trades/trades_web_socket_data_source.dart';

import '../../../mocks/sink_mock.mocks.dart';

void main() {
  late TradesWebSocketDataSource tradesDataSource;
  late MockWebSocketChannel mockWebSocketChannel;
  late MockWebSocketSink mockWebSocketSink;

  setUp(() {
    mockWebSocketChannel = MockWebSocketChannel();
    mockWebSocketSink = MockWebSocketSink();
    when(mockWebSocketSink.add(any)).thenReturn(null);
    when(mockWebSocketChannel.sink).thenReturn(mockWebSocketSink);
    when(mockWebSocketChannel.ready).thenAnswer((_) {
      return Future.value(true);
    });
    tradesDataSource =
        TradesWebSocketDataSource(webSocketChannel: mockWebSocketChannel);
  });

  group('TradesWebSocketDataSource', () {
    test('Should connect to WebSocket and emit TradesData on valid data',
        () async {
      // Arrange
      final testJson = {
        'symbol': 'AAPL',
        'price': 150.0,
        'type': 'trade',
      };

      final tradesData = TradesData.fromJson(testJson);

      when(mockWebSocketChannel.stream).thenAnswer(
        (_) => Stream.value(jsonEncode(testJson)),
      );

      // Act
      await tradesDataSource.monitorSymbols([SymbolData(symbol: 'AAPL')]);

      // Assert
      await expectLater(
        tradesDataSource.events,
        emitsInOrder([
          isA<Data>().having((e) => e.data, 'data', tradesData),
        ]),
      );
    });

    test('Should emit error event on WebSocket error', () async {
      // Arrange
      final exception = Exception('WebSocket error');
      when(mockWebSocketChannel.stream).thenAnswer(
        (_) => Stream.error(exception),
      );

      // Act
      await tradesDataSource.monitorSymbols([SymbolData(symbol: 'AAPL')]);

      // Assert
      await expectLater(
        tradesDataSource.events,
        emitsInOrder([
          isA<Error>().having((e) => e.error, 'error', exception),
        ]),
      );
    });

    // TODO(dan): more test that use sink too.
  });
}
