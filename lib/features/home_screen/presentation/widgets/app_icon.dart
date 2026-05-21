// lib/features/home_screen/presentation/widgets/app_icon.dart
import 'dart:math';
import 'package:flutter/material.dart';
import '../../../../../app/theme/color_tokens.dart';
import '../../../../../app/theme/typography.dart';
import '../../../../core/constants/durations.dart';

/// ويدجت أيقونة تطبيق واحدة مع تأثير wiggle وزر X عند وضع التحرير.
class AppIconWidget extends StatefulWidget {
  final String id;
  final String label;
  final IconData icon;
  final bool editMode;
  final VoidCallback? onRemove;
  const AppIconWidget({
    super.key,
    required this.id,
    required this.label,
    required this.icon,
    required this.editMode,
    this.onRemove,
  });

  @override
  State<AppIconWidget> createState() => _AppIconWidgetState();
}

class _AppIconWidgetState extends State<AppIconWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _wiggleController;
  double _angle = 0;

  @override
  void initState() {
    super.initState();
    _wiggleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    if (widget.editMode) _startWiggle();
  }

  @override
  void didUpdateWidget(AppIconWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.editMode && !_wiggleController.isAnimating) {
      _startWiggle();
    } else if (!widget.editMode) {
      _wiggleController.stop();
      setState(() => _angle = 0);
    }
  }

  void _startWiggle() {
    _wiggleController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _wiggleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _wiggleController,
      builder: (context, child) {
        if (widget.editMode) {
          // دوران صغير متأرجح
          _angle = sin(_wiggleController.value * 2 * pi) * 0.05;
        }
        return Transform.rotate(
          angle: _angle,
          child: child,
        );
      },
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // الأيقونة الرئيسية
          Container(
            width: 64,
            height: 64,
            margin: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: ColorTokens.glassWhite,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: ColorTokens.borderGlass),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(widget.icon, color: Colors.white, size: 26),
                const SizedBox(height: 2),
                Text(
                  widget.label,
                  style: AppTypography.appIconLabel,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          // زر X في وضع التحرير
          if (widget.editMode)
            Positioned(
              top: -2,
              right: -2,
              child: GestureDetector(
                onTap: widget.onRemove,
                child: Container(
                  width: 20,
                  height: 20,
                  decoration: const BoxDecoration(
                    color: ColorTokens.shortcutRed,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.close, size: 12, color: Colors.white),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
