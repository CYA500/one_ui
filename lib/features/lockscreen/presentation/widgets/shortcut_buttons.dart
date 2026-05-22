// lib/features/lockscreen/presentation/widgets/shortcut_buttons.dart
import 'package:flutter/material.dart';
import 'package:oneui85_simulator/app/theme/color_tokens.dart';
import 'package:oneui85_simulator/core/constants/durations.dart';
import 'package:oneui85_simulator/core/utils/haptic_util.dart';
import 'package:oneui85_simulator/shared/widgets/pill_button.dart';

class ShortcutButtons extends StatelessWidget {
  const ShortcutButtons({super.key});

  Future<void> _onLongPress() async {
    await HapticUtil.heavy();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _Shortcut(
          icon: Icons.phone,
          glow: ColorTokens.shortcutPhoneGlow,
          onLongPress: _onLongPress,
        ),
        _Shortcut(
          icon: Icons.camera_alt,
          glow: ColorTokens.shortcutCameraGlow,
          onLongPress: _onLongPress,
        ),
      ],
    );
  }
}

class _Shortcut extends StatefulWidget {
  const _Shortcut({
    required this.icon,
    required this.glow,
    required this.onLongPress,
  });

  final IconData icon;
  final Color glow;
  final Future<void> Function() onLongPress;

  @override
  State<_Shortcut> createState() => _ShortcutState();
}

class _ShortcutState extends State<_Shortcut> {
  bool _active = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPressStart: (_) async {
        setState(() => _active = true);
        await widget.onLongPress();
      },
      onLongPressEnd: (_) => setState(() => _active = false),
      child: AnimatedScale(
        scale: _active ? 1.1 : 1,
        duration: AppDurations.shortcutLongPress,
        child: PillButton(
          glowColor: _active ? widget.glow : null,
          onPressed: () => HapticUtil.light(),
          child: Icon(widget.icon, color: ColorTokens.clockTextColor),
        ),
      ),
    );
  }
}
