import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

extension ThemeExtensions on BuildContext {
  ThemeData get theme => Theme.of(this);
}

extension Localization on BuildContext {
  AppLocalizations get loc => AppLocalizations.of(this);
}
