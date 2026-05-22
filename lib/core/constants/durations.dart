// lib/core/constants/durations.dart
import 'package:flutter/animation.dart';

/// Centralized animation durations.
abstract final class AppDurations {
  static const Duration unlockTransition = Duration(milliseconds: 450);
  static const Duration lockTransition = Duration(milliseconds: 400);
  static const Duration nowBarAppear = Duration(milliseconds: 300);
  static const Duration nowBarIdlePulse = Duration(seconds: 3);
  static const Duration nowBarTap = Duration(milliseconds: 200);
  static const Duration nowBarContentSwitch = Duration(milliseconds: 250);
  static const Duration clockStyleSwitch = Duration(milliseconds: 200);
  static const Duration swipeHintPulse = Duration(milliseconds: 1500);
  static const Duration notificationEnter = Duration(milliseconds: 350);
  static const Duration rainDropMin = Duration(milliseconds: 400);
  static const Duration rainDropMax = Duration(milliseconds: 600);
  static const Duration clockBreath = Duration(milliseconds: 2000);
  static const Duration clockPulse = Duration(milliseconds: 1800);
  static const Duration clockFlip = Duration(milliseconds: 400);
  static const Duration appOpen = Duration(milliseconds: 350);
  static const Duration pageParallax = Duration(milliseconds: 300);
  static const Duration wallpaperPalette = Duration(milliseconds: 500);
  static const Duration shortcutLongPress = Duration(milliseconds: 500);
  static const Duration nowBarRotation = Duration(seconds: 5);
  static const Duration sunGlow = Duration(milliseconds: 3000);

  static const Curve unlockCurve = Curves.easeOutCubic;
  static const Curve lockCurve = Curves.easeInCubic;
  static const Curve defaultCurve = Curves.easeInOut;
}
