// lib/features/customization/presentation/widgets/wallpaper_picker.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:palette_generator/palette_generator.dart';
import '../../../../../app/theme/color_tokens.dart';
import '../../../../../core/constants/durations.dart';
import '../../../domain/providers/customization_provider.dart';

/// منتقي الخلفيات (مدمجة + من المعرض).
class WallpaperPicker extends ConsumerWidget {
  const WallpaperPicker({super.key});

  static const List<String> _builtInWallpapers = [
    'assets/wallpapers/default_1.jpg',
    'assets/wallpapers/default_2.jpg',
    'assets/wallpapers/default_3.jpg',
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentWallpaper = ref.watch(customizationProvider).wallpaperPath;
    final notifier = ref.read(customizationProvider.notifier);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(12),
          child: Text('Wallpaper',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        ),
        SizedBox(
          height: 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            itemCount: _builtInWallpapers.length + 1, // +1 for "Add"
            itemBuilder: (context, index) {
              if (index < _builtInWallpapers.length) {
                final path = _builtInWallpapers[index];
                final isSelected = currentWallpaper == path;
                return GestureDetector(
                  onTap: () async {
                    notifier.setWallpaper(path);
                    _extractPaletteAndAdapt(path, context, ref);
                  },
                  child: AnimatedContainer(
                    duration: AppDurations.short,
                    margin: const EdgeInsets.only(right: 10),
                    width: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: isSelected
                            ? ColorTokens.borderActive
                            : Colors.transparent,
                        width: 2,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(14),
                      child: Image.asset(path, fit: BoxFit.cover),
                    ),
                  ),
                );
              } else {
                // زر إضافة من المعرض
                return GestureDetector(
                  onTap: () => _pickFromGallery(notifier, ref),
                  child: Container(
                    margin: const EdgeInsets.only(right: 10),
                    width: 80,
                    decoration: BoxDecoration(
                      color: ColorTokens.glassWhite,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: ColorTokens.borderGlass),
                    ),
                    child: const Icon(Icons.add_photo_alternate_outlined,
                        color: Colors.white70, size: 28),
                  ),
                );
              }
            },
          ),
        ),
      ],
    );
  }

  Future<void> _pickFromGallery(
      CustomizationNotifier notifier, WidgetRef ref) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      notifier.setWallpaper(pickedFile.path);
      _extractPaletteAndAdapt(pickedFile.path, ref.context, ref);
    }
  }

  Future<void> _extractPaletteAndAdapt(
      String path, BuildContext context, WidgetRef ref) async {
    try {
      final generator = await PaletteGenerator.fromImageProvider(
        AssetImage(path), // if asset, else file: FileImage(File(path))
      );
      final dominantColor =
          generator.dominantColor?.color ?? ColorTokens.clockTextColor;
      ref.read(customizationProvider.notifier).setClockColor(dominantColor);
      // يمكن تخزين ألوان أخرى إذا أردت
    } catch (_) {}
  }
}
