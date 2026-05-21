// lib/features/now_bar/presentation/now_bar_widget.dart
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../app/theme/color_tokens.dart';
import '../../../../app/theme/typography.dart';
import '../../../../core/constants/dimensions.dart';
import '../../../../core/constants/durations.dart';
import '../domain/providers/now_bar_provider.dart';
import 'animations/now_bar_animation.dart';

class NowBarWidget extends ConsumerStatefulWidget {
  const NowBarWidget({super.key});

  @override
  ConsumerState<NowBarWidget> createState() => _NowBarWidgetState();
}

class _NowBarWidgetState extends ConsumerState<NowBarWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _pulseController;
  late final AnimationController _tapController;
  late final Animation<double> _pulseScale;

  @override
  void initState() {
    super.initState();

    // Idle pulse: scale 0.98 ↔ 1.0
    _pulseController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);
    _pulseScale = Tween<double>(begin: 0.98, end: 1.0).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    // Tap controller (one-shot)
    _tapController = AnimationController(
      duration: AppDurations.short,
      vsync: this,
    );
    _tapController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _tapController.reverse();
      }
    });
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _tapController.dispose();
    super.dispose();
  }

  void _onTap() {
    _tapController.forward(from: 0.0);
    // Open Now Brief sheet (calls parent or navigation - will be connected later)
    // For now, just animation.
  }

  @override
  Widget build(BuildContext context) {
    final nowBarItemAsync = ref.watch(nowBarItemProvider);

    return Center(
      child: NowBarEntranceAnimation(
        child: AnimatedBuilder(
          animation: Listenable.merge([_pulseController, _tapController]),
          builder: (context, child) {
            // Combine idle pulse + tap scale
            final scale =
                _pulseScale.value * (1.0 - (_tapController.value * 0.05));
            return Transform.scale(
              scale: scale,
              child: GestureDetector(
                onTap: _onTap,
                child: Container(
                  height: AppDimensions.nowBarHeight,
                  width: MediaQuery.of(context).size.width *
                      AppDimensions.nowBarWidthRatio,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(28),
                    border: Border.all(color: ColorTokens.borderGlass),
                    gradient: const LinearGradient(
                      colors: [
                        ColorTokens.nowBarGradientStart,
                        ColorTokens.nowBarGradientEnd,
                      ],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: ColorTokens.nowBarGradientStart.withOpacity(0.2),
                        blurRadius: 12,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(28),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: nowBarItemAsync.when(
                          data: (item) => _NowBarContent(item: item),
                          loading: () => const _NowBarLoading(),
                          error: (_, __) => const _NowBarLoading(),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

// ─── Content Layout ───
class _NowBarContent extends StatelessWidget {
  final NowBarItem item;
  const _NowBarContent({required this.item});

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: AppDurations.short,
      child: Row(
        key: ValueKey(item.title),
        children: [
          // أيقونة دائرية
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                colors: [
                  ColorTokens.accentBlue,
                  ColorTokens.nowBarGradientEnd,
                ],
              ),
            ),
            child: Icon(item.icon, color: Colors.white, size: 18),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: AppTypography.nowBarTitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  item.subtitle,
                  style: AppTypography.nowBarSubtitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _NowBarLoading extends StatelessWidget {
  const _NowBarLoading();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox(
        width: 24,
        height: 24,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          color: Colors.white,
        ),
      ),
    );
  }
}
