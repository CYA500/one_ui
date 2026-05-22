// lib/features/home_screen/presentation/widgets/dock_bar.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oneui85_simulator/app/theme/color_tokens.dart';
import 'package:oneui85_simulator/core/constants/dimensions.dart';
import 'package:oneui85_simulator/features/home_screen/domain/providers/home_provider.dart';

class DockBar extends ConsumerWidget {
  const DockBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final apps = ref.watch(dockAppsProvider);
    return Container(
      height: AppDimensions.dockHeight,
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: ColorTokens.dockBackground,
        borderRadius: BorderRadius.circular(AppDimensions.pillRadius),
        border: Border.all(color: ColorTokens.pillBorder),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: apps
            .map(
              (app) => IconButton(
                icon: Icon(app.icon, color: Colors.white, size: 28),
                onPressed: () {},
              ),
            )
            .toList(),
      ),
    );
  }
}
