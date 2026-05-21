// lib/core/transitions/lock_transition.dart
import 'package:flutter/material.dart';
import '../../app/theme/color_tokens.dart';
import '../constants/durations.dart';

/// انتقال القفل: الشاشة الرئيسية تتجمد ويزداد البلور،
/// وشاشة القفل تنزلق من الأعلى.
class LockTransition extends PageRouteBuilder {
  final Widget homeScreen;
  final Widget lockScreen;

  LockTransition({
    required this.homeScreen,
    required this.lockScreen,
  }) : super(
          pageBuilder: (context, animation, secondaryAnimation) => lockScreen,
          transitionDuration: AppDurations.medium,
          reverseTransitionDuration: AppDurations.long,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            // تجميد المنزل + بلور
            final homeBlur = Tween<double>(begin: 0.0, end: 15.0).animate(animation);
            // انزلاق شاشة القفل من الأعلى
            final lockOffset = Tween<Offset>(
              begin: const Offset(0.0, -1.0),
              end: Offset.zero,
            ).animate(
              CurvedAnimation(parent: animation, curve: Curves.easeOutCubic),
            );
            final lockOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(animation);

            return Stack(
              fit: StackFit.expand,
              children: [
                // المنزل في الخلف مع زيادة البلور
                BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: homeBlur.value,
                    sigmaY: homeBlur.value,
                  ),
                  child: homeScreen,
                ),
                // شاشة القفل تنزل
                SlideTransition(
                  position: lockOffset,
                  child: Opacity(
                    opacity: lockOpacity.value,
                    child: child,
                  ),
                ),
              ],
            );
          },
        );
}
