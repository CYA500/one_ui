// lib/features/customization/presentation/widgets/widget_manager.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oneui85_simulator/core/constants/strings.dart';
import 'package:oneui85_simulator/features/customization/domain/providers/customization_provider.dart';

class WidgetManager extends ConsumerWidget {
  const WidgetManager({super.key});

  static const _allWidgets = [
    AppStrings.stepsWidget,
    AppStrings.heartRateWidget,
    AppStrings.alarmWidget,
    AppStrings.calendarWidget,
    AppStrings.batteryWidget,
    AppStrings.sleepWidget,
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final active = ref.watch(customizationProvider).activeWidgets;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(AppStrings.widgetsSection),
        const SizedBox(height: 8),
        ReorderableListView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          onReorder: (oldIndex, newIndex) => ref
              .read(customizationProvider.notifier)
              .reorderWidgets(oldIndex, newIndex),
          children: active.map((name) {
            return ListTile(
              key: ValueKey(name),
              title: Text(name),
              trailing: Switch(
                value: true,
                onChanged: (v) => ref
                    .read(customizationProvider.notifier)
                    .toggleWidget(name, v),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: _allWidgets
              .where((w) => !active.contains(w))
              .map(
                (name) => ActionChip(
                  label: Text(name),
                  onPressed: () => ref
                      .read(customizationProvider.notifier)
                      .toggleWidget(name, true),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}
