// lib/core/transitions/page_swipe_parallax.dart
import 'package:flutter/material.dart';

/// ويدجت يطبق تأثير البارالاكس على الخلفية (أبطأ من المحتوى)
/// أثناء التمرير الأفقي للصفحات.
class PageSwipeParallax extends StatelessWidget {
  final Widget background;
  final PageController controller;
  final double parallaxFactor; // عادة أقل من 1 لبطء الخلفية
  final int pageCount;
  final Widget Function(int index) pageBuilder;

  const PageSwipeParallax({
    super.key,
    required this.background,
    required this.controller,
    this.parallaxFactor = 0.3,
    required this.pageCount,
    required this.pageBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // خلفية متحركة ببطء
        AnimatedBuilder(
          animation: controller,
          builder: (context, child) {
            final page = controller.hasClients ? controller.page ?? 0 : 0;
            return FractionalTranslation(
              translation: Offset(-page * parallaxFactor, 0),
              child: child,
            );
          },
          child: background,
        ),
        // المحتوى الطبيعي
        PageView.builder(
          controller: controller,
          itemCount: pageCount,
          itemBuilder: (context, index) => pageBuilder(index),
        ),
      ],
    );
  }
}
