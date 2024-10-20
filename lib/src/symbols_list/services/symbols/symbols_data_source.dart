import 'package:trader_app/src/symbols_list/services/symbols/models/symbol_data.dart';

mixin SymbolsDataSource {
  Future<List<SymbolData>> symbols(String exchange);
}
