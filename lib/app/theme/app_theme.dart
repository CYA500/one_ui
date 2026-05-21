// lib/app/theme/app_theme.dart
import 'package:flutter/material.dart';
import 'color_tokens.dart';
import 'typography.dart';

/// ThemeData النهائي للتطبيق، يستخدم tokens.
class AppTheme {
  AppTheme._();

  static ThemeData get light => ThemeData(
        brightness: Brightness.dark,
        primaryColor: ColorTokens.accentBlue,
        scaffoldBackgroundColor: ColorTokens.primarySurface,
        fontFamily: 'SamsungOne',
        colorScheme: const ColorScheme.dark(
          primary: ColorTokens.accentBlue,
          surface: ColorTokens.primarySurface,
          onPrimary: Colors.white,
          onSurface: Colors.white,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
        ),
        bottomSheetTheme: const BottomSheetThemeData(
          backgroundColor: ColorTokens.primarySurfaceLight,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
          ),
        ),
        extensions: const <ThemeExtension<dynamic>>[
          // يمكن إضافة ColorTokens أو Typography كـ extension إن لزم
        ],
      );
}
