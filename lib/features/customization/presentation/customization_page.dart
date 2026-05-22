// lib/features/customization/presentation/customization_page.dart
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:oneui85_simulator/app/theme/color_tokens.dart';
import 'package:oneui85_simulator/core/constants/strings.dart';
import 'package:oneui85_simulator/features/customization/presentation/widgets/clock_customizer.dart';
import 'package:oneui85_simulator/features/customization/presentation/widgets/font_picker.dart';
import 'package:oneui85_simulator/features/customization/presentation/widgets/wallpaper_picker.dart';
import 'package:oneui85_simulator/features/customization/presentation/widgets/widget_manager.dart';
import 'package:oneui85_simulator/features/lockscreen/presentation/widgets/clock_widget.dart';

class CustomizationPage extends StatefulWidget {
  const CustomizationPage({super.key});

  @override
  State<CustomizationPage> createState() => _CustomizationPageState();
}

class _CustomizationPageState extends State<CustomizationPage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabs;

  @override
  void initState() {
    super.initState();
    _tabs = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabs.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          height: MediaQuery.sizeOf(context).height * 0.75,
          color: ColorTokens.primarySurface.withValues(alpha: 0.92),
          child: Column(
            children: [
              const SizedBox(height: 12),
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: ColorTokens.pillBorder,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  AppStrings.customizationTitle,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: ColorTokens.clockTextColor,
                      ),
                ),
              ),
              const SizedBox(
                height: 120,
                child: Center(child: ClockWidget()),
              ),
              TabBar(
                controller: _tabs,
                tabs: const [
                  Tab(text: AppStrings.tabFontAndColour),
                  Tab(text: AppStrings.tabStyle),
                ],
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabs,
                  children: const [
                    SingleChildScrollView(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        children: [
                          FontColorPicker(),
                          SizedBox(height: 16),
                          WallpaperPicker(),
                        ],
                      ),
                    ),
                    SingleChildScrollView(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        children: [
                          ClockCustomizer(),
                          SizedBox(height: 16),
                          WidgetManager(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
