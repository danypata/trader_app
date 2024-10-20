import 'package:flutter/material.dart';
import 'package:trader_app/src/common/constants/app_sizes.dart';
import 'package:trader_app/src/common/extensions/context_extensions.dart';
import 'package:trader_app/src/forex/vm/models/displayable_forex_exchange.dart';

class ForexItemWidget extends StatelessWidget {
  const ForexItemWidget({
    required this.item,
    required this.onItemSelected,
    super.key,
  });

  final DisplayableForexExchange item;
  final ValueChanged<DisplayableForexExchange> onItemSelected;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          onItemSelected.call(item);
        },
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.p10),
          child: Center(
            child: Text(
              item.exchangeName,
              style: context.theme.textTheme.titleMedium,
            ),
          ),
        ),
      ),
    );
  }
}
