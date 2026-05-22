// lib/features/lockscreen/presentation/animations/rain_animation.dart
import 'package:flutter/material.dart';
import 'package:oneui85_simulator/features/lockscreen/domain/models/weather_data.dart';
import 'package:oneui85_simulator/features/lockscreen/presentation/animations/particle_system.dart';

/// Rain overlay wrapper using ParticleSystem.
class RainAnimation extends StatelessWidget {
  const RainAnimation({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ParticleSystem(
      condition: WeatherCondition.rain,
      child: child,
    );
  }
}
