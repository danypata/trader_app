import 'package:built_collection/built_collection.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:trader_app/src/common/locales/app_localization_provider.dart';
import 'package:trader_app/src/forex/repo/forex_exchange_repo.dart';
import 'package:trader_app/src/forex/services/models/exchanges.dart';
import 'package:trader_app/src/forex/vm/forex_exchange_state.dart';
import 'package:trader_app/src/forex/vm/models/displayable_forex_exchange.dart';

part 'forex_exchange_view_model.g.dart';

@Riverpod()
class ForexExchangeViewModel extends _$ForexExchangeViewModel {
  late ForexExchangeRepo _repo;
  late AppLocalizations _localizations;

  @override
  ForexExchangeState build() {
    _repo = ref.read(forexExchangeRepoProvider);
    _localizations = ref.read(appLocalizationsProvider);
    _fetchAvailableExchanges();
    return ForexExchangeState.loading();
  }

  Future<void> _fetchAvailableExchanges() async {
    try {
      final exchanges = await _repo.availableForexExchanges();
      state = ForexExchangeState.data(
        exchanges
            .map(
              (el) => DisplayableForexExchange(
                exchangeName: el.displayName(_localizations),
                searchableValue: el.apiValue ?? '',
              ),
            )
            .toBuiltList(),
      );
    } catch (e) {
      // TODO(dan): this can be better
      state = ForexExchangeState.error(e.toString());
    }
  }
}
