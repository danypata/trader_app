import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:trader_app/src/app.dart';

void main() {
  final container = ProviderContainer();

  return runApp(
    UncontrolledProviderScope(
      container: container,
      child: const TraderApp(),
    ),
  );
}
