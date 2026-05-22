// lib/features/customization/presentation/widgets/wallpaper_picker.dart
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:oneui85_simulator/app/theme/color_tokens.dart';
import 'package:oneui85_simulator/core/constants/strings.dart';
import 'package:oneui85_simulator/features/customization/domain/providers/customization_provider.dart';
import 'package:palette_generator/palette_generator.dart';

class WallpaperPicker extends ConsumerWidget {
  const WallpaperPicker({super.key});

  static const _builtIn = [
    'assets/wallpapers/default_1.jpg',
    'assets/wallpapers/default_2.jpg',
    'assets/wallpapers/default_3.jpg',
  ];

  Future<void> _pickFromDevice(WidgetRef ref) async {
    final file = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (file == null) return;
    Color? dominant;
    try {
      final palette =
          await PaletteGenerator.fromImageProvider(FileImage(File(file.path)));
      dominant = palette.vibrantColor?.color;
    } catch (_) {}
    ref.read(customizationProvider.notifier).setWallpaper(
          file.path,
          dominant: dominant,
        );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = ref.watch(customizationProvider).wallpaperPath;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.wallpaperSection,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: ColorTokens.clockTextColor,
              ),
        ),
        const SizedBox(height: 12),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          itemCount: _builtIn.length + 1,
          itemBuilder: (context, index) {
            if (index == _builtIn.length) {
              return GestureDetector(
                onTap: () => _pickFromDevice(ref),
                child: Container(
                  decoration: BoxDecoration(
                    color: ColorTokens.glassBlue,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.add, color: Colors.white),
                ),
              );
            }
            final path = _builtIn[index];
            final isSelected = path == selected;
            return GestureDetector(
              onTap: () =>
                  ref.read(customizationProvider.notifier).setWallpaper(path),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isSelected
                        ? ColorTokens.selectedBorder
                        : Colors.transparent,
                    width: 2,
                  ),
                  gradient: LinearGradient(
                    colors: [
                      ColorTokens.primarySurface,
                      ColorTokens.accentBlue.withValues(alpha: 0.5),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
