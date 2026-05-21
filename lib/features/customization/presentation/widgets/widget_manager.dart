// lib/features/customization/presentation/widgets/widget_manager.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../app/theme/color_tokens.dart';
import '../../../../../app/theme/typography.dart';
import '../../../../domain/providers/customization_provider.dart';

/// إدارة ويدجات شاشة القفل (إضافة / إزالة / ترتيب).
class WidgetManager extends ConsumerStatefulWidget {
  const WidgetManager({super.key});

  @override
  ConsumerState<WidgetManager> createState() => _WidgetManagerState();
}

class _WidgetManagerState extends ConsumerState<WidgetManager> {
  // قائمة الويدجات المتاحة للتبديل
  static const List<_LockWidgetInfo> availableWidgets = [
    _LockWidgetInfo('steps', 'Steps', Icons.directions_walk),
    _LockWidgetInfo('heart_rate', 'Heart Rate', Icons.favorite),
    _LockWidgetInfo('alarm', 'Alarm', Icons.alarm),
    _LockWidgetInfo('calendar', 'Calendar', Icons.calendar_today),
    _LockWidgetInfo('battery', 'Battery', Icons.battery_full),
    _LockWidgetInfo('sleep', 'Sleep', Icons.bedtime),
  ];

  @override
  Widget build(BuildContext context) {
    final customization = ref.watch(customizationProvider);
    final notifier = ref.read(customizationProvider.notifier);
    final activeWidgets = customization.activeWidgets;

    return ReorderableListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      buildDefaultDragHandles: false,
      onReorder: (oldIndex, newIndex) {
        final updated = List<String>.from(activeWidgets);
        if (newIndex > oldIndex) newIndex--;
        final item = updated.removeAt(oldIndex);
        updated.insert(newIndex, item);
        notifier.updateWidgets(updated);
      },
      itemCount: availableWidgets.length,
      itemBuilder: (context, index) {
        final info = availableWidgets[index];
        final isActive = activeWidgets.contains(info.id);
        return Container(
          key: Key(info.id),
          margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
          decoration: BoxDecoration(
            color: ColorTokens.glassWhite,
            borderRadius: BorderRadius.circular(12),
          ),
          child: ListTile(
            leading: Icon(info.icon, color: Colors.white),
            title: Text(info.name, style: AppTypography.nowBarTitle),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.drag_handle, color: Colors.white38),
                  onPressed: () {},
                ),
                Switch(
                  value: isActive,
                  onChanged: (val) {
                    final updated = List<String>.from(activeWidgets);
                    if (val) {
                      if (!updated.contains(info.id)) updated.add(info.id);
                    } else {
                      updated.remove(info.id);
                    }
                    notifier.updateWidgets(updated);
                  },
                  activeColor: ColorTokens.accentBlue,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _LockWidgetInfo {
  final String id;
  final String name;
  final IconData icon;
  const _LockWidgetInfo(this.id, this.name, this.icon);
}
