// lib/features/customization/presentation/widgets/clock_customizer.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oneui85_simulator/core/constants/strings.dart';
import 'package:oneui85_simulator/features/customization/domain/providers/customization_provider.dart';
import 'package:oneui85_simulator/features/lockscreen/presentation/widgets/clock_style_selector.dart';

class ClockCustomizer extends ConsumerWidget {
  const ClockCustomizer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(customizationProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(AppStrings.clockStyleSection),
        const SizedBox(height: 8),
        const ClockStyleSelector(),
        const SizedBox(height: 16),
        SwitchListTile(
          value: state.showDate,
          onChanged: (_) => ref.read(customizationProvider.notifier).toggleDate(),
          title: const Text('Show date'),
        ),
        SwitchListTile(
          value: state.showWeather,
          onChanged: (_) =>
              ref.read(customizationProvider.notifier).toggleWeather(),
          title: const Text('Show weather'),
        ),
      ],
    );
  }
}
