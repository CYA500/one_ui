// lib/features/lockscreen/domain/providers/clock_provider.dart
import 'dart:async';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'clock_provider.g.dart';

/// يُحدّث الوقت الحالي كل ثانية.
@riverpod
Stream<DateTime> currentDateTime(CurrentDateTimeRef ref) {
  return Stream.periodic(
    const Duration(seconds: 1),
    (_) => DateTime.now(),
  );
}
