// lib/shared/widgets/blur_overlay.dart
import 'dart:ui';

import 'package:flutter/material.dart';

class BlurOverlay extends StatelessWidget {
  const BlurOverlay({
    super.key,
    required this.sigma,
    this.child,
  });

  final double sigma;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: sigma, sigmaY: sigma),
      child: child ?? const SizedBox.expand(),
    );
  }
}
