import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:trader_app/src/common/constants/app_sizes.dart';
import 'package:trader_app/src/common/extensions/context_extensions.dart';
import 'package:trader_app/src/common/extensions/string_extensions.dart';
import 'package:trader_app/src/symbols_list/providers/providers.dart';
import 'package:trader_app/src/symbols_list/repo/models/price_variation.dart';

class SymbolWidget extends StatelessWidget {
  const SymbolWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final style = context.theme.textTheme.bodyMedium ?? const TextStyle();
    final maxWidth = [
      context.loc.lastPrice.measureText(style).width,
      context.loc.date.measureText(style).width,
      context.loc.tradeConditions.measureText(style).width,
    ].max;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.p10),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.p10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  Expanded(
                    child: _Symbol(),
                  ),
                  _WatchButton(),
                ],
              ),
              gapH16,
              Row(
                children: [
                  SizedBox(
                    width: maxWidth,
                    child: Text(
                      context.loc.lastPrice,
                      style: style,
                    ),
                  ),
                  gapW8,
                  const _LastPrice(),
                ],
              ),
              Row(
                children: [
                  SizedBox(
                    width: maxWidth,
                    child: Text(
                      context.loc.date,
                      style: style,
                    ),
                  ),
                  gapW8,
                  const _Date(),
                ],
              ),
              Row(
                children: [
                  SizedBox(
                    width: maxWidth,
                    child: Text(
                      context.loc.tradeConditions,
                      style: style,
                    ),
                  ),
                  const _TradeConditions(),
                ],
              ),
              gapH16,
              const _Description(),
            ],
          ),
        ),
      ),
    );
  }
}

class _Symbol extends HookConsumerWidget {
  const _Symbol();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final symbol = ref.watch(symbolProvider);
    return Text(
      symbol,
      style: context.theme.textTheme.bodyLarge,
    );
  }
}

class _WatchButton extends HookConsumerWidget {
  const _WatchButton();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final watched = ref.watch(watchProvider);
    final onTap = ref.watch(callbackProvider);
    return IconButton(
      onPressed: onTap,
      icon: watched
          ? const Icon(Icons.remove_red_eye_outlined)
          : const Icon(Icons.panorama_fish_eye),
    );
  }
}

class _LastPrice extends HookConsumerWidget {
  const _LastPrice();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final price = ref.watch(priceProvider);
    final priceVariation = ref.watch(priceVariationProvider);
    final style = context.theme.textTheme.bodyLarge ?? const TextStyle();
    final textColor = switch (priceVariation) {
      PriceVariation.up => Colors.green,
      PriceVariation.down => Colors.red,
      PriceVariation.same => Colors.black,
    };
    return Text(
      price.toString(),
      style: style.copyWith(fontWeight: FontWeight.w700, color: textColor),
    );
  }
}

class _Date extends HookConsumerWidget {
  const _Date();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final date = ref.watch(dateProvider);
    final format = DateFormat('MM.dd.yy, HH:mm:ss.SSS');
    return Text(
      format.format(date),
      style: context.theme.textTheme.bodyLarge
          ?.copyWith(fontWeight: FontWeight.w700),
    );
  }
}

class _TradeConditions extends HookConsumerWidget {
  const _TradeConditions();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final trade = ref.watch(tradeConditionsProvider);
    return Text(
      trade,
      style: context.theme.textTheme.bodyLarge
          ?.copyWith(fontWeight: FontWeight.w700),
    );
  }
}

class _Description extends HookConsumerWidget {
  const _Description();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final description = ref.watch(descriptionProvider);
    return Text(
      description,
      style: context.theme.textTheme.bodyLarge
          ?.copyWith(fontWeight: FontWeight.w700),
    );
  }
}
