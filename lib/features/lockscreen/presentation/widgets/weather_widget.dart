// lib/features/lockscreen/presentation/widgets/weather_widget.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oneui85_simulator/app/theme/color_tokens.dart';
import 'package:oneui85_simulator/app/theme/typography.dart';
import 'package:oneui85_simulator/features/lockscreen/domain/models/weather_data.dart';
import 'package:oneui85_simulator/features/lockscreen/domain/providers/weather_provider.dart';

class WeatherWidget extends ConsumerWidget {
  const WeatherWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weather = ref.watch(weatherProvider);
    return weather.when(
      data: (data) => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(_iconFor(data.condition), color: ColorTokens.weatherIconTint),
          const SizedBox(width: 6),
          Text(
            '${data.temperatureCelsius.round()}°',
            style: AppTypography.weatherLabel(ColorTokens.clockTextColor),
          ),
        ],
      ),
      loading: () => const SizedBox(width: 24, height: 24),
      error: (_, __) => const SizedBox.shrink(),
    );
  }

  IconData _iconFor(WeatherCondition c) {
    switch (c) {
      case WeatherCondition.rain:
        return Icons.grain;
      case WeatherCondition.snow:
        return Icons.ac_unit;
      case WeatherCondition.cloudy:
        return Icons.cloud;
      case WeatherCondition.clear:
        return Icons.wb_sunny;
    }
  }
}
