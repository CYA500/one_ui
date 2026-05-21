// lib/core/transitions/unlock_transition.dart
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../../app/theme/color_tokens.dart';
import '../constants/durations.dart';

/// انتقال فتح القفل: شاشة القفل تنكمش لأعلى مع blur+fade،
/// والشاشة الرئيسية تظهر من الخلف بتكبير من 0.9 إلى 1.0.
class UnlockTransition extends PageRouteBuilder {
  final Widget lockScreen;
  final Widget homeScreen;

  UnlockTransition({
    required this.lockScreen,
    required this.homeScreen,
  }) : super(
          pageBuilder: (context, animation, secondaryAnimation) => homeScreen,
          transitionDuration: AppDurations.long,
          reverseTransitionDuration: AppDurations.medium,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            // Blur & fade للقفل
            final lockOpacity = Tween<double>(begin: 1.0, end: 0.0).animate(
              CurvedAnimation(parent: animation, curve: Curves.easeInOut),
            );
            final lockOffset = Tween<Offset>(
              begin: Offset.zero,
              end: const Offset(0.0, -0.3),
            ).animate(
              CurvedAnimation(parent: animation, curve: Curves.easeInOut),
            );
            final lockBlur = Tween<double>(begin: 0, end: 10).animate(animation);

            // ظهور المنزل
            final homeScale = Tween<double>(begin: 0.9, end: 1.0).animate(
              CurvedAnimation(parent: animation, curve: Curves.easeOutBack),
            );
            final homeOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
              CurvedAnimation(parent: animation, curve: const Interval(0.4, 1.0)),
            );

            return Stack(
              fit: StackFit.expand,
              children: [
                // الشاشة الرئيسية في الخلف
                Transform.scale(
                  scale: homeScale.value,
                  child: Opacity(
                    opacity: homeOpacity.value,
                    child: child,
                  ),
                ),
                // شاشة القفل تختفي مع بلور وحركة
                Opacity(
                  opacity: lockOpacity.value,
                  child: SlideTransition(
                    position: lockOffset,
                    child: BackdropFilter(
                      filter: ImageFilter.blur(
                        sigmaX: lockBlur.value,
                        sigmaY: lockBlur.value,
                      ),
                      child: lockScreen,
                    ),
                  ),
                ),
              ],
            );
          },
        );
}
