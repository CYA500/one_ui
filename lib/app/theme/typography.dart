// lib/app/theme/typography.dart
import 'package:flutter/material.dart';
import 'color_tokens.dart';

/// نظام خطوط Samsung One لتطبيق One UI 8.5.
class AppTypography {
  AppTypography._();

  static const String _fontFamily = 'SamsungOne';
  static const String _fontSharp = 'SamsungSharpSans';

  // ── Clock Display ──
  static const TextStyle clockDisplay = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 72,
    fontWeight: FontWeight.w300,
    letterSpacing: -2,
    color: ColorTokens.clockTextColor,
    height: 1.0,
  );

  static const TextStyle clockDisplayAnalog = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 56,
    fontWeight: FontWeight.w400,
    color: ColorTokens.clockTextColor,
    height: 1.0,
  );

  static const TextStyle clockStyleRetro = TextStyle(
    fontFamily: 'monospace',
    fontSize: 64,
    fontWeight: FontWeight.w700,
    color: ColorTokens.clockTextColor,
    height: 1.0,
  );

  static const TextStyle clockStyleFlip = TextStyle(
    fontFamily: _fontSharp,
    fontSize: 60,
    fontWeight: FontWeight.w800,
    color: ColorTokens.clockTextColor,
    height: 1.0,
  );

  // ── Labels ──
  static const TextStyle dateLabel = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: ColorTokens.dateLabelColor,
  );

  static const TextStyle weatherLabel = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: ColorTokens.weatherLabelColor,
  );

  // ── Utility ──
  static const TextStyle nowBarTitle = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w700,
    color: Colors.white,
  );

  static const TextStyle nowBarSubtitle = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: ColorTokens.glassWhite,
  );

  static const TextStyle shortcutLabel = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 13,
    fontWeight: FontWeight.w500,
    color: Colors.white,
  );

  static const TextStyle appIconLabel = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 11,
    fontWeight: FontWeight.w400,
    color: Colors.white,
  );
}
