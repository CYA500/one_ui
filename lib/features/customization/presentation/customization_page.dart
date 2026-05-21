// lib/features/customization/presentation/customization_page.dart
import 'package:flutter/material.dart';
import '../../../../app/theme/color_tokens.dart';
import '../../../../app/theme/typography.dart';
import 'widgets/clock_customizer.dart';
import 'widgets/wallpaper_picker.dart';
import 'widgets/widget_manager.dart';

/// صفحة التخصيص الكاملة (تظهر كـ BottomSheet).
class CustomizationPage extends StatelessWidget {
  const CustomizationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      decoration: BoxDecoration(
        color: ColorTokens.primarySurfaceLight,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
        border: Border.all(color: ColorTokens.borderGlass, width: 0.5),
      ),
      child: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            // مقبض السحب
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white24,
                borderRadius: BorderRadius.circular(2),
              ),
            ),

            // TabBar
            const TabBar(
              labelColor: Colors.white,
              unselectedLabelColor: Colors.white54,
              indicatorColor: ColorTokens.accentBlue,
              labelStyle: AppTypography.nowBarTitle,
              tabs: [
                Tab(text: 'Font and colour'),
                Tab(text: 'Style'),
              ],
            ),

            // محتوى التبويبات
            Expanded(
              child: TabBarView(
                children: [
                  // تبويب "Font and colour": منتقي الخط واللون + ورق الجدران
                  SingleChildScrollView(
                    padding: const EdgeInsets.only(bottom: 24),
                    child: Column(
                      children: [
                        const FontColorPicker(),
                        const Divider(color: ColorTokens.borderGlass),
                        const WallpaperPicker(),
                        const Divider(color: ColorTokens.borderGlass),
                        const Padding(
                          padding: EdgeInsets.all(12),
                          child: Text('Lock screen widgets',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                        ),
                        const WidgetManager(),
                      ],
                    ),
                  ),

                  // تبويب "Style": أنماط الساعة فقط
                  SingleChildScrollView(
                    child: const ClockCustomizer(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
