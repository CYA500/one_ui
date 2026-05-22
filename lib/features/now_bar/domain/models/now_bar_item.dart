// lib/features/now_bar/domain/models/now_bar_item.dart
import 'package:flutter/material.dart';

enum NowBarItemType { nowBrief, music, timer, navigation, workout }

class NowBarItem {
  const NowBarItem({
    required this.type,
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  final NowBarItemType type;
  final IconData icon;
  final String title;
  final String subtitle;
}
