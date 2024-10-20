import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rxdart/rxdart.dart';
import 'package:trader_app/src/common/ws/web_socket_config.dart';
import 'package:trader_app/src/symbols_list/services/symbols/models/symbol_data.dart';
import 'package:trader_app/src/symbols_list/services/trades/models/data_source_event.dart';
import 'package:trader_app/src/symbols_list/services/trades/models/monitor_message.dart';
import 'package:trader_app/src/symbols_list/services/trades/models/monitor_message_type.dart';
import 'package:trader_app/src/symbols_list/services/trades/models/trades_data.dart';
import 'package:trader_app/src/symbols_list/services/trades/trades_data_source.dart';
import 'package:web_socket_channel/status.dart' as status;
import 'package:web_socket_channel/web_socket_channel.dart';

part 'trades_web_socket_data_source.g.dart';

class TradesWebSocketDataSource extends TradesDataSource {
  TradesWebSocketDataSource({
    required WebSocketChannel webSocketChannel,
  }) : _webSocketChannel = webSocketChannel;

  bool _isConnected = false;
  final PublishSubject<DataSourceEvent> _eventStream = PublishSubject();

  @override
  Stream<DataSourceEvent> get events => _eventStream;

  StreamSubscription<DataSourceEvent>? _streamSubscription;

  final WebSocketChannel _webSocketChannel;

  Future<void> _connect() async {
    if (_isConnected) {
      return;
    }
    try {
      await _webSocketChannel.ready;
      _isConnected = true;
      _streamSubscription = _webSocketChannel.stream
          .map((data) => jsonDecode(data.toString()))
          .map((test) => Map<String, dynamic>.from(test as Map))
          .map((json) {
        return DataSourceEvent.data(TradesData.fromJson(json));
      }).onErrorReturnWith((err, stack) {
        return DataSourceEvent.error(err);
      }).listen(_eventStream.add);
    } on SocketException catch (e) {
      _eventStream.add(DataSourceEvent.error(e));
    } on WebSocketChannelException catch (e) {
      _eventStream.add(DataSourceEvent.error(e));
    } on Exception catch (e) {
      _eventStream.add(DataSourceEvent.error(e));
    }
  }

  Future<void> _internalDisconnect() async {
    await _webSocketChannel.sink.close(status.normalClosure);
    await _streamSubscription?.cancel();
    _streamSubscription = null;
  }

  @override
  Future<void> disconnect() async {
    await _internalDisconnect();
    _isConnected = false;
    _eventStream.add(DataSourceEvent.disconnected());
  }

  @override
  Future<void> monitorSymbols(List<SymbolData> symbols) async {
    await _connect();
    _sendSymbolsWithType(symbols, MonitorMessageType.monitor);
  }

  @override
  void ignoreSymbols(List<SymbolData> symbols) {
    _sendSymbolsWithType(symbols, MonitorMessageType.ignore);
  }

  void _sendSymbolsWithType(List<SymbolData> symbols, MonitorMessageType type) {
    symbols
        .where((el) => el.symbol != null && el.symbol!.isNotEmpty)
        .map((el) => el.symbol!)
        .map(
          (el) => MonitorMessage(type: type, symbol: el),
        )
        .forEach((message) {
      _webSocketChannel.sink.add(jsonEncode(message.toJson()));
    });
  }
}

@Riverpod()
TradesWebSocketDataSource tradesWebSocketDataSource(
  TradesWebSocketDataSourceRef ref,
  int id,
) {
  return TradesWebSocketDataSource(
    webSocketChannel: ref.read(webSocketChannelProvider(id)),
  );
}
