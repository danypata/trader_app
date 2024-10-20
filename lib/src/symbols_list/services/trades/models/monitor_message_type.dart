import 'package:freezed_annotation/freezed_annotation.dart';

enum MonitorMessageType {
  @JsonValue('subscribe')
  monitor,
  @JsonValue('unsubscribe')
  ignore,
}
