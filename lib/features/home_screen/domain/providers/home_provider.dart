// lib/features/home_screen/domain/providers/home_provider.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// بيانات أيقونة تطبيق واحدة.
class AppIconData {
  final String id;
  final String label;
  final IconData icon;
  const AppIconData(this.id, this.label, this.icon);
}

/// حالة الشاشة الرئيسية.
class HomeState {
  final List<AppIconData> apps;
  final bool editMode;
  const HomeState({
    required this.apps,
    this.editMode = false,
  });

  HomeState copyWith({List<AppIconData>? apps, bool? editMode}) {
    return HomeState(
      apps: apps ?? this.apps,
      editMode: editMode ?? this.editMode,
    );
  }
}

/// مزود لإدارة تطبيقات الشاشة الرئيسية.
class HomeNotifier extends StateNotifier<HomeState> {
  HomeNotifier()
      : super(HomeState(apps: _defaultApps()));

  static List<AppIconData> _defaultApps() {
    return [
      const AppIconData('1', 'Phone', Icons.phone),
      const AppIconData('2', 'Messages', Icons.message),
      const AppIconData('3', 'Camera', Icons.camera_alt),
      const AppIconData('4', 'Gallery', Icons.photo_library),
      const AppIconData('5', 'Settings', Icons.settings),
      const AppIconData('6', 'Clock', Icons.access_time),
      const AppIconData('7', 'Calendar', Icons.calendar_today),
      const AppIconData('8', 'Weather', Icons.cloud),
      const AppIconData('9', 'Maps', Icons.map),
      const AppIconData('10', 'Play Store', Icons.shop),
      const AppIconData('11', 'YouTube', Icons.play_circle_fill),
      const AppIconData('12', 'Chrome', Icons.language),
      const AppIconData('13', 'Contacts', Icons.contacts),
      const AppIconData('14', 'Email', Icons.email),
      const AppIconData('15', 'Music', Icons.music_note),
      const AppIconData('16', 'Files', Icons.folder),
      const AppIconData('17', 'Calculator', Icons.calculate),
      const AppIconData('18', 'Notes', Icons.note),
      const AppIconData('19', 'Health', Icons.favorite),
      const AppIconData('20', 'Wallet', Icons.account_balance_wallet),
    ];
  }

  void toggleEditMode() {
    state = state.copyWith(editMode: !state.editMode);
  }

  void removeApp(String id) {
    state = state.copyWith(apps: state.apps.where((a) => a.id != id).toList());
  }

  void reorderApps(int oldIndex, int newIndex) {
    if (newIndex > oldIndex) newIndex--;
    final updated = List<AppIconData>.from(state.apps);
    final item = updated.removeAt(oldIndex);
    updated.insert(newIndex, item);
    state = state.copyWith(apps: updated);
  }
}

final homeProvider = StateNotifierProvider<HomeNotifier, HomeState>(
  (ref) => HomeNotifier(),
);
