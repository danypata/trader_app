import 'dart:convert';
import 'dart:math';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'symbols_list_screen_args.freezed.dart';

part 'symbols_list_screen_args.g.dart';

@freezed
class SymbolsListScreenArgs with _$SymbolsListScreenArgs {
  const factory SymbolsListScreenArgs({
    required String searchString,
    required String displayValue,
  }) = _SymbolsListScreenArgs;

  const SymbolsListScreenArgs._();

  factory SymbolsListScreenArgs.fromJson(Map<String, dynamic> json) =>
      _$SymbolsListScreenArgsFromJson(json);

  factory SymbolsListScreenArgs.fromUriParams(Map<String, String> args) {
    final jsonString = Uri.decodeComponent(args[argsKey] ?? '');
    final jsonMap = jsonDecode(jsonString) as Map<String, dynamic>;
    return SymbolsListScreenArgs.fromJson(jsonMap);
  }

  static const argsKey = 'symbol';

  Map<String, String> toUriParams() {
    return {
      argsKey: Uri.encodeComponent(jsonEncode(toJson())),
    };
  }
}
