// lib/features/now_bar/domain/providers/now_bar_provider.dart
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oneui85_simulator/core/constants/durations.dart';
import 'package:oneui85_simulator/core/constants/strings.dart';
import 'package:oneui85_simulator/features/now_bar/domain/models/now_bar_item.dart';

final nowBarItemsProvider = Provider<List<NowBarItem>>((ref) {
  return [
    const NowBarItem(
      type: NowBarItemType.nowBrief,
      icon: Icons.auto_awesome,
      title: AppStrings.nowBriefTitle,
      subtitle: AppStrings.nowBriefSub,
    ),
    const NowBarItem(
      type: NowBarItemType.music,
      icon: Icons.music_note,
      title: AppStrings.musicSong,
      subtitle: AppStrings.musicArtist,
    ),
    const NowBarItem(
      type: NowBarItemType.timer,
      icon: Icons.timer,
      title: AppStrings.timerValue,
      subtitle: AppStrings.kitchenTimer,
    ),
    const NowBarItem(
      type: NowBarItemType.navigation,
      icon: Icons.map,
      title: AppStrings.navTitle,
      subtitle: AppStrings.navSub,
    ),
    const NowBarItem(
      type: NowBarItemType.workout,
      icon: Icons.fitness_center,
      title: AppStrings.workoutTitle,
      subtitle: AppStrings.workoutSub,
    ),
  ];
});

class NowBarIndexNotifier extends StateNotifier<int> {
  NowBarIndexNotifier(this._items) : super(0) {
    _timer = Timer.periodic(AppDurations.nowBarRotation, (_) {
      state = (state + 1) % _items.length;
    });
  }

  final List<NowBarItem> _items;
  Timer? _timer;

  NowBarItem get current => _items[state];

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}

final nowBarIndexProvider =
    StateNotifierProvider<NowBarIndexNotifier, int>((ref) {
  final items = ref.watch(nowBarItemsProvider);
  return NowBarIndexNotifier(items);
});

final currentNowBarItemProvider = Provider<NowBarItem>((ref) {
  final items = ref.watch(nowBarItemsProvider);
  final index = ref.watch(nowBarIndexProvider);
  return items[index];
});
