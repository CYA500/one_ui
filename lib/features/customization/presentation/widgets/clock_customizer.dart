// lib/features/customization/presentation/widgets/clock_customizer.dart
import 'package:flutter/material.dart';
import 'clock_style_selector.dart';
import 'font_color_picker.dart';

/// تجميع لأنماط الساعة + منتقي الألوان والخط.
class ClockCustomizer extends StatelessWidget {
  const ClockCustomizer({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 12),
        ClockStyleSelector(),
        SizedBox(height: 16),
        FontColorPicker(),
      ],
    );
  }
}
