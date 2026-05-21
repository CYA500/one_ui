// lib/features/now_bar/presentation/now_brief_sheet.dart
import 'package:flutter/material.dart';
import '../../../../app/theme/color_tokens.dart';

class NowBriefSheet extends StatelessWidget {
  const NowBriefSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.45,
      minChildSize: 0.3,
      maxChildSize: 0.85,
      expand: false,
      builder: (context, scrollController) {
        return ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
            child: Container(
              decoration: BoxDecoration(
                color: ColorTokens.blurredNotifBg,
                border: Border.all(
                  color: ColorTokens.borderGlass,
                  width: 0.5,
                ),
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(28)),
              ),
              child: ListView(
                controller: scrollController,
                padding: const EdgeInsets.all(20),
                children: [
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      margin: const EdgeInsets.only(bottom: 16),
                      decoration: BoxDecoration(
                        color: Colors.white24,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  _buildSection('📰 News', [
                    'Samsung releases One UI 8.5 beta for Galaxy S30',
                    'New AI features announced for Galaxy Watch',
                  ]),
                  const SizedBox(height: 20),
                  _buildSection('☁️ Weather',
                      ['London: 18°C, partly cloudy', 'Rain expected later']),
                  const SizedBox(height: 20),
                  _buildSection('📅 Calendar',
                      ['10:00 AM – Stand-up meeting', '12:30 PM – Lunch with Alex']),
                  const SizedBox(height: 20),
                  _buildSection('✅ Tasks', [
                    'Prepare presentation for Monday',
                    'Review code merge requests',
                  ]),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildSection(String title, List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 8),
        ...items.map((item) => Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Text(
                item,
                style: const TextStyle(color: Colors.white70, fontSize: 14),
              ),
            )),
      ],
    );
  }
}
