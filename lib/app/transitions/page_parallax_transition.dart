// lib/app/transitions/page_parallax_transition.dart
import 'package:flutter/material.dart';
import 'package:oneui85_simulator/core/constants/dimensions.dart';

class PageParallaxBackground extends StatelessWidget {
  const PageParallaxBackground({
    super.key,
    required this.pageOffset,
    required this.child,
  });

  final double pageOffset;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(-pageOffset * AppDimensions.pageParallaxFactor * 100, 0),
      child: child,
    );
  }
}
