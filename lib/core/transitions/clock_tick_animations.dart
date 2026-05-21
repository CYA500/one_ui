// lib/core/transitions/clock_tick_animations.dart
import 'package:flutter/material.dart';
import '../../app/theme/typography.dart';
import '../constants/durations.dart';

/// أنيميشن تكت الساعة الرقمي (تغير العتامة كل دقيقة)
class DigitalTickWidget extends StatefulWidget {
  final DateTime time;
  final Color color;
  const DigitalTickWidget({super.key, required this.time, required this.color});

  @override
  State<DigitalTickWidget> createState() => _DigitalTickWidgetState();
}

class _DigitalTickWidgetState extends State<DigitalTickWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacity;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: AppDurations.clockTick,
      vsync: this,
    );
    _opacity = Tween<double>(begin: 0.7, end: 1.0).animate(_controller);
    // يبدأ خافت ويعود كل دقيقة
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.forward().then((_) => _controller.reverse());
    });
  }

  @override
  void didUpdateWidget(DigitalTickWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    // عندما تتغير الدقيقة، نُشغل الأنيميشن
    if (oldWidget.time.minute != widget.time.minute) {
      _controller.forward(from: 0.7).then((_) => _controller.reverse());
    }
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
      animation: _opacity,
      builder: (context, child) {
        return Opacity(
          opacity: _opacity.value,
          child: Text(
            '$hour:$minute',
            style: AppTypography.clockDisplay.copyWith(color: widget.color),
          ),
        );
      },
    );
  }
}

/// أنيميشن بطاقة القلب (Flip) للأرقام المتغيرة (للساعة Retro Flip)
class FlipDigit extends StatelessWidget {
  final String digit;
  final Color color;
  const FlipDigit({super.key, required this.digit, required this.color});

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: AppDurations.clockTick,
      switchInCurve: Curves.easeInBack,
      switchOutCurve: Curves.easeOutBack,
      transitionBuilder: (child, animation) {
        return RotationTransition(
          turns: Tween<double>(begin: 0.0, end: 0.5).animate(animation),
          child: child,
        );
      },
      child: Text(
        digit,
        key: ValueKey(digit),
        style: AppTypography.clockStyleFlip.copyWith(color: color),
      ),
    );
  }
}
