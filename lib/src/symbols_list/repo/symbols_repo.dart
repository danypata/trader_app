import 'dart:math';

import 'package:built_collection/built_collection.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rxdart/rxdart.dart';
import 'package:trader_app/src/symbols_list/repo/models/symbols_event.dart';
import 'package:trader_app/src/symbols_list/repo/models/symbols_info.dart';
import 'package:trader_app/src/symbols_list/services/symbols/models/symbol_data.dart';
import 'package:trader_app/src/symbols_list/services/symbols/symbols_api_data_source.dart';
import 'package:trader_app/src/symbols_list/services/symbols/symbols_data_source.dart';
import 'package:trader_app/src/symbols_list/services/trades/models/data_source_event.dart';
import 'package:trader_app/src/symbols_list/services/trades/models/trade_data_type.dart';
import 'package:trader_app/src/symbols_list/services/trades/models/trades_data.dart';
import 'package:trader_app/src/symbols_list/services/trades/trades_data_source.dart';
import 'package:trader_app/src/symbols_list/services/trades/trades_web_socket_data_source.dart';

part 'symbols_repo.g.dart';

class SymbolsRepo {
  SymbolsRepo({
    required SymbolsDataSource symbolsDataSource,
    required TradesDataSource tradesDatasource,
  })  : _symbolsDataSource = symbolsDataSource,
        _tradesDatasource = tradesDatasource;

  final SymbolsDataSource _symbolsDataSource;
  final TradesDataSource _tradesDatasource;
  final Map<String, SymbolData> _loadedSymbols = {};
  final Map<String, SymbolData> _watchedSymbols = {};
  final Map<String, SymbolsInfo> _latestReadings = {};
  final PublishSubject<SymbolsEvent> _ntoifer = PublishSubject();
  static const int _maxWatchedSymbols = 40;

  Future<List<SymbolsInfo>> loadSymbols(String exchange) async {
    final symbols = await _symbolsDataSource.symbols(exchange);
    _loadedSymbols.clear();
    for (final symbol in symbols) {
      _loadedSymbols[symbol.symbol ?? ''] = symbol;
    }
    addToWatchList();
    return _latestReadings.values.toList();
  }

  void toggleWatch(String symbol) {
    var symbolData = _watchedSymbols[symbol];
    if (symbolData != null) {
      removeFromWatchList(symbols: [symbolData]);
      _ntoifer.add(SymbolsEvent.data(_latestReadings.values.toBuiltList()));
      return;
    }
    symbolData = _loadedSymbols[symbol];
    if (symbolData != null) {
      addToWatchList(symbols: [symbolData]);
      _ntoifer.add(SymbolsEvent.data(_latestReadings.values.toBuiltList()));
      return;
    }
  }

  void addToWatchList({List<SymbolData>? symbols}) {
    if (_watchedSymbols.length > _maxWatchedSymbols) {
      return;
    }
    final newSymbols =
        symbols?.sublist(0, min(_maxWatchedSymbols, symbols.length)) ??
            _loadedSymbols.values.toList().sublist(
                  0,
                  min(_maxWatchedSymbols, _loadedSymbols.length),
                );
    for (final symbol in newSymbols) {
      final key = symbol.symbol ?? '';
      _watchedSymbols[key] = symbol;
      final latestReading = _latestReadings[key];
      _latestReadings[key] = latestReading?.copyWith(isWatched: true) ??
          SymbolsInfo.zero(
            symbol.symbol ?? '',
            symbol.description ?? '',
            isWatched: true,
          );
    }
    _tradesDatasource.monitorSymbols(newSymbols);
  }

  void removeFromWatchList({List<SymbolData>? symbols}) {
    _tradesDatasource.ignoreSymbols(symbols ?? _watchedSymbols.values.toList());
    if (symbols != null) {
      for (final symbol in symbols) {
        final key = symbol.symbol ?? '';
        _watchedSymbols.remove(key);
        final reading = _latestReadings[key];
        if (reading != null) {
          _latestReadings[key] = reading.copyWith(isWatched: false);
        }
      }
    } else {
      for (final key in _watchedSymbols.keys) {
        final reading = _latestReadings[key];
        if (reading != null) {
          _latestReadings[key] = reading.copyWith(isWatched: false);
        }
      }
      _watchedSymbols.clear();
    }
  }

  Stream<SymbolsEvent> get trades => Rx.merge([
        _ntoifer,
        _tradesDatasource.events.where((event) {
          return switch (event) {
            Data(:final data) => data.type == TradeDataType.trade ||
                data.type == TradeDataType.error,
            _ => true
          };
        }).map((event) {
          return switch (event) {
            Data(:final data) =>
              SymbolsEvent.data(_convert(data).toBuiltList()),
            Connected() => SymbolsEvent.connected(),
            Disconnected() => SymbolsEvent.disconnected(),
            Error(:final error) => SymbolsEvent.error(error),
          };
        }),
      ]);

  List<SymbolsInfo> _convert(TradesData trades) {
    trades.data?.where((item) => item.isValid).forEach((item) {
      final isWatched = _watchedSymbols[item.symbol!] != null;
      final description = _loadedSymbols[item.symbol!];
      final info = SymbolsInfo(
        isWatched: isWatched,
        tradeConditions: item.tradeConditions ?? [],
        symbol: item.symbol!,
        price: item.price!,
        time: DateTime.fromMillisecondsSinceEpoch(item.unixTime!),
        description: description?.description ?? '',
        volume: item.volume!,
      );
      _latestReadings[info.symbol] = info;
    });
    return _latestReadings.values.toList();
  }

  void disconnect() {
    _tradesDatasource.disconnect();
  }
}

@Riverpod()
SymbolsRepo symbolsRepo(SymbolsRepoRef ref, int id) {
  return SymbolsRepo(
    symbolsDataSource: ref.read(symbolsApiDataSourceProvider),
    tradesDatasource: ref.read(tradesWebSocketDataSourceProvider(id)),
  );
}
