// lib/features/lockscreen/presentation/widgets/swipe_hint.dart
import 'package:flutter/material.dart';

class SwipeHint extends StatefulWidget {
  const SwipeHint({super.key});

  @override
  State<SwipeHint> createState() => _SwipeHintState();
}

class _SwipeHintState extends State<SwipeHint>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, child) {
        return Opacity(
          opacity: _controller.value,
          child: Column(
            children: const [
              Icon(Icons.keyboard_arrow_up, color: Colors.white70, size: 28),
              Text('Swipe to open',
                  style: TextStyle(color: Colors.white70, fontSize: 13)),
            ],
          ),
        );
      },
    );
  }
}
