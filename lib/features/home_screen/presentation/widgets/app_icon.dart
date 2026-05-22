// lib/features/home_screen/presentation/widgets/app_icon.dart
import 'package:flutter/material.dart';
import 'package:oneui85_simulator/app/theme/color_tokens.dart';
import 'package:oneui85_simulator/app/theme/typography.dart';
import 'package:oneui85_simulator/core/constants/dimensions.dart';
import 'package:oneui85_simulator/features/home_screen/domain/providers/home_provider.dart';

class AppIcon extends StatefulWidget {
  const AppIcon({
    super.key,
    required this.app,
    required this.isEditing,
    required this.onRemove,
    required this.onOpen,
  });

  final AppInfo app;
  final bool isEditing;
  final VoidCallback onRemove;
  final VoidCallback onOpen;

  @override
  State<AppIcon> createState() => _AppIconState();
}

class _AppIconState extends State<AppIcon> with SingleTickerProviderStateMixin {
  late final AnimationController _wiggle;

  @override
  void initState() {
    super.initState();
    _wiggle = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    if (widget.isEditing) _wiggle.repeat(reverse: true);
  }

  @override
  void didUpdateWidget(covariant AppIcon oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isEditing && !_wiggle.isAnimating) {
      _wiggle.repeat(reverse: true);
    } else if (!widget.isEditing) {
      _wiggle.stop();
      _wiggle.reset();
    }
  }

  @override
  void dispose() {
    _wiggle.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {},
      onTap: widget.isEditing ? null : widget.onOpen,
      child: AnimatedBuilder(
        animation: _wiggle,
        builder: (context, child) {
          final angle = widget.isEditing ? _wiggle.value * 0.04 - 0.02 : 0.0;
          return Transform.rotate(angle: angle, child: child);
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Hero(
                  tag: 'app-${widget.app.id}',
                  child: Container(
                    width: AppDimensions.appIconSize,
                    height: AppDimensions.appIconSize,
                    decoration: BoxDecoration(
                      color: widget.app.color,
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: const [
                        BoxShadow(
                          color: ColorTokens.wiggleShadow,
                          blurRadius: 8,
                        ),
                      ],
                    ),
                    child: Icon(widget.app.icon, color: Colors.white, size: 28),
                  ),
                ),
                if (widget.isEditing)
                  Positioned(
                    top: -6,
                    right: -6,
                    child: GestureDetector(
                      onTap: widget.onRemove,
                      child: Container(
                        width: 22,
                        height: 22,
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.close, size: 14, color: Colors.white),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              widget.app.name,
              style: AppTypography.textTheme(ColorTokens.clockTextColor).labelLarge,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
