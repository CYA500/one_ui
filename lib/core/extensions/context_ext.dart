// lib/core/extensions/context_ext.dart
import 'package:flutter/material.dart';

extension ContextExt on BuildContext {
  double get screenWidth => MediaQuery.sizeOf(this).width;
  double get screenHeight => MediaQuery.sizeOf(this).height;
  EdgeInsets get safePadding => MediaQuery.paddingOf(this);
  ThemeData get appTheme => Theme.of(this);
}
