// lib/features/home_screen/presentation/home_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../app/theme/color_tokens.dart';
import '../../now_bar/presentation/now_bar_widget.dart';
import 'widgets/app_grid.dart';
import 'widgets/dock_bar.dart';

/// الشاشة الرئيسية: PageView، مؤشر النقاط، Dock، و Now Bar.
class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorTokens.primarySurface,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // خلفية ثابتة
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/wallpapers/default_1.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // المحتوى الرئيسي
          SafeArea(
            child: Column(
              children: [
                // منطقة عرض الصفحات (التطبيقات)
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    onPageChanged: (page) {
                      setState(() => _currentPage = page);
                    },
                    itemCount: 2,
                    itemBuilder: (context, index) => const AppGrid(),
                  ),
                ),

                // مؤشر النقاط
                const SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(2, (index) {
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      margin: const EdgeInsets.symmetric(horizontal: 3),
                      width: _currentPage == index ? 8 : 6,
                      height: _currentPage == index ? 8 : 6,
                      decoration: BoxDecoration(
                        color: _currentPage == index
                            ? Colors.white
                            : Colors.white38,
                        shape: BoxShape.circle,
                      ),
                    );
                  }),
                ),

                // شريط الإرساء (Dock)
                const DockBar(),

                const SizedBox(height: 8),

                // Now Bar فوق الـ Dock
                const NowBarWidget(),

                const SizedBox(height: 12),
              ],
            ),
          ),
        ],
      ),
    );
  }
}// lib/features/home_screen/presentation/home_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../app/theme/color_tokens.dart';
import '../../now_bar/presentation/now_bar_widget.dart';
import 'widgets/app_grid.dart';
import 'widgets/dock_bar.dart';

/// الشاشة الرئيسية: PageView، مؤشر النقاط، Dock، و Now Bar.
class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorTokens.primarySurface,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // خلفية ثابتة (يمكن استخدام صورة)
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/wallpapers/default_1.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // المحتوى الرئيسي
          SafeArea(
            child: Column(
              children: [
                // منطقة عرض الصفحات (التطبيقات)
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    onPageChanged: (page) {
                      setState(() => _currentPage = page);
                    },
                    itemCount: 2, // صفحتين للتطبيقات
                    itemBuilder: (context, index) => const AppGrid(),
                  ),
                ),

                // مؤشر النقاط
                const SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(2, (index) {
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      margin: const EdgeInsets.symmetric(horizontal: 3),
                      width: _currentPage == index ? 8 : 6,
                      height: _currentPage == index ? 8 : 6,
                      decoration: BoxDecoration(
                        color: _currentPage == index
                            ? Colors.white
                            : Colors.white38,
                        shape: BoxShape.circle,
                      ),
                    );
                  }),
                ),

                // شريط الإرساء (Dock)
                const DockBar(),

                // Now Bar فوق الـ Dock (بمسافة 8px)
                const Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: NowBarWidget(),
                ).paddingOnly(bottom: 8),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
