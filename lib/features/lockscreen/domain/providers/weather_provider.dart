// lib/features/lockscreen/domain/providers/weather_provider.dart
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/weather_repository.dart';
import '../models/weather_data.dart';

part 'weather_provider.g.dart';

/// يهيئ WeatherRepository بمفتاح API الافتراضي (يمكن تغييره لاحقاً).
@riverpod
WeatherRepository weatherRepository(WeatherRepositoryRef ref) {
  // استبدل بـ API key الحقيقي
  return WeatherRepository(apiKey: '991ea3e7ead0b7a3cc766216138e0f3e');
}

/// يجلب بيانات الطقس الحالية.
@riverpod
Future<WeatherData> currentWeather(CurrentWeatherRef ref) async {
  final repo = ref.watch(weatherRepositoryProvider);
  return repo.getCurrentWeather();
}
