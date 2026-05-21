// lib/features/customization/presentation/widgets/font_color_picker.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../app/theme/color_tokens.dart';
import '../../../../../app/theme/typography.dart';
import '../../../domain/providers/customization_provider.dart';

/// منتقي لون الساعة والخط مع معاينة فورية.
class FontColorPicker extends ConsumerStatefulWidget {
  const FontColorPicker({super.key});

  @override
  ConsumerState<FontColorPicker> createState() => _FontColorPickerState();
}

class _FontColorPickerState extends ConsumerState<FontColorPicker> {
  // قائمة الألوان الجاهزة
  static const List<Color> _presetColors = [
    Colors.white,
    Color(0xFFFFD700), // ذهبي
    Color(0xFF407BFF), // أزرق
    Color(0xFFFF4D6D), // وردي
    Color(0xFF80ED99), // أخضر
    Color(0xFFFFB703), // برتقالي
    Color(0xFF9D4EDD), // بنفسجي
    Color(0xFFFFE5EC), // بيج فاتح
  ];

  @override
  Widget build(BuildContext context) {
    final customization = ref.watch(customizationProvider);
    final notifier = ref.read(customizationProvider.notifier);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // معاينة سريعة
        Padding(
          padding: const EdgeInsets.all(12),
          child: Text(
            '12:34',
            style: AppTypography.clockDisplay.copyWith(
              color: customization.clockColor,
              fontFamily: customization.fontFamily,
              fontSize: 40,
            ),
          ),
        ),

        // اختيار اللون
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Text('Clock Color',
              style: TextStyle(color: Colors.white70, fontSize: 13)),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: _presetColors.map((color) {
            return GestureDetector(
              onTap: () => notifier.setClockColor(color),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: customization.clockColor == color
                        ? ColorTokens.borderActive
                        : Colors.transparent,
                    width: 2.5,
                  ),
                ),
              ),
            );
          }).toList(),
        ),

        const SizedBox(height: 20),

        // اختيار الخط
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Text('Font',
              style: TextStyle(color: Colors.white70, fontSize: 13)),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: ['SamsungOne', 'SamsungSharpSans'].map((font) {
            return ChoiceChip(
              label: Text(font,
                  style: TextStyle(
                      fontFamily: font,
                      color: customization.fontFamily == font
                          ? Colors.white
                          : Colors.white70)),
              selected: customization.fontFamily == font,
              selectedColor: ColorTokens.accentBlue.withOpacity(0.4),
              backgroundColor: ColorTokens.glassWhite,
              onSelected: (_) => notifier.setFontFamily(font),
              side: BorderSide(
                  color: customization.fontFamily == font
                      ? ColorTokens.borderActive
                      : ColorTokens.borderGlass),
            );
          }).toList(),
        ),
      ],
    );
  }
}
