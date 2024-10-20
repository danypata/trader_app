import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:trader_app/src/symbols_list/services/trades/models/trades_data.dart';

part 'data_source_event.freezed.dart';

@freezed
sealed class DataSourceEvent with _$DataSourceEvent {
  factory DataSourceEvent.connected() = Connected;

  factory DataSourceEvent.disconnected() = Disconnected;

  factory DataSourceEvent.data(TradesData data) = Data;

  factory DataSourceEvent.error(Object? error) = Error;
}
