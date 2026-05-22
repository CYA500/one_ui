// lib/shared/widgets/glassmorphism_card.dart
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:oneui85_simulator/app/theme/color_tokens.dart';
import 'package:oneui85_simulator/core/constants/dimensions.dart';

class GlassmorphismCard extends StatelessWidget {
  const GlassmorphismCard({
    super.key,
    required this.child,
    this.blur = AppDimensions.glassBlurLight,
    this.padding = const EdgeInsets.all(16),
    this.borderRadius = AppDimensions.cardRadius,
  });

  final Widget child;
  final double blur;
  final EdgeInsets padding;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: Container(
          padding: padding,
          decoration: BoxDecoration(
            color: ColorTokens.glassWhite,
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(color: ColorTokens.pillBorder),
          ),
          child: child,
        ),
      ),
    );
  }
}
