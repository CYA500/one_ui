// lib/features/lockscreen/presentation/lockscreen_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../app/theme/color_tokens.dart';
import '../../../../core/constants/dimensions.dart';
import '../domain/providers/weather_provider.dart';
import 'widgets/clock_widget.dart';
import 'widgets/notification_stack.dart';
import 'widgets/shortcut_buttons.dart';
import 'widgets/swipe_hint.dart';
import 'animations/animated_weather_overlay.dart';

class LockScreenPage extends ConsumerWidget {
  const LockScreenPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weatherAsync = ref.watch(currentWeatherProvider);

    return Scaffold(
      backgroundColor: ColorTokens.primarySurface,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // 1. Wallpaper Layer (placeholder)
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/wallpapers/default_1.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // 2. Weather Animation Layer
          weatherAsync.when(
            data: (data) => AnimatedWeatherOverlay(conditionCode: data.conditionCode),
            loading: () => const SizedBox(),
            error: (_, __) => const SizedBox(),
          ),
          // 3. Clock Layer
          const Center(
            child: Padding(
              padding: EdgeInsets.only(top: 80),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ClockWidget(),
                ],
              ),
            ),
          ),
          // 4. Notification Layer
          const Positioned(
            bottom: 180,
            left: AppDimensions.lockScreenPadding,
            right: AppDimensions.lockScreenPadding,
            child: NotificationStack(),
          ),
          // 5. Shortcut Buttons
          const Positioned(
            bottom: 120,
            left: 0,
            right: 0,
            child: ShortcutButtons(),
          ),
          // 6. Swipe Hint
          const Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: SwipeHint(),
          ),
        ],
      ),
    );
  }
}
