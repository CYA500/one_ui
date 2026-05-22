// lib/features/home_screen/domain/providers/home_provider.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppInfo {
  const AppInfo({
    required this.id,
    required this.name,
    required this.icon,
    required this.color,
  });

  final String id;
  final String name;
  final IconData icon;
  final Color color;
}

class HomeState {
  const HomeState({
    required this.apps,
    this.currentPage = 0,
  });

  final List<AppInfo> apps;
  final int currentPage;

  HomeState copyWith({List<AppInfo>? apps, int? currentPage}) {
    return HomeState(
      apps: apps ?? this.apps,
      currentPage: currentPage ?? this.currentPage,
    );
  }
}

List<AppInfo> _defaultApps() => const [
      AppInfo(id: '1', name: 'Phone', icon: Icons.phone, color: Color(0xFF4CAF50)),
      AppInfo(id: '2', name: 'Messages', icon: Icons.message, color: Color(0xFF2196F3)),
      AppInfo(id: '3', name: 'Internet', icon: Icons.language, color: Color(0xFF03A9F4)),
      AppInfo(id: '4', name: 'Camera', icon: Icons.camera_alt, color: Color(0xFF9C27B0)),
      AppInfo(id: '5', name: 'Gallery', icon: Icons.photo, color: Color(0xFFE91E63)),
      AppInfo(id: '6', name: 'Settings', icon: Icons.settings, color: Color(0xFF607D8B)),
      AppInfo(id: '7', name: 'Contacts', icon: Icons.contacts, color: Color(0xFF795548)),
      AppInfo(id: '8', name: 'Calendar', icon: Icons.calendar_month, color: Color(0xFFFF5722)),
      AppInfo(id: '9', name: 'Clock', icon: Icons.access_time, color: Color(0xFF009688)),
      AppInfo(id: '10', name: 'Notes', icon: Icons.note, color: Color(0xFFFFC107)),
      AppInfo(id: '11', name: 'Store', icon: Icons.store, color: Color(0xFF3F51B5)),
      AppInfo(id: '12', name: 'Health', icon: Icons.favorite, color: Color(0xFFF44336)),
      AppInfo(id: '13', name: 'Files', icon: Icons.folder, color: Color(0xFF8BC34A)),
      AppInfo(id: '14', name: 'Music', icon: Icons.music_note, color: Color(0xFF00BCD4)),
      AppInfo(id: '15', name: 'Video', icon: Icons.videocam, color: Color(0xFF673AB7)),
      AppInfo(id: '16', name: 'Maps', icon: Icons.map, color: Color(0xFF4DB6AC)),
      AppInfo(id: '17', name: 'Weather', icon: Icons.wb_sunny, color: Color(0xFFFF9800)),
      AppInfo(id: '18', name: 'Email', icon: Icons.email, color: Color(0xFF5C6BC0)),
      AppInfo(id: '19', name: 'Calculator', icon: Icons.calculate, color: Color(0xFF78909C)),
      AppInfo(id: '20', name: 'One UI', icon: Icons.android, color: Color(0xFF407BFF)),
    ];

class HomeNotifier extends StateNotifier<HomeState> {
  HomeNotifier() : super(HomeState(apps: _defaultApps()));

  void setPage(int page) {
    state = state.copyWith(currentPage: page);
  }

  void reorderApps(int oldIndex, int newIndex) {
    final apps = List<AppInfo>.from(state.apps);
    if (newIndex > oldIndex) newIndex -= 1;
    final item = apps.removeAt(oldIndex);
    apps.insert(newIndex, item);
    state = state.copyWith(apps: apps);
  }
}

final homeProvider = StateNotifierProvider<HomeNotifier, HomeState>(
  (ref) => HomeNotifier(),
);

final dockAppsProvider = Provider<List<AppInfo>>((ref) {
  final apps = ref.watch(homeProvider).apps;
  return apps.take(4).toList();
});
