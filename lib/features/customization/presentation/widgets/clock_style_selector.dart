// lib/features/customization/presentation/widgets/clock_style_selector.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../app/theme/color_tokens.dart';
import '../../../../../app/theme/typography.dart';
import '../../../../../core/constants/durations.dart';
import '../../../../lockscreen/domain/models/clock_style.dart';
import '../../../domain/providers/customization_provider.dart';

/// صف أفقي قابل للتمرير يعرض بطاقات أنماط الساعة الأربعة.
class ClockStyleSelector extends ConsumerWidget {
  const ClockStyleSelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedStyle = ref.watch(customizationProvider).clockStyle;
    final notifier = ref.read(customizationProvider.notifier);

    return SizedBox(
      height: 80,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: ClockStyle.values.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final style = ClockStyle.values[index];
          final isSelected = selectedStyle == style;
          return AnimatedContainer(
            duration: AppDurations.short,
            transform: isSelected
                ? (Matrix4.identity()..scale(1.05))
                : Matrix4.identity(),
            child: GestureDetector(
              onTap: () => notifier.setClockStyle(style),
              child: Container(
                width: 64,
                decoration: BoxDecoration(
                  color: ColorTokens.glassWhite,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: isSelected
                        ? ColorTokens.borderActive
                        : ColorTokens.borderGlass,
                    width: isSelected ? 2 : 1,
                  ),
                ),
                child: Center(
                  child: Text(
                    _clockStyleLabel(style),
                    style: AppTypography.nowBarSubtitle.copyWith(
                      color: isSelected ? ColorTokens.accentBlue : Colors.white,
                      fontWeight:
                          isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  String _clockStyleLabel(ClockStyle style) {
    switch (style) {
      case ClockStyle.digitalThin:
        return '12:34';
      case ClockStyle.digitalBold:
        return '12:34';
      case ClockStyle.analog:
        return '🕐';
      case ClockStyle.retroFlip:
        return '12:34';
    }
  }
}
