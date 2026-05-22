// lib/features/lockscreen/presentation/lockscreen_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oneui85_simulator/app/theme/color_tokens.dart';
import 'package:oneui85_simulator/core/constants/dimensions.dart';
import 'package:oneui85_simulator/core/extensions/context_ext.dart';
import 'package:oneui85_simulator/features/customization/domain/providers/customization_provider.dart';
import 'package:oneui85_simulator/features/customization/presentation/customization_page.dart';
import 'package:oneui85_simulator/features/lockscreen/presentation/widgets/animated_weather_overlay.dart';
import 'package:oneui85_simulator/features/lockscreen/presentation/widgets/clock_widget.dart';
import 'package:oneui85_simulator/features/lockscreen/presentation/widgets/notification_stack.dart';
import 'package:oneui85_simulator/features/lockscreen/presentation/widgets/shortcut_buttons.dart';
import 'package:oneui85_simulator/features/lockscreen/presentation/widgets/swipe_hint.dart';
import 'package:oneui85_simulator/features/lockscreen/presentation/widgets/wallpaper_layer.dart';
import 'package:oneui85_simulator/shared/widgets/animated_gradient_bg.dart';
import 'package:palette_generator/palette_generator.dart';

class LockScreenPage extends ConsumerStatefulWidget {
  const LockScreenPage({
    super.key,
    required this.onUnlock,
  });

  final VoidCallback onUnlock;

  @override
  ConsumerState<LockScreenPage> createState() => _LockScreenPageState();
}

class _LockScreenPageState extends ConsumerState<LockScreenPage> {
  double _dragOffset = 0;

  Future<void> _analyzeWallpaper(ImageProvider provider) async {
    try {
      final palette = await PaletteGenerator.fromImageProvider(provider);
      final dominant = palette.dominantColor?.color ?? ColorTokens.primarySurface;
      final vibrant = palette.vibrantColor?.color ?? dominant;
      final centerX = (palette.dominantColor?.color != null)
          ? (palette.dominantColor!.color.red / 255 - 0.5) * 40
          : 0.0;
      ref.read(customizationProvider.notifier).updatePalette(
            dominant: vibrant,
            offset: Offset(centerX.clamp(-40.0, 40.0), 0),
          );
    } catch (_) {}
  }

  void _onVerticalDragUpdate(DragUpdateDetails details) {
    setState(() => _dragOffset += details.delta.dy);
  }

  void _onVerticalDragEnd(DragEndDetails details) {
    if (_dragOffset < -AppDimensions.unlockSwipeThreshold) {
      widget.onUnlock();
    }
    setState(() => _dragOffset = 0);
  }

  @override
  Widget build(BuildContext context) {
    final customization = ref.watch(customizationProvider);
    final wallpaper = customization.wallpaperPath;
    final gradientColors = [
      customization.dominantColor ?? ColorTokens.primarySurface,
      ColorTokens.primarySurface,
    ];

    return GestureDetector(
      onVerticalDragUpdate: _onVerticalDragUpdate,
      onVerticalDragEnd: _onVerticalDragEnd,
      onLongPress: () => showCustomizationSheet(context),
      child: Transform.translate(
        offset: Offset(0, _dragOffset * 0.3),
        child: Stack(
          fit: StackFit.expand,
          children: [
            WallpaperLayer(
              path: wallpaper,
              onImageLoaded: (provider) => _analyzeWallpaper(provider),
            ),
            AnimatedGradientBg(colors: gradientColors),
            AnimatedWeatherOverlay(
              child: const SizedBox.expand(),
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    const Spacer(flex: 2),
                    const ClockWidget(),
                    const SizedBox(height: 24),
                    const NotificationStack(),
                    const Spacer(),
                    const ShortcutButtons(),
                    const SizedBox(height: 24),
                    const SwipeHint(),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void showCustomizationSheet(BuildContext context) {
  showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => const CustomizationPage(),
  );
}
