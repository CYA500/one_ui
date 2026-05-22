// lib/features/lockscreen/presentation/animations/snow_animation.dart
import 'package:flutter/material.dart';
import 'package:oneui85_simulator/features/lockscreen/domain/models/weather_data.dart';
import 'package:oneui85_simulator/features/lockscreen/presentation/animations/particle_system.dart';

/// Snow overlay wrapper using ParticleSystem.
class SnowAnimation extends StatelessWidget {
  const SnowAnimation({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ParticleSystem(
      condition: WeatherCondition.snow,
      child: child,
    );
  }
}
