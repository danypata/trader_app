import 'package:freezed_annotation/freezed_annotation.dart';

part 'symbols_info.freezed.dart';

@freezed
class SymbolsInfo with _$SymbolsInfo {
  const factory SymbolsInfo({
    required bool isWatched,
    required List<String> tradeConditions,
    required String symbol,
    required double price,
    required DateTime time,
    required double volume,
    required String description,
  }) = _SymbolsInfo;

  const SymbolsInfo._();

  factory SymbolsInfo.zero(
    String symbol,
    String description, {
    required bool isWatched,
  }) {
    return SymbolsInfo(
      isWatched: isWatched,
      tradeConditions: [],
      symbol: symbol,
      price: 0,
      time: DateTime.now(),
      volume: 0,
      description: description,
    );
  }
}
