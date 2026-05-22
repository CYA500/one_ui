// lib/features/lockscreen/presentation/widgets/blurred_notification_card.dart
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:oneui85_simulator/app/theme/color_tokens.dart';
import 'package:oneui85_simulator/app/theme/typography.dart';
import 'package:oneui85_simulator/core/constants/dimensions.dart';

class BlurredNotificationCard extends StatelessWidget {
  const BlurredNotificationCard({
    super.key,
    required this.title,
    required this.body,
    this.scale = 1,
    this.offsetY = 0,
  });

  final String title;
  final String body;
  final double scale;
  final double offsetY;

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(0, offsetY),
      child: Transform.scale(
        scale: scale,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(AppDimensions.cardRadius),
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: AppDimensions.notificationBlur,
              sigmaY: AppDimensions.notificationBlur,
            ),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: ColorTokens.blurredNotifBg,
                borderRadius: BorderRadius.circular(AppDimensions.cardRadius),
                border: Border.all(color: ColorTokens.pillBorder),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTypography.textTheme(ColorTokens.clockTextColor)
                        .titleMedium,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    body,
                    style: AppTypography.textTheme(ColorTokens.clockTextColor)
                        .bodyMedium,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
