import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_localization_provider.g.dart';

/// provider used to access the AppLocalizations object for the current locale
/// with NO context
@riverpod
AppLocalizations appLocalizations(AppLocalizationsRef ref) {
  // 1. initialize from the initial locale
  ref.state =
      lookupAppLocalizations(WidgetsBinding.instance.platformDispatcher.locale);
  // 2. create an observer to update the state
  final observer = _LocaleObserver((locales) {
    ref.state = lookupAppLocalizations(
      WidgetsBinding.instance.platformDispatcher.locale,
    );
  });
  // 3. register the observer and dispose it when no longer needed
  final binding = WidgetsBinding.instance..addObserver(observer);
  ref.onDispose(() => binding.removeObserver(observer));
  // 4. return the state
  return ref.state;
}

/// observer used to notify the caller when the locale changes
class _LocaleObserver extends WidgetsBindingObserver {
  _LocaleObserver(this._didChangeLocales);

  final void Function(List<Locale>? locales) _didChangeLocales;

  @override
  void didChangeLocales(List<Locale>? locales) {
    _didChangeLocales(locales);
  }
}
