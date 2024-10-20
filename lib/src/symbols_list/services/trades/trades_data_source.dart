import 'package:trader_app/src/symbols_list/services/symbols/models/symbol_data.dart';
import 'package:trader_app/src/symbols_list/services/trades/models/data_source_event.dart';

abstract class TradesDataSource {
  void disconnect();

  void monitorSymbols(List<SymbolData> symbols);

  void ignoreSymbols(List<SymbolData> symbols);

  Stream<DataSourceEvent> get events;
}
