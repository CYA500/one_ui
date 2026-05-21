// lib/features/lockscreen/presentation/widgets/clock_widget.dart
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../app/theme/color_tokens.dart';
import '../../../../../app/theme/typography.dart';
import '../../../../../core/constants/durations.dart';
import '../../../domain/models/clock_style.dart';
import '../../../domain/providers/clock_provider.dart';
import '../../../../customization/domain/providers/customization_provider.dart';

class ClockWidget extends ConsumerWidget {
  const ClockWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dateTime = ref.watch(currentDateTimeProvider).valueOrNull ?? DateTime.now();
    final customization = ref.watch(customizationProvider);
    final style = customization.clockStyle;
    final color = customization.clockColor;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildClock(style, dateTime, color),
        if (customization.showDate) _buildDate(dateTime),
        if (customization.showWeather) const WeatherWidget(),
      ],
    );
  }

  Widget _buildClock(ClockStyle style, DateTime dt, Color color) {
    switch (style) {
      case ClockStyle.digitalThin:
        return _DigitalThinClock(dt, color);
      case ClockStyle.digitalBold:
        return _DigitalBoldClock(dt, color);
      case ClockStyle.analog:
        return _AnalogClock(dt, color);
      case ClockStyle.retroFlip:
        return _RetroFlipClock(dt, color);
    }
  }

  Widget _buildDate(DateTime dt) {
    return Text(
      '${dt.day}/${dt.month}/${dt.year}',
      style: AppTypography.dateLabel,
    );
  }
}

// ─── Digital Thin ───
class _DigitalThinClock extends StatefulWidget {
  final DateTime time;
  final Color color;
  const _DigitalThinClock(this.time, this.color);

  @override
  State<_DigitalThinClock> createState() => _DigitalThinClockState();
}

class _DigitalThinClockState extends State<_DigitalThinClock>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: AppDurations.breatheCycle,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final hour = widget.time.hour.toString().padLeft(2, '0');
    final minute = widget.time.minute.toString().padLeft(2, '0');
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, child) {
        return Opacity(
          opacity: 0.8 + 0.2 * _controller.value,
          child: Text(
            '$hour:$minute',
            style: AppTypography.clockDisplay.copyWith(color: widget.color),
          ),
        );
      },
    );
  }
}

// ─── Digital Bold ───
class _DigitalBoldClock extends StatefulWidget {
  final DateTime time;
  final Color color;
  const _DigitalBoldClock(this.time, this.color);

  @override
  State<_DigitalBoldClock> createState() => _DigitalBoldClockState();
}

class _DigitalBoldClockState extends State<_DigitalBoldClock>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: AppDurations.breatheCycle,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final hour = widget.time.hour.toString().padLeft(2, '0');
    final minute = widget.time.minute.toString().padLeft(2, '0');
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, child) {
        final scale = 1.0 + 0.02 * _controller.value;
        return Transform.scale(
          scale: scale,
          child: Text(
            '$hour:$minute',
            style: AppTypography.clockDisplay.copyWith(
              fontWeight: FontWeight.w700,
              color: widget.color,
              shadows: [
                    Shadow(
                      blurRadius: 20,
                      color: widget.color.withOpacity(0.5),
                    )
                  ],
            ),
          ),
        );
      },
    );
  }
}

// ─── Analog ───
class _AnalogClock extends StatelessWidget {
  final DateTime time;
  final Color color;
  const _AnalogClock(this.time, this.color);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 200,
      child: CustomPaint(
        painter: _AnalogPainter(time, color),
      ),
    );
  }
}

class _AnalogPainter extends CustomPainter {
  final DateTime time;
  final Color color;
  _AnalogPainter(this.time, this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 10;
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    // Draw ticks
    for (int i = 0; i < 60; i++) {
      final angle = (i * 6 - 90) * pi / 180;
      final start = Offset(
        center.dx + (radius - 4) * cos(angle),
        center.dy + (radius - 4) * sin(angle),
      );
      final end = Offset(
        center.dx + radius * cos(angle),
        center.dy + radius * sin(angle),
      );
      paint.strokeWidth = i % 5 == 0 ? 3 : 1;
      canvas.drawLine(start, end, paint);
    }

    // Hour hand
    final hourAngle = ((time.hour % 12) * 30 + time.minute * 0.5 - 90) * pi / 180;
    paint.strokeWidth = 6;
    canvas.drawLine(
      center,
      Offset(center.dx + radius * 0.5 * cos(hourAngle),
          center.dy + radius * 0.5 * sin(hourAngle)),
      paint,
    );

    // Minute hand
    final minuteAngle = (time.minute * 6 - 90) * pi / 180;
    paint.strokeWidth = 4;
    canvas.drawLine(
      center,
      Offset(center.dx + radius * 0.8 * cos(minuteAngle),
          center.dy + radius * 0.8 * sin(minuteAngle)),
      paint,
    );

    // Center dot
    paint.style = PaintingStyle.fill;
    canvas.drawCircle(center, 6, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

// ─── Retro Flip ───
class _RetroFlipClock extends StatefulWidget {
  final DateTime time;
  final Color color;
  const _RetroFlipClock(this.time, this.color);

  @override
  State<_RetroFlipClock> createState() => _RetroFlipClockState();
}

class _RetroFlipClockState extends State<_RetroFlipClock> {
  String _previousHour = '';
  String _previousMinute = '';

  @override
  Widget build(BuildContext context) {
    final hour = widget.time.hour.toString().padLeft(2, '0');
    final minute = widget.time.minute.toString().padLeft(2, '0');
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _FlipDigit(digit: hour, color: widget.color,
            key: ValueKey(hour)),
        const SizedBox(width: 12),
        Text(':', style: AppTypography.clockStyleFlip.copyWith(color: widget.color)),
        const SizedBox(width: 12),
        _FlipDigit(digit: minute, color: widget.color,
            key: ValueKey(minute)),
      ],
    );
  }
}

class _FlipDigit extends StatelessWidget {
  final String digit;
  final Color color;
  const _FlipDigit({required this.digit, required this.color, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: AppDurations.clockTick,
      switchInCurve: Curves.easeInBack,
      switchOutCurve: Curves.easeOutBack,
      transitionBuilder: (child, animation) {
        return FadeTransition(opacity: animation, child: child);
      },
      child: Text(
        digit,
        key: ValueKey(digit),
        style: AppTypography.clockStyleFlip.copyWith(color: color),
      ),
    );
  }
}
