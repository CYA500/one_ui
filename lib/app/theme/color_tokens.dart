// lib/app/theme/color_tokens.dart
import 'package:flutter/material.dart';

/// Samsung One UI 8.5 inspired color tokens.
/// كل الألوان المستخدمة في التطبيق تُعرّف هنا فقط.
class ColorTokens {
  ColorTokens._();

  // ─── Primary Surfaces ───
  static const Color primarySurface = Color(0xFF1A1A2E);
  static const Color primarySurfaceLight = Color(0xFF25253D);

  // ─── Glass & Translucent ───
  static const Color glassWhite = Color(0x1AFFFFFF);
  static const Color glassBlue = Color(0x26407BFF);
  static const Color glassDark = Color(0x1A000000);

  // ─── Accent & Gradients ───
  static const Color accentBlue = Color(0xFF407BFF);
  static const Color nowBarGradientStart = Color(0xFF3EC6E0);
  static const Color nowBarGradientEnd = Color(0xFF5B86E5);

  // ─── Clock & Text ───
  static const Color clockTextColor = Colors.white;
  static const Color dateLabelColor = Color(0xD9FFFFFF); // 0.85 opacity
  static const Color weatherLabelColor = Color(0xD9FFFFFF);

  // ─── Notifications ───
  static const Color blurredNotifBg = Color(0x80000000);

  // ─── Weather & Icons ───
  static const Color weatherIconTint = Color(0xFFE8F4FD);

  // ─── Shortcuts ───
  static const Color shortcutRed = Color(0xFFE63946);
  static const Color shortcutRedGlow = Color(0x40E63946);

  // ─── Borders & Dividers ───
  static const Color borderGlass = Color(0x40FFFFFF);
  static const Color borderActive = Color(0xFF407BFF);
}
