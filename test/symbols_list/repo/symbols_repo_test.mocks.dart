// Mocks generated by Mockito 5.4.4 from annotations
// in trader_app/test/symbols_list/repo/symbols_repo_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i3;

import 'package:mockito/mockito.dart' as _i1;
import 'package:trader_app/src/symbols_list/services/symbols/models/symbol_data.dart'
    as _i4;
import 'package:trader_app/src/symbols_list/services/symbols/symbols_data_source.dart'
    as _i2;
import 'package:trader_app/src/symbols_list/services/trades/models/data_source_event.dart'
    as _i6;
import 'package:trader_app/src/symbols_list/services/trades/trades_data_source.dart'
    as _i5;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

/// A class which mocks [SymbolsDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockSymbolsDataSource extends _i1.Mock implements _i2.SymbolsDataSource {
  @override
  _i3.Future<List<_i4.SymbolData>> symbols(String? exchange) =>
      (super.noSuchMethod(
        Invocation.method(
          #symbols,
          [exchange],
        ),
        returnValue: _i3.Future<List<_i4.SymbolData>>.value(<_i4.SymbolData>[]),
        returnValueForMissingStub:
            _i3.Future<List<_i4.SymbolData>>.value(<_i4.SymbolData>[]),
      ) as _i3.Future<List<_i4.SymbolData>>);
}

/// A class which mocks [TradesDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockTradesDataSource extends _i1.Mock implements _i5.TradesDataSource {
  @override
  _i3.Stream<_i6.DataSourceEvent> get events => (super.noSuchMethod(
        Invocation.getter(#events),
        returnValue: _i3.Stream<_i6.DataSourceEvent>.empty(),
        returnValueForMissingStub: _i3.Stream<_i6.DataSourceEvent>.empty(),
      ) as _i3.Stream<_i6.DataSourceEvent>);

  @override
  void disconnect() => super.noSuchMethod(
        Invocation.method(
          #disconnect,
          [],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void monitorSymbols(List<_i4.SymbolData>? symbols) => super.noSuchMethod(
        Invocation.method(
          #monitorSymbols,
          [symbols],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void ignoreSymbols(List<_i4.SymbolData>? symbols) => super.noSuchMethod(
        Invocation.method(
          #ignoreSymbols,
          [symbols],
        ),
        returnValueForMissingStub: null,
      );
}
