// lib/features/lockscreen/presentation/widgets/wallpaper_layer.dart
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oneui85_simulator/app/theme/color_tokens.dart';
import 'package:oneui85_simulator/core/constants/dimensions.dart';
import 'package:sensors_plus/sensors_plus.dart';

class WallpaperLayer extends ConsumerStatefulWidget {
  const WallpaperLayer({
    super.key,
    required this.path,
    this.onImageLoaded,
  });

  final String path;
  final void Function(ImageProvider provider)? onImageLoaded;

  @override
  ConsumerState<WallpaperLayer> createState() => _WallpaperLayerState();
}

class _WallpaperLayerState extends ConsumerState<WallpaperLayer> {
  double _offsetX = 0;
  double _offsetY = 0;

  @override
  void initState() {
    super.initState();
    accelerometerEventStream().listen((event) {
      setState(() {
        _offsetX = (event.x * AppDimensions.clockParallaxMax).clamp(
          -AppDimensions.clockParallaxMax,
          AppDimensions.clockParallaxMax,
        );
        _offsetY = (event.y * AppDimensions.clockParallaxMax * 0.5).clamp(
          -AppDimensions.clockParallaxMax,
          AppDimensions.clockParallaxMax,
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = _imageProvider(widget.path);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.onImageLoaded?.call(provider);
    });

    return Transform.translate(
      offset: Offset(_offsetX, _offsetY),
      child: Container(
        decoration: BoxDecoration(
          color: ColorTokens.primarySurface,
          image: DecorationImage(
            image: provider,
            fit: BoxFit.cover,
            onError: (_, __) {},
          ),
        ),
        child: Image(
          image: provider,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF1A1A2E),
                  Color(0xFF16213E),
                  Color(0xFF0F3460),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  ImageProvider _imageProvider(String path) {
    if (path.startsWith('assets/')) {
      return AssetImage(path);
    }
    if (path.startsWith('/') || path.contains(':\\')) {
      return FileImage(File(path));
    }
    return AssetImage('assets/wallpapers/default_1.jpg');
  }
}
