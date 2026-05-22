// lib/features/customization/presentation/widgets/font_picker.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oneui85_simulator/app/theme/color_tokens.dart';
import 'package:oneui85_simulator/features/customization/domain/providers/customization_provider.dart';

class FontColorPicker extends ConsumerWidget {
  const FontColorPicker({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = ref.watch(customizationProvider).clockColor;
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: [
        ...ColorTokens.clockColorPresets.map((color) {
          final isSelected = color.toARGB32() == selected.toARGB32();
          return GestureDetector(
            onTap: () =>
                ref.read(customizationProvider.notifier).setClockColor(color),
            child: Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: color,
                border: Border.all(
                  color: isSelected
                      ? ColorTokens.selectedBorder
                      : ColorTokens.pillBorder,
                  width: isSelected ? 3 : 1,
                ),
              ),
            ),
          );
        }),
        GestureDetector(
          onTap: () async {
            // ignore: use_build_context_synchronously
            final picked = await showDialog<Color>(
              context: context,
              builder: (ctx) => AlertDialog(
                title: const Text('Pick color'),
                content: BlockPicker(
                  onColorChanged: (c) => Navigator.pop(ctx, c),
                ),
              ),
            );
            if (picked != null) {
              ref.read(customizationProvider.notifier).setClockColor(picked);
            }
          },
          child: Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: ColorTokens.pillBorder),
            ),
            child: const Icon(Icons.color_lens, size: 18, color: Colors.white),
          ),
        ),
      ],
    );
  }
}

/// Simple color grid picker.
class BlockPicker extends StatelessWidget {
  const BlockPicker({super.key, required this.onColorChanged});

  final ValueChanged<Color> onColorChanged;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      children: ColorTokens.clockColorPresets
          .map(
            (c) => GestureDetector(
              onTap: () => onColorChanged(c),
              child: Container(width: 40, height: 40, color: c),
            ),
          )
          .toList(),
    );
  }
}
