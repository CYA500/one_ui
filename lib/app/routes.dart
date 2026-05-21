// lib/app/routes.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../features/lockscreen/presentation/lockscreen_page.dart';
import '../features/home_screen/presentation/home_page.dart';
import '../features/customization/presentation/customization_page.dart';
import '../core/constants/durations.dart';

/// مخصص صفحة الانتقال من شاشة القفل إلى الرئيسية (Unlock).
class UnlockTransitionPage extends CustomTransitionPage<void> {
  UnlockTransitionPage({required super.child})
      : super(
          key: const ValueKey('home'),
          transitionDuration: AppDurations.long,
          reverseTransitionDuration: AppDurations.medium,
          transitionsBuilder:
              (context, animation, secondaryAnimation, child) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, 0.3),
                end: Offset.zero,
              ).animate(CurvedAnimation(
                parent: animation,
                curve: Curves.easeOutCubic,
              )),
              child: FadeTransition(
                opacity: Tween<double>(begin: 0.0, end: 1.0).animate(
                  CurvedAnimation(
                    parent: animation,
                    curve: const Interval(0.3, 1.0),
                  ),
                ),
                child: Transform.scale(
                  scale: Tween<double>(begin: 0.9, end: 1.0).animate(
                    CurvedAnimation(
                      parent: animation,
                      curve: Curves.easeOutBack,
                    ),
                  ),
                  child: child,
                ),
              ),
            );
          },
        );
}

/// مخصص صفحة الانتقال من الشاشة الرئيسية إلى القفل (Lock).
class LockTransitionPage extends CustomTransitionPage<void> {
  LockTransitionPage({required super.child})
      : super(
          key: const ValueKey('lock'),
          transitionDuration: AppDurations.medium,
          reverseTransitionDuration: AppDurations.long,
          transitionsBuilder:
              (context, animation, secondaryAnimation, child) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, -1),
                end: Offset.zero,
              ).animate(CurvedAnimation(
                parent: animation,
                curve: Curves.easeOutCubic,
              )),
              child: FadeTransition(
                opacity: animation,
                child: child,
              ),
            );
          },
        );
}

/// مخصص صفحة التخصيص.
class CustomizationTransitionPage extends CustomTransitionPage<void> {
  CustomizationTransitionPage({required super.child})
      : super(
          key: const ValueKey('customization'),
          transitionDuration: AppDurations.medium,
          transitionsBuilder:
              (context, animation, secondaryAnimation, child) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, 0.5),
                end: Offset.zero,
              ).animate(CurvedAnimation(
                parent: animation,
                curve: Curves.easeOutCubic,
              )),
              child: FadeTransition(
                opacity: animation,
                child: child,
              ),
            );
          },
        );
}

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        pageBuilder: (context, state) => LockTransitionPage(
          child: const LockScreenPage(),
        ),
      ),
      GoRoute(
        path: '/home',
        pageBuilder: (context, state) => UnlockTransitionPage(
          child: const HomePage(),
        ),
      ),
      GoRoute(
        path: '/customization',
        pageBuilder: (context, state) => CustomizationTransitionPage(
          child: const CustomizationPage(),
        ),
      ),
    ],
  );
}
