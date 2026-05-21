// lib/features/lockscreen/presentation/animations/snow_animation.dart
import 'dart:math';
import 'package:flutter/material.dart';
import '../../../../../shared/painters/particle_system.dart';

class SnowSystem extends ParticleSystem {
  SnowSystem();

  @override
  Particle createParticle(Size size) {
    final x = random.nextDouble() * size.width;
    final y = random.nextDouble() * -size.height;
    final drift = -1.0 + random.nextDouble() * 2.0;
    return Particle(
      position: Offset(x, y),
      velocity: Offset(drift * 30, 50 + random.nextDouble() * 40),
      size: 2.0 + random.nextDouble() * 4.0,
      color: Colors.white,
      opacity: 0.5 + random.nextDouble() * 0.5,
    );
  }

  @override
  void update(Size size, double dt) {
    for (final p in particles) {
      p.position += p.velocity * dt;
      p.velocity = Offset(p.velocity.dx + (Random().nextDouble() - 0.5) * 5, p.velocity.dy);
      if (p.position.dy > size.height + 20) {
        p.position = Offset(
          random.nextDouble() * size.width,
          -10,
        );
      }
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;
    for (final p in particles) {
      paint.color = Colors.white.withOpacity(p.opacity);
      canvas.drawCircle(p.position, p.size, paint);
    }
  }
}
