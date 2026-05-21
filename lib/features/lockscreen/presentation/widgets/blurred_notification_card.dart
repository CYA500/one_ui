// lib/features/lockscreen/presentation/widgets/blurred_notification_card.dart
import 'package:flutter/material.dart';
import '../../../../../app/theme/color_tokens.dart';

class BlurredNotificationCard extends StatelessWidget {
  final String title;
  final String body;
  const BlurredNotificationCard({
    super.key,
    required this.title,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          width: 320,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: ColorTokens.blurredNotifBg,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: ColorTokens.borderGlass),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.w600, color: Colors.white)),
              const SizedBox(height: 4),
              Text(body, style: const TextStyle(color: Colors.white70)),
            ],
          ),
        ),
      ),
    );
  }
}
