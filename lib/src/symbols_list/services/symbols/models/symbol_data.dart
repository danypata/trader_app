import 'package:freezed_annotation/freezed_annotation.dart';

part 'symbol_data.g.dart';

part 'symbol_data.freezed.dart';

@freezed
class SymbolData with _$SymbolData {
  factory SymbolData({
    String? description,
    String? displaySymbol,
    String? symbol,
  }) = _SymbolData;

  factory SymbolData.fromJson(Map<String, dynamic> json) =>
      _$SymbolDataFromJson(json);
}

SymbolData deserializeSymbolData(
  Map<String, dynamic> json,
) =>
    SymbolData.fromJson(json);

List<SymbolData> deserializeSymbolDataList(
  List<Map<String, dynamic>> json,
) =>
    json.map(SymbolData.fromJson).toList();

Map<String, dynamic> serializeSymbolData(
  SymbolData object,
) =>
    object.toJson();

List<Map<String, dynamic>> serializeSymbolDataList(
  List<SymbolData> objects,
) =>
    objects.map((e) => e.toJson()).toList();
