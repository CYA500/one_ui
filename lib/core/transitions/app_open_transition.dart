// lib/core/transitions/app_open_transition.dart
import 'package:flutter/material.dart';
import '../constants/durations.dart';

/// انتقال فتح التطبيق: الأيقونة تكبر من 0 إلى 1 مع تلاشي،
/// والشاشة تظهر من مركز الأيقونة (hero animation).
class AppOpenTransition extends PageRouteBuilder {
  final Widget page;
  final Offset center; // مركز الأيقونة على الشاشة

  AppOpenTransition({
    required this.page,
    this.center = Offset.zero,
  }) : super(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionDuration: AppDurations.medium,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            // الأيقونة تكبر من الصفر إلى الحجم الكامل
            final scale = Tween<double>(begin: 0.0, end: 1.0).animate(
              CurvedAnimation(parent: animation, curve: Curves.easeOutBack),
            );
            final opacity = Tween<double>(begin: 0.0, end: 1.0).animate(
              CurvedAnimation(parent: animation, curve: Curves.easeIn),
            );

            // انزياح من موقع الأيقونة إلى المركز (اختياري)
            final offset = Tween<Offset>(
              begin: center / MediaQuery.of(context).size,
              end: Offset.zero,
            ).animate(
              CurvedAnimation(parent: animation, curve: Curves.easeOut),
            );

            return Transform.scale(
              scale: scale.value,
              child: Opacity(
                opacity: opacity.value,
                child: FractionalTranslation(
                  translation: offset.value,
                  child: child,
                ),
              ),
            );
          },
        );
}
