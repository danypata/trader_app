import 'package:freezed_annotation/freezed_annotation.dart';

enum TradeDataType {
  @JsonValue('trade')
  trade,
  @JsonValue('ping')
  ping,
  @JsonValue('error')
  error,
  @JsonValue('unknown')
  unknown,
}
