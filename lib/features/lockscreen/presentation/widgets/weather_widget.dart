// lib/features/lockscreen/presentation/widgets/weather_widget.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../app/theme/typography.dart';
import '../../../domain/providers/weather_provider.dart';

class WeatherWidget extends ConsumerWidget {
  const WeatherWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weatherAsync = ref.watch(currentWeatherProvider);
    return weatherAsync.when(
      data: (data) => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.cloud, color: Colors.white70, size: 18),
          const SizedBox(width: 4),
          Text(
            '${data.temperature.toStringAsFixed(0)}° ${data.cityName}',
            style: AppTypography.weatherLabel,
          ),
        ],
      ),
      loading: () => const SizedBox.shrink(),
      error: (_, __) => const SizedBox.shrink(),
    );
  }
}
