// lib/features/lockscreen/presentation/widgets/shortcut_buttons.dart
import 'package:flutter/material.dart';
import '../../../../../app/theme/color_tokens.dart';
import '../../../../../app/theme/typography.dart';
import '../../../../../core/constants/dimensions.dart';

class ShortcutButtons extends StatelessWidget {
  const ShortcutButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _ShortcutButton(
            icon: Icons.phone,
            label: 'Call',
            color: ColorTokens.shortcutRed,
            glow: ColorTokens.shortcutRedGlow,
          ),
          _ShortcutButton(
            icon: Icons.camera_alt,
            label: 'Camera',
            color: ColorTokens.shortcutRed,
            glow: ColorTokens.shortcutRedGlow,
          ),
        ],
      ),
    );
  }
}

class _ShortcutButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final Color glow;
  const _ShortcutButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.glow,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        // Simulate activation
      },
      child: Container(
        width: AppDimensions.shortcutSize,
        height: AppDimensions.shortcutSize,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: ColorTokens.glassWhite,
          border: Border.all(color: ColorTokens.borderGlass),
          boxShadow: [
            BoxShadow(
              color: glow,
              blurRadius: 12,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(height: 2),
            Text(label, style: AppTypography.shortcutLabel),
          ],
        ),
      ),
    );
  }
}
