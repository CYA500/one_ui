// lib/shared/painters/blur_painter.dart
import 'package:flutter/material.dart';
import 'package:oneui85_simulator/app/theme/color_tokens.dart';

class BlurPainter extends CustomPainter {
  const BlurPainter({this.opacity = 0.5});

  final double opacity;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(
      Offset.zero & size,
      Paint()..color = ColorTokens.blurredNotifBg.withValues(alpha: opacity),
    );
  }

  @override
  bool shouldRepaint(covariant BlurPainter oldDelegate) =>
      oldDelegate.opacity != opacity;
}
