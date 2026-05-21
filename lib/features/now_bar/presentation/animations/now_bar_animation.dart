// lib/features/now_bar/presentation/animations/now_bar_animation.dart
import 'package:flutter/material.dart';
import '../../../../../core/constants/durations.dart';

/// أنيميشن ظهور شريط Now Bar: انزلاق من الأسفل مع تلاشي.
class NowBarEntranceAnimation extends StatefulWidget {
  final Widget child;
  const NowBarEntranceAnimation({super.key, required this.child});

  @override
  State<NowBarEntranceAnimation> createState() =>
      _NowBarEntranceAnimationState();
}

class _NowBarEntranceAnimationState extends State<NowBarEntranceAnimation>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fade;
  late final Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: AppDurations.medium,
      vsync: this,
    );
    _fade = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
    _slide = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fade,
      child: SlideTransition(
        position: _slide,
        child: widget.child,
      ),
    );
  }
}
