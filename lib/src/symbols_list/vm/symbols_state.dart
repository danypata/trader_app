import 'package:built_collection/built_collection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:trader_app/src/symbols_list/repo/models/symbols_info.dart';

part 'symbols_state.freezed.dart';

@freezed
sealed class SymbolsState with _$SymbolsState {
  const factory SymbolsState({
    required bool isLoading,
    required bool isDisconnected,
    required BuiltList<SymbolsInfo> data,
    required String? error,
  }) = _SymbolsState;

  const SymbolsState._();

  factory SymbolsState.loading() => SymbolsState(
        isLoading: true,
        isDisconnected: false,
        data: BuiltList(),
        error: '',
      );
}
