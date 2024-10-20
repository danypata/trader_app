import 'package:flutter/cupertino.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

final symbolProvider = Provider<String>((_) {
  throw UnimplementedError('this should be overriden');
});

final priceProvider = Provider<double>((_) {
  throw UnimplementedError('this should be overriden');
});

final watchProvider = Provider<bool>((_) {
  throw UnimplementedError('this should be overriden');
});

final volumeProvider = Provider<double>((_) {
  throw UnimplementedError('this should be overriden');
});

final dateProvider = Provider<DateTime>((_) {
  throw UnimplementedError('this should be overriden');
});

final tradeConditionsProvider = Provider<String>((_) {
  throw UnimplementedError('this should be overriden');
});

final descriptionProvider = Provider<String>((_) {
  throw UnimplementedError('this should be overriden');
});

final callbackProvider = Provider<VoidCallback>((_) {
  throw UnimplementedError('this should be overriden');
});
