import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:trader_app/src/common/extensions/context_extensions.dart';
import 'package:trader_app/src/symbols_list/args/symbols_list_screen_args.dart';
import 'package:trader_app/src/symbols_list/providers/providers.dart';
import 'package:trader_app/src/symbols_list/vm/symbols_view_model.dart';
import 'package:trader_app/src/symbols_list/widgets/trade_widget.dart';

class SymbolsListScreen extends HookConsumerWidget {
  const SymbolsListScreen(this.args, {super.key});

  final SymbolsListScreenArgs args;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = symbolsViewModelProvider(args.searchString, args.id);
    final vm = ref.read(provider.notifier);
    final data = ref.watch(provider);

    return Scaffold(
      appBar: AppBar(
        title: Text(context.loc.symbolName(args.displayValue)),
      ),
      body: ListView.builder(
        itemCount: data.data.length,
        itemBuilder: (context, index) {
          final info = data.data[index];
          void callback() {
            vm.toggleWatch(info.symbol);
          }

          return ProviderScope(
            overrides: [
              symbolProvider.overrideWithValue(info.symbol),
              priceProvider.overrideWithValue(info.price),
              watchProvider.overrideWithValue(info.isWatched),
              volumeProvider.overrideWithValue(info.volume),
              dateProvider.overrideWithValue(info.time),
              tradeConditionsProvider
                  .overrideWithValue(info.tradeConditions.join(', ')),
              descriptionProvider.overrideWithValue(info.description),
              callbackProvider.overrideWithValue(callback),
            ],
            child: const SymbolWidget(),
          );
        },
      ),
    );
  }
}
