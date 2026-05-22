// lib/features/lockscreen/domain/models/weather_data.dart
enum WeatherCondition { clear, rain, snow, cloudy }

class WeatherData {
  const WeatherData({
    required this.condition,
    required this.temperatureCelsius,
    required this.city,
    required this.description,
  });

  final WeatherCondition condition;
  final double temperatureCelsius;
  final String city;
  final String description;

  WeatherData copyWith({
    WeatherCondition? condition,
    double? temperatureCelsius,
    String? city,
    String? description,
  }) {
    return WeatherData(
      condition: condition ?? this.condition,
      temperatureCelsius: temperatureCelsius ?? this.temperatureCelsius,
      city: city ?? this.city,
      description: description ?? this.description,
    );
  }
}
