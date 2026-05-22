// lib/shared/painters/liquid_glass_painter.dart
import 'package:flutter/material.dart';
import 'package:oneui85_simulator/app/theme/color_tokens.dart';

class LiquidGlassPainter extends CustomPainter {
  const LiquidGlassPainter({this.highlight = ColorTokens.glassBlue});

  final Color highlight;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final paint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          highlight.withValues(alpha: 0.35),
          ColorTokens.glassWhite,
        ],
      ).createShader(rect);
    final rrect = RRect.fromRectAndRadius(rect, const Radius.circular(20));
    canvas.drawRRect(rrect, paint);
  }

  @override
  bool shouldRepaint(covariant LiquidGlassPainter oldDelegate) =>
      oldDelegate.highlight != highlight;
}
