// lib/features/now_bar/presentation/now_brief_sheet.dart
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:oneui85_simulator/app/theme/color_tokens.dart';
import 'package:oneui85_simulator/app/theme/typography.dart';
import 'package:oneui85_simulator/core/constants/strings.dart';
import 'package:oneui85_simulator/shared/widgets/glassmorphism_card.dart';

Future<void> showNowBriefSheet(BuildContext context) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => const NowBriefSheet(),
  );
}

class NowBriefSheet extends StatelessWidget {
  const NowBriefSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.55,
      minChildSize: 0.35,
      maxChildSize: 0.9,
      builder: (context, scrollController) {
        return ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 24, sigmaY: 24),
            child: Container(
              color: ColorTokens.primarySurface.withValues(alpha: 0.85),
              child: ListView(
                controller: scrollController,
                padding: const EdgeInsets.all(24),
                children: [
                  Text(
                    AppStrings.nowBriefTitle,
                    style: AppTypography.textTheme(ColorTokens.clockTextColor)
                        .titleLarge,
                  ),
                  const SizedBox(height: 16),
                  GlassmorphismCard(
                    child: Text(
                      AppStrings.nowBriefNews,
                      style: AppTypography.textTheme(ColorTokens.clockTextColor)
                          .bodyMedium,
                    ),
                  ),
                  const SizedBox(height: 12),
                  GlassmorphismCard(
                    child: Text(
                      AppStrings.nowBriefWeather,
                      style: AppTypography.textTheme(ColorTokens.clockTextColor)
                          .bodyMedium,
                    ),
                  ),
                  const SizedBox(height: 12),
                  GlassmorphismCard(
                    child: Text(
                      AppStrings.nowBriefCalendar,
                      style: AppTypography.textTheme(ColorTokens.clockTextColor)
                          .bodyMedium,
                    ),
                  ),
                  const SizedBox(height: 12),
                  GlassmorphismCard(
                    child: Text(
                      AppStrings.nowBriefTasks,
                      style: AppTypography.textTheme(ColorTokens.clockTextColor)
                          .bodyMedium,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
