// lib/features/home_screen/presentation/widgets/app_grid.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/durations.dart';
import '../../domain/providers/home_provider.dart';
import 'app_icon.dart';

/// شبكة تطبيقات 4 أعمدة مع دعم السحب والإفلات.
class AppGrid extends ConsumerWidget {
  const AppGrid({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(homeProvider);
    final notifier = ref.read(homeProvider.notifier);
    final apps = state.apps;
    final editMode = state.editMode;

    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        childAspectRatio: 0.75,
      ),
      itemCount: apps.length,
      itemBuilder: (context, index) {
        final app = apps[index];
        return GestureDetector(
          onLongPress: () {
            if (!editMode) {
              notifier.toggleEditMode();
            }
          },
          onTap: () {
            if (editMode) {
              // الخروج من وضع التحرير
              notifier.toggleEditMode();
            } else {
              // فتح التطبيق (محاكاة)
            }
          },
          child: AppIconWidget(
            id: app.id,
            label: app.label,
            icon: app.icon,
            editMode: editMode,
            onRemove: () => notifier.removeApp(app.id),
          ),
        );
      },
    );
  }
}
