// lib/features/customization/domain/providers/customization_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../lockscreen/domain/models/clock_style.dart';

/// حالة التخصيص الكاملة.
class CustomizationState {
  final ClockStyle clockStyle;
  final Color clockColor;
  final String fontFamily;
  final bool showWeather;
  final bool showDate;
  final String? wallpaperPath;
  final List<String> activeWidgets;
  final bool nowBarEnabled;

  const CustomizationState({
    this.clockStyle = ClockStyle.digitalThin,
    this.clockColor = Colors.white,
    this.fontFamily = 'SamsungOne',
    this.showWeather = true,
    this.showDate = true,
    this.wallpaperPath,
    this.activeWidgets = const [],
    this.nowBarEnabled = true,
  });

  CustomizationState copyWith({
    ClockStyle? clockStyle,
    Color? clockColor,
    String? fontFamily,
    bool? showWeather,
    bool? showDate,
    String? wallpaperPath,
    List<String>? activeWidgets,
    bool? nowBarEnabled,
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
    );
  }
}

/// مزود تخصيصات شاشة القفل.
class CustomizationNotifier extends StateNotifier<CustomizationState> {
  CustomizationNotifier() : super(const CustomizationState());

  void setClockStyle(ClockStyle style) {
    state = state.copyWith(clockStyle: style);
  }

  void setClockColor(Color color) {
    state = state.copyWith(clockColor: color);
  }

  void setFontFamily(String font) {
    state = state.copyWith(fontFamily: font);
  }

  void toggleWeather(bool show) {
    state = state.copyWith(showWeather: show);
  }

  void toggleDate(bool show) {
    state = state.copyWith(showDate: show);
  }

  void setWallpaper(String? path) {
    state = state.copyWith(wallpaperPath: path);
  }

  void updateWidgets(List<String> widgets) {
    state = state.copyWith(activeWidgets: widgets);
  }

  void toggleNowBar(bool enabled) {
    state = state.copyWith(nowBarEnabled: enabled);
  }
}

final customizationProvider =
    StateNotifierProvider<CustomizationNotifier, CustomizationState>(
  (ref) => CustomizationNotifier(),
);
