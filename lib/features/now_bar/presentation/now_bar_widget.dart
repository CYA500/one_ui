// lib/features/now_bar/presentation/now_bar_widget.dart
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oneui85_simulator/app/theme/color_tokens.dart';
import 'package:oneui85_simulator/app/theme/typography.dart';
import 'package:oneui85_simulator/core/constants/dimensions.dart';
import 'package:oneui85_simulator/core/constants/durations.dart';
import 'package:oneui85_simulator/core/extensions/context_ext.dart';
import 'package:oneui85_simulator/core/utils/haptic_util.dart';
import 'package:oneui85_simulator/features/now_bar/domain/providers/now_bar_provider.dart';
import 'package:oneui85_simulator/features/now_bar/presentation/animations/now_bar_animation.dart';
import 'package:oneui85_simulator/features/now_bar/presentation/now_brief_sheet.dart';

class NowBarWidget extends ConsumerStatefulWidget {
  const NowBarWidget({super.key});

  @override
  ConsumerState<NowBarWidget> createState() => _NowBarWidgetState();
}

class _NowBarWidgetState extends ConsumerState<NowBarWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _appearController;
  double _tapScale = 1;

  @override
  void initState() {
    super.initState();
    _appearController = AnimationController(
      vsync: this,
      duration: AppDurations.nowBarAppear,
    )..forward();
  }

  @override
  void dispose() {
    _appearController.dispose();
    super.dispose();
  }

  Future<void> _onTap() async {
    await HapticUtil.selection();
    setState(() => _tapScale = 0.95);
    await Future<void>.delayed(AppDurations.nowBarTap);
    if (mounted) setState(() => _tapScale = 1);
    if (!mounted) return;
    final item = ref.read(currentNowBarItemProvider);
    if (item.type == NowBarItemType.nowBrief) {
      await showNowBriefSheet(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final item = ref.watch(currentNowBarItemProvider);
    final width = context.screenWidth * AppDimensions.nowBarWidthFactor;

    return NowBarAppearAnimation(
      controller: _appearController,
      child: NowBarIdlePulse(
        child: Center(
          child: AnimatedScale(
            scale: _tapScale,
            duration: AppDurations.nowBarTap,
            curve: Curves.elasticOut,
            child: GestureDetector(
              onTap: _onTap,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(AppDimensions.pillRadius),
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: AppDimensions.nowBarBlur,
                    sigmaY: AppDimensions.nowBarBlur,
                  ),
                  child: Container(
                    width: width,
                    height: AppDimensions.nowBarHeight,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          ColorTokens.nowBarGradientStart,
                          ColorTokens.nowBarGradientEnd,
                        ],
                      ),
                      borderRadius:
                          BorderRadius.circular(AppDimensions.pillRadius),
                      border: Border.all(
                        color: ColorTokens.pillBorder,
                        width: AppDimensions.nowBarBorderWidth,
                      ),
                      color: ColorTokens.glassBlue
                          .withValues(alpha: AppDimensions.nowBarOpacity),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    child: AnimatedSwitcher(
                      duration: AppDurations.nowBarContentSwitch,
                      child: Row(
                        key: ValueKey(item.title),
                        children: [
                          Container(
                            width: AppDimensions.nowBarIconSize,
                            height: AppDimensions.nowBarIconSize,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                colors: [
                                  ColorTokens.nowBarGradientStart,
                                  ColorTokens.accentBlue,
                                ],
                              ),
                            ),
                            child: Icon(item.icon, color: Colors.white),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.title,
                                  style: AppTypography.textTheme(
                                    ColorTokens.clockTextColor,
                                  ).titleLarge,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  item.subtitle,
                                  style: AppTypography.textTheme(
                                    ColorTokens.clockTextColor,
                                  ).bodyMedium,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
