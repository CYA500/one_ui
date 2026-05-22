// lib/features/home_screen/presentation/home_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oneui85_simulator/app/theme/color_tokens.dart';
import 'package:oneui85_simulator/app/transitions/page_parallax_transition.dart';
import 'package:oneui85_simulator/core/constants/dimensions.dart';
import 'package:oneui85_simulator/features/customization/domain/providers/customization_provider.dart';
import 'package:oneui85_simulator/features/home_screen/domain/providers/home_provider.dart';
import 'package:oneui85_simulator/features/home_screen/presentation/widgets/app_grid.dart';
import 'package:oneui85_simulator/features/home_screen/presentation/widgets/dock_bar.dart';
import 'package:oneui85_simulator/features/lockscreen/presentation/lockscreen_page.dart';
import 'package:oneui85_simulator/features/now_bar/presentation/now_bar_widget.dart';
import 'package:oneui85_simulator/shared/widgets/animated_gradient_bg.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key, required this.onLock});

  final Future<void> Function() onLock;

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  late final PageController _pageController;
  double _pageOffset = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _pageController.addListener(_onPageScroll);
  }

  void _onPageScroll() {
    setState(() => _pageOffset = _pageController.page ?? 0);
  }

  @override
  void dispose() {
    _pageController.removeListener(_onPageScroll);
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final customization = ref.watch(customizationProvider);
    const pageCount = 2;

    return GestureDetector(
      onVerticalDragEnd: (details) {
        if (details.primaryVelocity != null && details.primaryVelocity! < -500) {
          widget.onLock();
        }
      },
      onLongPress: () => showCustomizationSheet(context),
      child: Stack(
        fit: StackFit.expand,
        children: [
          PageParallaxBackground(
            pageOffset: _pageOffset,
            child: AnimatedGradientBg(
              colors: [
                customization.dominantColor ?? ColorTokens.primarySurface,
                ColorTokens.primarySurface,
              ],
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: pageCount,
                    onPageChanged: (i) =>
                        ref.read(homeProvider.notifier).setPage(i),
                    itemBuilder: (_, index) => AppGrid(pageIndex: index),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(pageCount, (i) {
                    final active = ref.watch(homeProvider).currentPage == i;
                    return Container(
                      width: 8,
                      height: 8,
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: active
                            ? ColorTokens.accentBlue
                            : ColorTokens.pillBorder,
                      ),
                    );
                  }),
                ),
                if (customization.nowBarEnabled) ...[
                  const SizedBox(height: AppDimensions.nowBarDockGap),
                  const NowBarWidget(),
                ],
                const SizedBox(height: AppDimensions.nowBarDockGap),
                const DockBar(),
                const SizedBox(height: 8),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
