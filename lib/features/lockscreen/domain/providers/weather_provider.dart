// lib/features/lockscreen/domain/providers/weather_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oneui85_simulator/features/lockscreen/data/weather_repository.dart';
import 'package:oneui85_simulator/features/lockscreen/domain/models/weather_data.dart';

final weatherRepositoryProvider = Provider<WeatherRepository>(
  (ref) => const WeatherRepository(),
);

final weatherProvider = FutureProvider<WeatherData>((ref) async {
  final repo = ref.watch(weatherRepositoryProvider);
  return repo.fetchCurrent();
});
