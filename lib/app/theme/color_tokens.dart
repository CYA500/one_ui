// lib/app/theme/color_tokens.dart
import 'package:flutter/material.dart';

/// One UI 8.5 color tokens — use only these in UI code.
abstract final class ColorTokens {
  static const Color primarySurface = Color(0xFF1A1A2E);
  static const Color glassWhite = Color(0x1AFFFFFF);
  static const Color glassBlue = Color(0x26407BFF);
  static const Color accentBlue = Color(0xFF407BFF);
  static const Color nowBarGradientStart = Color(0xFF3EC6E0);
  static const Color nowBarGradientEnd = Color(0xFF5B86E5);
  static const Color clockTextColor = Colors.white;
  static const Color blurredNotifBg = Color(0x80000000);
  static const Color weatherIconTint = Color(0xFFE8F4FD);
  static const Color shortcutPhoneGlow = Color(0xFFE53935);
  static const Color shortcutCameraGlow = Color(0xFFE53935);
  static const Color pillBorder = Color(0x33FFFFFF);
  static const Color dockBackground = Color(0x26FFFFFF);
  static const Color selectedBorder = accentBlue;
  static const Color wiggleShadow = Color(0x40000000);

  static const List<Color> clockColorPresets = [
    Colors.white,
    Color(0xFF3EC6E0),
    Color(0xFF5B86E5),
    Color(0xFFFFB74D),
    Color(0xFF81C784),
    Color(0xFFE57373),
    Color(0xFFBA68C8),
    Color(0xFF90A4AE),
  ];
}
