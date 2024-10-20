import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:trader_app/src/common/router/screens.dart';
import 'package:trader_app/src/forex/forex_exchange_screen.dart';
import 'package:trader_app/src/symbols_list/args/symbols_list_screen_args.dart';
import 'package:trader_app/src/symbols_list/symbols_list_screen.dart';

part 'router.g.dart';

@Riverpod(keepAlive: true)
GoRouter goRouter(GoRouterRef ref) {
  return GoRouter(
    initialLocation: '/${Screens.forexExchanges.path}',
    routes: [
      GoRoute(
        name: Screens.forexExchanges.path,
        path: '/${Screens.forexExchanges.path}',
        builder: (context, state) {
          return const ForexExchangeScreen();
        },
        routes: [
          GoRoute(
            name: Screens.symbols.path,
            path: Screens.symbols.path,
            builder: (context, state) {
              final queryParams = state.uri.queryParameters;
              if (!queryParams.containsKey(SymbolsListScreenArgs.argsKey)) {
                throw ArgumentError('SymbolsListScreen missing query params');
              }
              final args = SymbolsListScreenArgs.fromUriParams(queryParams);
              return SymbolsListScreen(args);
            },
          ),
        ],
      ),
    ],
  );
}
