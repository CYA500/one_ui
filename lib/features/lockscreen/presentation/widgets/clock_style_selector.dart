// lib/features/lockscreen/presentation/widgets/clock_style_selector.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oneui85_simulator/app/theme/color_tokens.dart';
import 'package:oneui85_simulator/app/theme/typography.dart';
import 'package:oneui85_simulator/core/constants/dimensions.dart';
import 'package:oneui85_simulator/core/constants/durations.dart';
import 'package:oneui85_simulator/features/customization/domain/providers/customization_provider.dart';
import 'package:oneui85_simulator/features/lockscreen/domain/models/clock_style.dart';

class ClockStyleSelector extends ConsumerWidget {
  const ClockStyleSelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = ref.watch(customizationProvider).clockStyle;
    return SizedBox(
      height: 100,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: ClockStyle.values.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final style = ClockStyle.values[index];
          final isSelected = style == selected;
          return GestureDetector(
            onTap: () => ref.read(customizationProvider.notifier).setClockStyle(style),
            child: AnimatedContainer(
              duration: AppDurations.clockStyleSwitch,
              width: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isSelected ? ColorTokens.selectedBorder : Colors.transparent,
                  width: AppDimensions.clockStyleBorder,
                ),
              ),
              transform: Matrix4.identity()
                ..scale(isSelected ? AppDimensions.clockStyleCardScale : 1.0),
              child: AnimatedSwitcher(
                duration: AppDurations.clockStyleSwitch,
                child: Center(
                  key: ValueKey(style),
                  child: Text(
                    _label(style),
                    style: AppTypography.textTheme(ColorTokens.clockTextColor)
                        .labelLarge,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  String _label(ClockStyle style) {
    switch (style) {
      case ClockStyle.digitalThin:
        return 'Thin';
      case ClockStyle.digitalBold:
        return 'Bold';
      case ClockStyle.analog:
        return 'Analog';
      case ClockStyle.retroFlip:
        return 'Flip';
    }
  }
}
