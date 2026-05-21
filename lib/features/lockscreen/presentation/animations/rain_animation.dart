// lib/features/lockscreen/presentation/animations/rain_animation.dart
import 'dart:math';
import 'package:flutter/material.dart';
import '../../../../../shared/painters/particle_system.dart';

class RainSystem extends ParticleSystem {
  final Color rainColor;
  RainSystem({this.rainColor = const Color(0x90A0C4FF)});

  @override
  Particle createParticle(Size size) {
    final x = random.nextDouble() * size.width;
    final y = random.nextDouble() * -size.height;
    final speed = 400 + random.nextDouble() * 200;
    return Particle(
      position: Offset(x, y),
      velocity: Offset(-1.5, speed),
      size: 1.5 + random.nextDouble() * 3,
      color: rainColor,
      opacity: 0.4 + random.nextDouble() * 0.6,
    );
  }

  @override
  void update(Size size, double dt) {
    for (final p in particles) {
      p.position += p.velocity * dt;
      if (p.position.dy > size.height + 20) {
        p.position = Offset(
          random.nextDouble() * size.width,
          random.nextDouble() * -40,
        );
      }
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..strokeWidth = 1.5
      ..strokeCap = StrokeCap.round;
    for (final p in particles) {
      paint.color = p.color.withOpacity(p.opacity);
      final end = p.position + Offset(p.velocity.dx * 0.05, p.velocity.dy * 0.05);
      canvas.drawLine(p.position, end, paint);
    }
  }
}
