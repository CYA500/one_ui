// lib/shared/widgets/animated_gradient_bg.dart
import 'package:flutter/material.dart';
import 'package:oneui85_simulator/core/constants/durations.dart';

class AnimatedGradientBg extends StatefulWidget {
  const AnimatedGradientBg({
    super.key,
    required this.colors,
  });

  final List<Color> colors;

  @override
  State<AnimatedGradientBg> createState() => _AnimatedGradientBgState();
}

class _AnimatedGradientBgState extends State<AnimatedGradientBg>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: AppDurations.sunGlow,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: widget.colors
                  .map((c) => c.withValues(alpha: 0.25 + _controller.value * 0.15))
                  .toList(),
            ),
          ),
        );
      },
    );
  }
}
