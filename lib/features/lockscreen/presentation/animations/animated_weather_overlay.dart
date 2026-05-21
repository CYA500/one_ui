// lib/features/lockscreen/presentation/animations/animated_weather_overlay.dart
import 'package:flutter/material.dart';
import 'rain_animation.dart';
import 'snow_animation.dart';

class AnimatedWeatherOverlay extends StatefulWidget {
  final int conditionCode; // OpenWeatherMap condition code
  const AnimatedWeatherOverlay({super.key, required this.conditionCode});

  @override
  State<AnimatedWeatherOverlay> createState() => _AnimatedWeatherOverlayState();
}

class _AnimatedWeatherOverlayState extends State<AnimatedWeatherOverlay>
    with SingleTickerProviderStateMixin {
  late final RainSystem _rain;
  late final SnowSystem _snow;
  bool _isRaining = false;
  bool _isSnowing = false;

  @override
  void initState() {
    super.initState();
    _rain = RainSystem();
    _snow = SnowSystem();
    _updateWeather(widget.conditionCode);
  }

  @override
  void didUpdateWidget(AnimatedWeatherOverlay oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.conditionCode != widget.conditionCode) {
      _updateWeather(widget.conditionCode);
    }
  }

  void _updateWeather(int code) {
    // 2xx: Thunderstorm, 3xx: Drizzle, 5xx: Rain
    _isRaining = (code >= 200 && code < 600);
    // 6xx: Snow
    _isSnowing = (code >= 600 && code < 700);
    if (_isRaining) _rain.emit(const Size(400, 800), 100);
    if (_isSnowing) _snow.emit(const Size(400, 800), 80);
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: CustomPaint(
        painter: _WeatherPainter(
          rain: _isRaining ? _rain : null,
          snow: _isSnowing ? _snow : null,
        ),
        size: Size.infinite,
      ),
    );
  }
}

class _WeatherPainter extends CustomPainter {
  final RainSystem? rain;
  final SnowSystem? snow;
  _WeatherPainter({this.rain, this.snow});

  @override
  void paint(Canvas canvas, Size size) {
    rain?.update(size, 0.016);
    rain?.paint(canvas, size);
    snow?.update(size, 0.016);
    snow?.paint(canvas, size);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
