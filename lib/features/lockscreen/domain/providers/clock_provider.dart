// lib/features/lockscreen/domain/providers/clock_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Stream of current time, updated every second.
final clockProvider = StreamProvider<DateTime>((ref) async* {
  final offset = DateTime.now().timeZoneOffset;
  while (true) {
    await Future<void>.delayed(const Duration(seconds: 1));
    yield DateTime.now().toUtc().add(offset);
  }
});
