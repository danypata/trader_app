import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:trader_app/src/symbols_list/services/trades/models/trade_data_type.dart';
import 'package:trader_app/src/symbols_list/services/trades/models/trade_item.dart';

part 'trades_data.freezed.dart';
part 'trades_data.g.dart';


@freezed
class TradesData with _$TradesData {
  const factory TradesData({
    @JsonKey(unknownEnumValue: TradeDataType.unknown)
    required TradeDataType type,
    List<TradeItem>? data,
    String? msg,
  }) = _TradesData;

  factory TradesData.fromJson(Map<String, dynamic> json) =>
      _$TradesDataFromJson(json);
}

TradesData deserializeTradesData(
  Map<String, dynamic> json,
) =>
    TradesData.fromJson(json);

List<TradesData> deserializeTradesDataList(
  List<Map<String, dynamic>> json,
) =>
    json.map(TradesData.fromJson).toList();

Map<String, dynamic> serializeTradesData(
  TradesData object,
) =>
    object.toJson();

List<Map<String, dynamic>> serializeTradesDataList(
  List<TradesData> objects,
) =>
    objects.map((e) => e.toJson()).toList();
