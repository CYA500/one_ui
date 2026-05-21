// lib/features/now_bar/domain/models/now_bar_item.dart
import 'package:flutter/material.dart';

/// عناصر شريط Now Bar الديناميكية.
class NowBarItem {
  final IconData icon;
  final String title;
  final String subtitle;

  const NowBarItem({
    required this.icon,
    required this.title,
    required this.subtitle,
  });
}
