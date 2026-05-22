// lib/app/simulator_shell.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oneui85_simulator/app/transitions/unlock_transition.dart';
import 'package:oneui85_simulator/core/constants/durations.dart';
import 'package:oneui85_simulator/features/home_screen/presentation/home_page.dart';
import 'package:oneui85_simulator/features/lockscreen/presentation/lockscreen_page.dart';

class SimulatorShell extends ConsumerStatefulWidget {
  const SimulatorShell({super.key});

  @override
  ConsumerState<SimulatorShell> createState() => _SimulatorShellState();
}

class _SimulatorShellState extends ConsumerState<SimulatorShell>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: AppDurations.unlockTransition,
      value: 1,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _unlock() async {
    await _controller.animateTo(0, curve: AppDurations.unlockCurve);
    HapticFeedback.mediumImpact();
  }

  Future<void> _lock() async {
    await _controller.animateTo(1, curve: AppDurations.lockCurve);
  }

  @override
  Widget build(BuildContext context) {
    final isUnlocked = _controller.value < 0.5;
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop && isUnlocked) _lock();
      },
      child: UnlockTransition(
        animation: _controller,
        lockChild: LockScreenPage(onUnlock: _unlock),
        homeChild: HomePage(onLock: _lock),
      ),
    );
  }
}
