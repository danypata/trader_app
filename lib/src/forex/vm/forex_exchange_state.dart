import 'package:built_collection/built_collection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:trader_app/src/forex/vm/models/displayable_forex_exchange.dart';

part 'forex_exchange_state.freezed.dart';

@freezed
sealed class ForexExchangeState with _$ForexExchangeState {
  factory ForexExchangeState.loading() = Loading;

  factory ForexExchangeState.data(BuiltList<DisplayableForexExchange> values) =
      Data;

  factory ForexExchangeState.error(String error) = Error;
}
