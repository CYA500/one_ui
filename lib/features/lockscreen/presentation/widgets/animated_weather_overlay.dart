// lib/features/lockscreen/presentation/widgets/animated_weather_overlay.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oneui85_simulator/core/constants/durations.dart';
import 'package:oneui85_simulator/features/lockscreen/domain/models/weather_data.dart';
import 'package:oneui85_simulator/features/lockscreen/domain/providers/weather_provider.dart';
import 'package:oneui85_simulator/features/lockscreen/presentation/animations/particle_system.dart';

class AnimatedWeatherOverlay extends ConsumerWidget {
  const AnimatedWeatherOverlay({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weather = ref.watch(weatherProvider);
    return weather.when(
      data: (data) {
        if (data.condition == WeatherCondition.clear) {
          return Stack(
            children: [
              child,
              const _SunGlow(),
            ],
          );
        }
        return ParticleSystem(
          condition: data.condition,
          child: child,
        );
      },
      loading: () => child,
      error: (_, __) => child,
    );
  }
}

class _SunGlow extends StatefulWidget {
  const _SunGlow();

  @override
  State<_SunGlow> createState() => _SunGlowState();
}

class _SunGlowState extends State<_SunGlow>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: AppDurations.sunGlow,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Positioned(
          top: 80,
          right: 40,
          child: Icon(
            Icons.wb_sunny,
            size: 48 + _controller.value * 8,
            color: Colors.amber.withValues(alpha: 0.4 + _controller.value * 0.2),
          ),
        );
      },
    );
  }
}
