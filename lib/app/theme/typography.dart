// lib/app/theme/typography.dart
import 'package:flutter/material.dart';
import 'package:oneui85_simulator/app/theme/color_tokens.dart';

/// Samsung One typography scale.
abstract final class AppTypography {
  static const String samsungOne = 'SamsungOne';
  static const String samsungSharp = 'SamsungSharpSans';

  static TextStyle clockDisplay(Color color) => TextStyle(
        fontFamily: samsungOne,
        fontSize: 72,
        fontWeight: FontWeight.w300,
        letterSpacing: -2,
        color: color,
      );

  static TextStyle clockDisplayAnalog(Color color) => TextStyle(
        fontFamily: samsungOne,
        fontSize: 56,
        fontWeight: FontWeight.w400,
        color: color,
      );

  static TextStyle clockStyleRetro(Color color) => TextStyle(
        fontFamily: 'monospace',
        fontSize: 64,
        fontWeight: FontWeight.w700,
        color: color,
      );

  static TextStyle clockStyleFlip(Color color) => TextStyle(
        fontFamily: samsungSharp,
        fontSize: 60,
        fontWeight: FontWeight.w800,
        color: color,
      );

  static TextStyle dateLabel(Color color) => TextStyle(
        fontFamily: samsungOne,
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: color.withValues(alpha: 0.85),
      );

  static TextStyle weatherLabel(Color color) => TextStyle(
        fontFamily: samsungOne,
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: color.withValues(alpha: 0.85),
      );

  static TextTheme textTheme(Color color) => TextTheme(
        displayLarge: clockDisplay(color),
        titleLarge: TextStyle(
          fontFamily: samsungOne,
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: color,
        ),
        titleMedium: TextStyle(
          fontFamily: samsungOne,
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: color,
        ),
        bodyMedium: TextStyle(
          fontFamily: samsungOne,
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: ColorTokens.weatherIconTint,
        ),
        labelLarge: TextStyle(
          fontFamily: samsungOne,
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: color.withValues(alpha: 0.7),
        ),
      );
}
