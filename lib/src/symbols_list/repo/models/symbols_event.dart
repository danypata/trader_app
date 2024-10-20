import 'package:built_collection/built_collection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:trader_app/src/symbols_list/repo/models/symbols_info.dart';

part 'symbols_event.freezed.dart';

@freezed
sealed class SymbolsEvent with _$SymbolsEvent {
  factory SymbolsEvent.connected() = SymbolsConnected;

  factory SymbolsEvent.disconnected() = SymbolsDisconnected;

  factory SymbolsEvent.data(BuiltList<SymbolsInfo> data) = SymbolsData;

  factory SymbolsEvent.error(Object? error) = SymbolsError;
}
