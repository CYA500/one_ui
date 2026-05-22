// lib/features/lockscreen/presentation/animations/particle_system.dart
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:oneui85_simulator/features/lockscreen/domain/models/weather_data.dart';

class Particle {
  Particle({
    required this.x,
    required this.y,
    required this.speed,
    required this.size,
    required this.drift,
  });

  double x;
  double y;
  double speed;
  double size;
  double drift;
}

class ParticleSystem extends StatefulWidget {
  const ParticleSystem({
    super.key,
    required this.condition,
    required this.child,
  });

  final WeatherCondition condition;
  final Widget child;

  @override
  State<ParticleSystem> createState() => _ParticleSystemState();
}

class _ParticleSystemState extends State<ParticleSystem>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  final _random = Random();
  late List<Particle> _particles;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 16),
    )..addListener(_tick)..repeat();
    _initParticles();
  }

  void _initParticles() {
    _particles = List.generate(80, (_) => _spawn());
  }

  Particle _spawn() {
    return Particle(
      x: _random.nextDouble(),
      y: _random.nextDouble(),
      speed: 0.003 + _random.nextDouble() * 0.006,
      size: 1 + _random.nextDouble() * 3,
      drift: (_random.nextDouble() - 0.5) * 0.002,
    );
  }

  void _tick() {
    if (widget.condition == WeatherCondition.clear) return;
    setState(() {
      for (var i = 0; i < _particles.length; i++) {
        final p = _particles[i];
        p.y += p.speed;
        p.x += p.drift;
        if (p.y > 1.1) _particles[i] = _spawn()..y = -0.05;
      }
    });
  }

  @override
  void didUpdateWidget(covariant ParticleSystem oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.condition != widget.condition) _initParticles();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,
        if (widget.condition != WeatherCondition.clear)
          CustomPaint(
            painter: _ParticlePainter(
              particles: _particles,
              condition: widget.condition,
            ),
            size: Size.infinite,
          ),
      ],
    );
  }
}

class _ParticlePainter extends CustomPainter {
  _ParticlePainter({required this.particles, required this.condition});

  final List<Particle> particles;
  final WeatherCondition condition;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white.withValues(alpha: 0.7);
    for (final p in particles) {
      final x = p.x * size.width;
      final y = p.y * size.height;
      if (condition == WeatherCondition.rain) {
        canvas.save();
        canvas.translate(x, y);
        canvas.rotate(-15 * pi / 180);
        canvas.drawLine(
          Offset.zero,
          Offset(0, p.size * 8),
          paint..strokeWidth = 1.2,
        );
        canvas.restore();
      } else if (condition == WeatherCondition.snow) {
        canvas.drawCircle(Offset(x, y), p.size, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant _ParticlePainter oldDelegate) => true;
}
