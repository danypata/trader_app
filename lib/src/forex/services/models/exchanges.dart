import 'package:flutter_gen/gen_l10n/app_localizations.dart';

enum ForexExchange {
  oanda('oanda'),
  fxcm('fxcm'),
  forexDotCom('forex.com'),
  icMarkets('ic markets'),
  fxpor('fxpro'),
  fhfx('fhfx'),
  capital('capital'),
  icmtrader('icmtrader'),
  pepperstoneuk('pepperstoneuk'),
  fxpig('fxpig'),
  pepperstone('pepperstone'),
  unknown('');

  const ForexExchange([this.apiValue]);

  final String? apiValue;
}

extension Localized on ForexExchange {
  String displayName(AppLocalizations loc) {
    return switch (this) {
      ForexExchange.oanda => loc.oanda,
      ForexExchange.fxcm => loc.fxcm,
      ForexExchange.forexDotCom => loc.forexDotCom,
      ForexExchange.icMarkets => loc.icMarkets,
      ForexExchange.fxpor => loc.fxpro,
      ForexExchange.unknown => '',
      ForexExchange.fhfx => loc.fhfx,
      ForexExchange.capital => loc.capital,
      ForexExchange.icmtrader => loc.icmtrader,
      ForexExchange.pepperstoneuk => loc.pepperstoneuk,
      ForexExchange.fxpig => loc.fxpig,
      ForexExchange.pepperstone => loc.pepperstone,
    };
  }
}
