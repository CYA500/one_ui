// lib/features/lockscreen/data/weather_repository.dart
import 'package:geolocator/geolocator.dart';
import 'package:oneui85_simulator/core/constants/strings.dart';
import 'package:oneui85_simulator/features/lockscreen/domain/models/weather_data.dart';
import 'package:weather/weather.dart';

/// Fetches weather data with mock fallback when location/API unavailable.
class WeatherRepository {
  const WeatherRepository();

  static const WeatherFactory _factory = WeatherFactory('demo');

  Future<WeatherData> fetchCurrent() async {
    try {
      final permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        await Geolocator.requestPermission();
      }
      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.low,
          timeLimit: Duration(seconds: 5),
        ),
      );
      final weather = await _factory.currentWeatherByLocation(
        position.latitude,
        position.longitude,
      );
      return WeatherData(
        condition: _mapCondition(weather.weatherMain),
        temperatureCelsius: weather.temperature?.celsius ?? 22,
        city: weather.areaName ?? AppStrings.weatherFallbackCity,
        description: weather.weatherDescription ?? 'Clear',
      );
    } catch (_) {
      return const WeatherData(
        condition: WeatherCondition.rain,
        temperatureCelsius: 18,
        city: AppStrings.weatherFallbackCity,
        description: 'Light rain',
      );
    }
  }

  WeatherCondition _mapCondition(String? main) {
    final value = (main ?? '').toLowerCase();
    if (value.contains('rain') || value.contains('drizzle')) {
      return WeatherCondition.rain;
    }
    if (value.contains('snow')) return WeatherCondition.snow;
    if (value.contains('cloud')) return WeatherCondition.cloudy;
    return WeatherCondition.clear;
  }
}
