// lib/core/utils/haptic_util.dart
import 'package:flutter/services.dart';

/// Haptic feedback helpers for One UI interactions.
abstract final class HapticUtil {
  static Future<void> light() => HapticFeedback.lightImpact();
  static Future<void> medium() => HapticFeedback.mediumImpact();
  static Future<void> heavy() => HapticFeedback.heavyImpact();
  static Future<void> selection() => HapticFeedback.selectionClick();
}
