import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:trader_app/src/common/constants/app_sizes.dart';
import 'package:trader_app/src/common/extensions/context_extensions.dart';
import 'package:trader_app/src/common/router/screens.dart';
import 'package:trader_app/src/common/widgets/loading_indicator.dart';
import 'package:trader_app/src/forex/vm/forex_exchange_state.dart';
import 'package:trader_app/src/forex/vm/forex_exchange_view_model.dart';
import 'package:trader_app/src/forex/widgets/forex_item_widget.dart';
import 'package:trader_app/src/symbols_list/args/symbols_list_screen_args.dart';

class ForexExchangeScreen extends HookConsumerWidget {
  const ForexExchangeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = ref.watch(forexExchangeViewModelProvider);

    final body = switch (items) {
      Loading() => const LoadingIndicator(),
      Error(:final error) => Center(
          child: Text(error),
        ),
      Data(:final values) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSizes.p20),
          child: GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: AppSizes.p10,
            mainAxisSpacing: AppSizes.p10,
            children: values
                .map(
                  (item) => ForexItemWidget(
                    item: item,
                    onItemSelected: (selectedItem) {
                      context.goNamed(
                        Screens.symbols.path,
                        queryParameters: SymbolsListScreenArgs(
                          displayValue: selectedItem.exchangeName,
                          searchString: selectedItem.searchableValue,
                        ).toUriParams(),
                      );
                    },
                  ),
                )
                .toList(),
          ),
        )
    };

    return Scaffold(
      body: SafeArea(child: body),
      appBar: AppBar(
        title: Text(
          context.loc.exchange,
        ),
      ),
    );
  }
}
