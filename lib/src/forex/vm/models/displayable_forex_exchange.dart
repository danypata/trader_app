import 'package:freezed_annotation/freezed_annotation.dart';

part 'displayable_forex_exchange.freezed.dart';

@freezed
class DisplayableForexExchange with _$DisplayableForexExchange {
  const factory DisplayableForexExchange({
    required String exchangeName,
    required String searchableValue,
  }) = _DisplayableForexExchange;
}
