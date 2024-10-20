import 'package:collection/collection.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:trader_app/src/forex/services/forex_exchange_api_data_source.dart';
import 'package:trader_app/src/forex/services/forex_exchange_data_source.dart';
import 'package:trader_app/src/forex/services/models/exchanges.dart';

part 'forex_exchange_repo.g.dart';

class ForexExchangeRepo {
  const ForexExchangeRepo({
    required ForexExchangeDataSource forexExchangeDataSource,
  }) : _forexExchangeDataSource = forexExchangeDataSource;
  final ForexExchangeDataSource _forexExchangeDataSource;

  Future<List<ForexExchange>> availableForexExchanges() {
    return _forexExchangeDataSource.forexExchanges().then(
          (values) => values.map((el) {
            return ForexExchange.values.firstWhereOrNull(
                  (f) => f.apiValue == el,
                ) ??
                ForexExchange.unknown;
          }).toList(),
        );
  }
}

@Riverpod()
ForexExchangeRepo forexExchangeRepo(ForexExchangeRepoRef ref) {
  return ForexExchangeRepo(
    forexExchangeDataSource: ref.read(forexExchangeApiDataSourceProvider),
  );
}
