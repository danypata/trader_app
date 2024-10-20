import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:rxdart/rxdart.dart';
import 'package:trader_app/src/symbols_list/repo/models/symbols_event.dart';
import 'package:trader_app/src/symbols_list/repo/symbols_repo.dart';
import 'package:trader_app/src/symbols_list/vm/symbols_view_model.dart';

import 'symbols_view_model_test.mocks.dart';

@GenerateNiceMocks([MockSpec<SymbolsRepo>()])
void main() {
  late MockSymbolsRepo mockSymbolsRepo;
  late ProviderContainer container;
  late SymbolsViewModel symbolsViewModel;
  late int id;
  setUp(() {
    id = Random().nextInt(9999);
    mockSymbolsRepo = MockSymbolsRepo();
    container = ProviderContainer(
      overrides: [
        symbolsRepoProvider(id).overrideWithValue(mockSymbolsRepo),
        symbolsRepoProvider(112).overrideWithValue(mockSymbolsRepo),
        symbolsRepoProvider(113).overrideWithValue(mockSymbolsRepo),
      ],
    );
    symbolsViewModel =
        container.read(symbolsViewModelProvider('NASDAQ', id).notifier);
  });

  tearDown(() {
    container.dispose();
  });

  group('SymbolsViewModel', () {
    test('should toggle symbol watch status', () {
      // Act
      symbolsViewModel.toggleWatch('AAPL');

      // Assert
      verify(mockSymbolsRepo.toggleWatch('AAPL')).called(1);
    });

    test('should handle trades event: SymbolsConnected', () async {
      // Arrange
      final connectedEvent = SymbolsEvent.connected();
      final subject = PublishSubject<SymbolsEvent>();
      when(mockSymbolsRepo.trades).thenAnswer((_) => subject);

      // Act
      symbolsViewModel =
          container.read(symbolsViewModelProvider('NASDAQ', 112).notifier);
      subject.add(connectedEvent);

      // Assert
      await expectLater(symbolsViewModel.state.isDisconnected, false);
      await expectLater(symbolsViewModel.state.isLoading, false);
    });
  });
}
