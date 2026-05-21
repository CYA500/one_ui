// lib/shared/painters/particle_system.dart
import 'dart:math';
import 'package:flutter/material.dart';

class Particle {
  Offset position;
  Offset velocity;
  double size;
  Color color;
  double opacity;

  Particle({
    required this.position,
    required this.velocity,
    required this.size,
    required this.color,
    required this.opacity,
  });
}

abstract class ParticleSystem {
  final List<Particle> particles = [];
  final Random random = Random();

  void update(Size size, double dt);
  void paint(Canvas canvas, Size size);

  void emit(Size size, int count) {
    for (int i = 0; i < count; i++) {
      particles.add(createParticle(size));
    }
  }

  Particle createParticle(Size size);
}
