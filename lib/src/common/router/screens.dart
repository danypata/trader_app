enum Screens {
  forexExchanges,
  symbols,
  symbolDetails,
}

extension ScreenPaht on Screens {
  String get path => switch (this) {
        Screens.forexExchanges => 'forex',
        Screens.symbols => 'symbols',
        Screens.symbolDetails => 'details',
      };
}
