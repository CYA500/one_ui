// lib/features/now_bar/domain/providers/now_bar_provider.dart
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/now_bar_item.dart';

part 'now_bar_provider.g.dart';

/// قائمة العناصر الثابتة لشريط Now Bar.
final List<NowBarItem> _nowBarItems = [
  const NowBarItem(
    icon: Icons.auto_awesome,
    title: 'Now brief',
    subtitle: "Get today's highlights",
  ),
  const NowBarItem(
    icon: Icons.music_note,
    title: 'Song name',
    subtitle: 'Artist name',
  ),
  const NowBarItem(
    icon: Icons.timer,
    title: '3:45',
    subtitle: 'Kitchen timer',
  ),
  const NowBarItem(
    icon: Icons.map,
    title: 'ETA 12 min',
    subtitle: 'Turn left in 200m',
  ),
  const NowBarItem(
    icon: Icons.fitness_center,
    title: '5.2 km',
    subtitle: 'Running • 28 min',
  ),
];

/// مزود يبدّل بين عناصر Now Bar كل 5 ثوانٍ.
@riverpod
Stream<NowBarItem> nowBarItem(NowBarItemRef ref) {
  int index = 0;
  return Stream.periodic(
    const Duration(seconds: 5),
    (count) {
      final item = _nowBarItems[index];
      index = (index + 1) % _nowBarItems.length;
      return item;
    },
  ).asBroadcastStream();
}
