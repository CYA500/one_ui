// lib/features/now_bar/presentation/animations/now_bar_animation.dart
import 'package:flutter/material.dart';
import 'package:oneui85_simulator/core/constants/durations.dart';

class NowBarAppearAnimation extends StatelessWidget {
  const NowBarAppearAnimation({
    super.key,
    required this.child,
    required this.controller,
  });

  final Widget child;
  final Animation<double> controller;

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero)
          .animate(CurvedAnimation(parent: controller, curve: AppDurations.defaultCurve)),
      child: FadeTransition(opacity: controller, child: child),
    );
  }
}

class NowBarIdlePulse extends StatefulWidget {
  const NowBarIdlePulse({super.key, required this.child});

  final Widget child;

  @override
  State<NowBarIdlePulse> createState() => _NowBarIdlePulseState();
}

class _NowBarIdlePulseState extends State<NowBarIdlePulse>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: AppDurations.nowBarIdlePulse,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: Tween(begin: 0.98, end: 1.0).animate(_controller),
      child: widget.child,
    );
  }
}
