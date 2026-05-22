// lib/features/customization/domain/providers/customization_provider.dart
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oneui85_simulator/app/theme/color_tokens.dart';
import 'package:oneui85_simulator/features/lockscreen/domain/models/clock_style.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomizationState {
  const CustomizationState({
    this.clockStyle = ClockStyle.digitalThin,
    this.clockColor = ColorTokens.clockTextColor,
    this.fontFamily = 'SamsungOne',
    this.showWeather = true,
    this.showDate = true,
    this.wallpaperPath = 'assets/wallpapers/default_1.jpg',
    this.activeWidgets = const [
      'Steps',
      'Battery',
      'Calendar',
    ],
    this.nowBarEnabled = true,
    this.clockOffset = Offset.zero,
    this.dominantColor,
  });

  final ClockStyle clockStyle;
  final Color clockColor;
  final String fontFamily;
  final bool showWeather;
  final bool showDate;
  final String wallpaperPath;
  final List<String> activeWidgets;
  final bool nowBarEnabled;
  final Offset clockOffset;
  final Color? dominantColor;

  CustomizationState copyWith({
    ClockStyle? clockStyle,
    Color? clockColor,
    String? fontFamily,
    bool? showWeather,
    bool? showDate,
    String? wallpaperPath,
    List<String>? activeWidgets,
    bool? nowBarEnabled,
    Offset? clockOffset,
    Color? dominantColor,
  }) {
    return CustomizationState(
      clockStyle: clockStyle ?? this.clockStyle,
      clockColor: clockColor ?? this.clockColor,
      fontFamily: fontFamily ?? this.fontFamily,
      showWeather: showWeather ?? this.showWeather,
      showDate: showDate ?? this.showDate,
      wallpaperPath: wallpaperPath ?? this.wallpaperPath,
      activeWidgets: activeWidgets ?? this.activeWidgets,
      nowBarEnabled: nowBarEnabled ?? this.nowBarEnabled,
      clockOffset: clockOffset ?? this.clockOffset,
      dominantColor: dominantColor ?? this.dominantColor,
    );
  }

  Map<String, dynamic> toJson() => {
        'clockStyle': clockStyle.index,
        'clockColor': clockColor.toARGB32(),
        'fontFamily': fontFamily,
        'showWeather': showWeather,
        'showDate': showDate,
        'wallpaperPath': wallpaperPath,
        'activeWidgets': activeWidgets,
        'nowBarEnabled': nowBarEnabled,
      };

  static CustomizationState fromJson(Map<String, dynamic> json) {
    return CustomizationState(
      clockStyle: ClockStyle.values[json['clockStyle'] as int? ?? 0],
      clockColor: Color(json['clockColor'] as int? ?? 0xFFFFFFFF),
      fontFamily: json['fontFamily'] as String? ?? 'SamsungOne',
      showWeather: json['showWeather'] as bool? ?? true,
      showDate: json['showDate'] as bool? ?? true,
      wallpaperPath:
          json['wallpaperPath'] as String? ?? 'assets/wallpapers/default_1.jpg',
      activeWidgets: (json['activeWidgets'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          const ['Steps', 'Battery', 'Calendar'],
      nowBarEnabled: json['nowBarEnabled'] as bool? ?? true,
    );
  }
}

class CustomizationNotifier extends StateNotifier<CustomizationState> {
  CustomizationNotifier() : super(const CustomizationState()) {
    _load();
  }

  static const _prefsKey = 'customization_state';

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_prefsKey);
    if (raw != null) {
      state = CustomizationState.fromJson(
        jsonDecode(raw) as Map<String, dynamic>,
      );
    }
  }

  Future<void> _save() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_prefsKey, jsonEncode(state.toJson()));
  }

  void setClockStyle(ClockStyle style) {
    state = state.copyWith(clockStyle: style);
    _save();
  }

  void setClockColor(Color color) {
    state = state.copyWith(clockColor: color);
    _save();
  }

  void setFontFamily(String family) {
    state = state.copyWith(fontFamily: family);
    _save();
  }

  void toggleWeather() {
    state = state.copyWith(showWeather: !state.showWeather);
    _save();
  }

  void toggleDate() {
    state = state.copyWith(showDate: !state.showDate);
    _save();
  }

  void setWallpaper(String path, {Color? dominant, Offset? offset}) {
    state = state.copyWith(
      wallpaperPath: path,
      dominantColor: dominant,
      clockOffset: offset ?? state.clockOffset,
    );
    _save();
  }

  void setClockOffset(Offset offset) {
    state = state.copyWith(clockOffset: offset);
    _save();
  }

  void updatePalette({Color? dominant, Offset? offset}) {
    state = state.copyWith(
      dominantColor: dominant ?? state.dominantColor,
      clockOffset: offset ?? state.clockOffset,
    );
    _save();
  }

  void setActiveWidgets(List<String> widgets) {
    state = state.copyWith(activeWidgets: widgets);
    _save();
  }

  void toggleWidget(String name, bool visible) {
    final list = List<String>.from(state.activeWidgets);
    if (visible && !list.contains(name)) list.add(name);
    if (!visible) list.remove(name);
    state = state.copyWith(activeWidgets: list);
    _save();
  }

  void reorderWidgets(int oldIndex, int newIndex) {
    final list = List<String>.from(state.activeWidgets);
    if (newIndex > oldIndex) newIndex -= 1;
    final item = list.removeAt(oldIndex);
    list.insert(newIndex, item);
    state = state.copyWith(activeWidgets: list);
    _save();
  }
}

final customizationProvider =
    StateNotifierProvider<CustomizationNotifier, CustomizationState>(
  (ref) => CustomizationNotifier(),
);
