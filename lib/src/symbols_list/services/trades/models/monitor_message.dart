import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:trader_app/src/symbols_list/services/trades/models/monitor_message_type.dart';

part 'monitor_message.freezed.dart';

part 'monitor_message.g.dart';

@freezed
sealed class MonitorMessage with _$MonitorMessage {
  const factory MonitorMessage({
    required MonitorMessageType type,
    required String symbol,
  }) = _MonitorMessage;

  factory MonitorMessage.fromJson(Map<String, dynamic> json) =>
      _$MonitorMessageFromJson(json);
}
