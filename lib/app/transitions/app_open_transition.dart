// lib/app/transitions/app_open_transition.dart
import 'package:flutter/material.dart';
import 'package:oneui85_simulator/core/constants/durations.dart';

class AppOpenTransition extends StatelessWidget {
  const AppOpenTransition({
    super.key,
    required this.animation,
    required this.child,
  });

  final Animation<double> animation;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animation,
      child: ScaleTransition(
        scale: Tween<double>(begin: 0, end: 1).animate(
          CurvedAnimation(parent: animation, curve: Curves.easeOutCubic),
        ),
        child: child,
      ),
    );
  }
}

PageRouteBuilder<T> appOpenRoute<T>(Widget page) {
  return PageRouteBuilder<T>(
    pageBuilder: (_, __, ___) => page,
    transitionDuration: AppDurations.appOpen,
    transitionsBuilder: (_, animation, __, child) {
      return AppOpenTransition(animation: animation, child: child);
    },
  );
}
