// lib/features/lockscreen/data/weather_repository.dart
import 'package:weather/weather.dart';
import 'package:geolocator/geolocator.dart';
import '../domain/models/weather_data.dart';

class WeatherRepository {
  final WeatherFactory _weatherFactory;

  WeatherRepository({required String apiKey})
      : _weatherFactory = WeatherFactory(apiKey);

  Future<WeatherData> getCurrentWeather() async {
    final position = await Geolocator.getCurrentPosition();
    final weather = await _weatherFactory.currentWeatherByLocation(
      position.latitude,
      position.longitude,
    );
    return WeatherData(
      cityName: weather.areaName ?? 'Unknown',
      temperature: weather.temperature?.celsius ?? 0,
      conditionDescription: weather.weatherDescription ?? '',
      conditionCode: weather.weatherConditionCode ?? 0,
    );
  }
}
