// lib/core/extensions/color_ext.dart
import 'package:flutter/material.dart';

extension ColorExt on Color {
  Color lighten([double amount = 0.1]) {
    final hsl = HSLColor.fromColor(this);
    return hsl.withLightness((hsl.lightness + amount).clamp(0.0, 1.0)).toColor();
  }

  Color darken([double amount = 0.1]) {
    final hsl = HSLColor.fromColor(this);
    return hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0)).toColor();
  }

  Color withAlphaFraction(double fraction) {
    return withValues(alpha: fraction.clamp(0.0, 1.0));
  }
}
