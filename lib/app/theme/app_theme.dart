// lib/app/theme/app_theme.dart
import 'package:flutter/material.dart';
import 'package:oneui85_simulator/app/theme/color_tokens.dart';
import 'package:oneui85_simulator/app/theme/typography.dart';

/// Application theme matching One UI dark aesthetic.
abstract final class AppTheme {
  static ThemeData get dark {
    const color = ColorTokens.clockTextColor;
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: ColorTokens.primarySurface,
      fontFamily: AppTypography.samsungOne,
      colorScheme: const ColorScheme.dark(
        primary: ColorTokens.accentBlue,
        surface: ColorTokens.primarySurface,
        onSurface: color,
      ),
      textTheme: AppTypography.textTheme(color),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
    );
  }
}
