// lib/shared/widgets/pill_button.dart
import 'package:flutter/material.dart';
import 'package:oneui85_simulator/app/theme/color_tokens.dart';
import 'package:oneui85_simulator/core/constants/dimensions.dart';

class PillButton extends StatelessWidget {
  const PillButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.glowColor,
  });

  final VoidCallback onPressed;
  final Widget child;
  final Color? glowColor;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(AppDimensions.pillRadius),
        child: Container(
          width: AppDimensions.shortcutButtonSize,
          height: AppDimensions.shortcutButtonSize,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: ColorTokens.glassWhite,
            border: Border.all(color: ColorTokens.pillBorder),
            boxShadow: glowColor != null
                ? [
                    BoxShadow(
                      color: glowColor!.withValues(alpha: 0.6),
                      blurRadius: 16,
                      spreadRadius: 2,
                    ),
                  ]
                : null,
          ),
          child: Center(child: child),
        ),
      ),
    );
  }
}
