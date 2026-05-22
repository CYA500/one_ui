// lib/features/lockscreen/presentation/widgets/clock_widget.dart
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oneui85_simulator/app/theme/typography.dart';
import 'package:oneui85_simulator/core/constants/durations.dart';
import 'package:oneui85_simulator/core/utils/time_util.dart';
import 'package:oneui85_simulator/features/customization/domain/providers/customization_provider.dart';
import 'package:oneui85_simulator/features/lockscreen/domain/models/clock_style.dart';
import 'package:oneui85_simulator/features/lockscreen/domain/providers/clock_provider.dart';
import 'package:oneui85_simulator/features/lockscreen/domain/providers/weather_provider.dart';

class ClockWidget extends ConsumerStatefulWidget {
  const ClockWidget({super.key});

  @override
  ConsumerState<ClockWidget> createState() => _ClockWidgetState();
}

class _ClockWidgetState extends ConsumerState<ClockWidget>
    with TickerProviderStateMixin {
  late final AnimationController _breathController;
  late final AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _breathController = AnimationController(
      vsync: this,
      duration: AppDurations.clockBreath,
    )..repeat(reverse: true);
    _pulseController = AnimationController(
      vsync: this,
      duration: AppDurations.clockPulse,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _breathController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final customization = ref.watch(customizationProvider);
    final clockAsync = ref.watch(clockProvider);
    final weatherAsync = ref.watch(weatherProvider);

    return clockAsync.when(
      data: (time) {
        final color = customization.clockColor;
        return Transform.translate(
          offset: customization.clockOffset,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildClock(time, customization.clockStyle, color),
              if (customization.showDate) ...[
                const SizedBox(height: 8),
                Text(
                  TimeUtil.formatDate(time),
                  style: AppTypography.dateLabel(color),
                ),
              ],
              if (customization.showWeather)
                weatherAsync.when(
                  data: (w) => Text(
                    '${w.temperatureCelsius.round()}° • ${w.city}',
                    style: AppTypography.weatherLabel(color),
                  ),
                  loading: () => const SizedBox(height: 20),
                  error: (_, __) => const SizedBox.shrink(),
                ),
            ],
          ),
        );
      },
      loading: () => const CircularProgressIndicator(),
      error: (_, __) => const SizedBox.shrink(),
    );
  }

  Widget _buildClock(DateTime time, ClockStyle style, Color color) {
    switch (style) {
      case ClockStyle.digitalThin:
        return FadeTransition(
          opacity: Tween(begin: 0.7, end: 1.0).animate(_breathController),
          child: Text(
            TimeUtil.formatTime(time),
            style: AppTypography.clockDisplay(color).copyWith(
              fontWeight: FontWeight.w200,
            ),
          ),
        );
      case ClockStyle.digitalBold:
        return ScaleTransition(
          scale: Tween(begin: 0.98, end: 1.02).animate(_pulseController),
          child: Text(
            TimeUtil.formatTime(time),
            style: AppTypography.clockDisplay(color).copyWith(
              fontWeight: FontWeight.w700,
              shadows: const [
                Shadow(blurRadius: 12, color: Colors.black54),
              ],
            ),
          ),
        );
      case ClockStyle.analog:
        return SizedBox(
          width: 200,
          height: 200,
          child: CustomPaint(
            painter: _AnalogClockPainter(time: time, color: color),
          ),
        );
      case ClockStyle.retroFlip:
        return _FlipClock(time: time, color: color);
    }
  }
}

class _FlipClock extends StatelessWidget {
  const _FlipClock({required this.time, required this.color});

  final DateTime time;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final digits = TimeUtil.formatTime(time).split('');
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: digits.map((d) {
        return AnimatedSwitcher(
          duration: AppDurations.clockFlip,
          transitionBuilder: (child, animation) {
            return RotationTransition(
              turns: Tween(begin: 0.5, end: 0.0).animate(animation),
              child: child,
            );
          },
          child: Text(
            d,
            key: ValueKey('$d-${time.second}'),
            style: AppTypography.clockStyleFlip(color),
          ),
        );
      }).toList(),
    );
  }
}

class _AnalogClockPainter extends CustomPainter {
  _AnalogClockPainter({required this.time, required this.color});

  final DateTime time;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 8;
    final border = Paint()
      ..color = color.withValues(alpha: 0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.drawCircle(center, radius, border);

    final hourAngle = (time.hour % 12 + time.minute / 60) * 30 * math.pi / 180;
    final minuteAngle = time.minute * 6 * math.pi / 180;
    final secondAngle = time.second * 6 * math.pi / 180;

    void hand(double angle, double length, double width, Color c) {
      final end = Offset(
        center.dx + length * math.sin(angle),
        center.dy - length * math.cos(angle),
      );
      canvas.drawLine(
        center,
        end,
        Paint()
          ..color = c
          ..strokeWidth = width
          ..strokeCap = StrokeCap.round,
      );
    }

    hand(hourAngle, radius * 0.5, 4, color);
    hand(minuteAngle, radius * 0.7, 3, color.withValues(alpha: 0.9));
    hand(secondAngle, radius * 0.85, 1.5, color.withValues(alpha: 0.6));
    canvas.drawCircle(center, 4, Paint()..color = color);
  }

  @override
  bool shouldRepaint(covariant _AnalogClockPainter oldDelegate) =>
      oldDelegate.time != time;
}
