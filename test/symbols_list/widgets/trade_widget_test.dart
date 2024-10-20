import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mockito/annotations.dart';
import 'package:trader_app/src/symbols_list/providers/providers.dart';
import 'package:trader_app/src/symbols_list/widgets/trade_widget.dart';

@GenerateMocks([StateNotifier, StateNotifierProvider])
void main() {
  late DateTime _now;
  setUp(() {
    _now = DateTime.now();
  });

  Widget createWidgetUnderTest() {
    return ProviderScope(
      overrides: [
        symbolProvider.overrideWithValue('SYM'),
        watchProvider.overrideWithValue(true),
        priceProvider.overrideWithValue(101.0),
        dateProvider.overrideWithValue(_now),
        tradeConditionsProvider.overrideWithValue("1,2,3"),
        descriptionProvider.overrideWithValue("The description"),
        callbackProvider.overrideWithValue(() {}),
      ],
      child: const MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: SymbolWidget(),
      ),
    );
  }

  testWidgets('displays correct data', (tester) async {
    await tester.pumpWidget(createWidgetUnderTest());

    expect(find.text('SYM'), findsOneWidget);
    expect(find.text('101.0'), findsOneWidget);
    expect(find.text(_now.toIso8601String()), findsOneWidget);
    expect(find.text('1,2,3'), findsOneWidget);
    expect(find.text('The description'), findsOneWidget);
  });
}
