import 'package:freezed_annotation/freezed_annotation.dart';

part 'trade_item.freezed.dart';

part 'trade_item.g.dart';

@freezed
class TradeItem with _$TradeItem {
  const factory TradeItem({
    @JsonKey(name: 'c') List<String>? tradeConditions,
    @JsonKey(name: 's') String? symbol,
    @JsonKey(name: 'p') double? price,
    @JsonKey(name: 't') int? unixTime,
    @JsonKey(name: 'v') double? volume,
  }) = _TradeItem;

  const TradeItem._();

  factory TradeItem.fromJson(Map<String, dynamic> json) =>
      _$TradeItemFromJson(json);

  bool get isValid =>
      symbol != null && price != null && unixTime != null && volume != null;
}

TradeItem deserializeTradeItem(
  Map<String, dynamic> json,
) =>
    TradeItem.fromJson(json);

List<TradeItem> deserializeTradeItemList(
  List<Map<String, dynamic>> json,
) =>
    json.map(TradeItem.fromJson).toList();

Map<String, dynamic> serializeTradeItem(
  TradeItem object,
) =>
    object.toJson();

List<Map<String, dynamic>> serializeTradeItemList(
  List<TradeItem> objects,
) =>
    objects.map((e) => e.toJson()).toList();
