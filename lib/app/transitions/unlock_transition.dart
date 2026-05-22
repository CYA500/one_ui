// lib/app/transitions/unlock_transition.dart
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:oneui85_simulator/core/constants/dimensions.dart';

/// [animation.value] 1 = locked, 0 = unlocked.
class UnlockTransition extends StatelessWidget {
  const UnlockTransition({
    super.key,
    required this.animation,
    required this.lockChild,
    required this.homeChild,
  });

  final Animation<double> animation;
  final Widget lockChild;
  final Widget homeChild;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        final t = animation.value;
        return Stack(
          fit: StackFit.expand,
          children: [
            Transform.scale(
              scale: AppDimensions.homeScaleStart +
                  (1 - AppDimensions.homeScaleStart) * (1 - t),
              child: Opacity(
                opacity: 1 - t * 0.25,
                child: homeChild,
              ),
            ),
            Transform.translate(
              offset: Offset(0, -80 * (1 - t)),
              child: Transform.scale(
                scale: 1 - t * 0.08,
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: t * 12, sigmaY: t * 12),
                  child: Opacity(
                    opacity: t.clamp(0, 1),
                    child: lockChild,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
