import 'dart:math';

import 'package:built_collection/built_collection.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:trader_app/src/symbols_list/repo/models/symbols_event.dart';
import 'package:trader_app/src/symbols_list/repo/symbols_repo.dart';
import 'package:trader_app/src/symbols_list/vm/symbols_state.dart';

part 'symbols_view_model.g.dart';

@Riverpod()
class SymbolsViewModel extends _$SymbolsViewModel {
  late SymbolsRepo _repo;

  @override
  SymbolsState build(String exchange, int id) {
    _repo = ref.read(symbolsRepoProvider(id));
    _loadSymbols();
    ref.onDispose(() {
      _repo.disconnect();
    });
    _repo.trades.listen((data) {
      state = switch (data) {
        SymbolsConnected() =>
          state.copyWith(isDisconnected: false, isLoading: false),
        SymbolsDisconnected() =>
          state.copyWith(isDisconnected: false, isLoading: false),
        SymbolsData(:final data) =>
          state.copyWith(isDisconnected: false, isLoading: false, data: data),
        SymbolsError(:final error) => state.copyWith(
            isDisconnected: false,
            isLoading: false,
            error: error.toString(),
          ),
      };
    });
    return SymbolsState.loading();
  }

  Future<void> _loadSymbols() async {
    final data = await _repo.loadSymbols(exchange);
    state = state.copyWith(
      isDisconnected: false,
      isLoading: false,
      data: data.toBuiltList(),
    );
  }

  void toggleWatch(String symbol) {
    _repo.toggleWatch(symbol);
  }
}
