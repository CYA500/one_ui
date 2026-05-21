// lib/features/home_screen/presentation/widgets/dock_bar.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../app/theme/color_tokens.dart';
import '../../../../core/constants/dimensions.dart';
import '../../domain/providers/home_provider.dart';

/// شريط إرساء ثابت يحتوي على 4 أيقونات رئيسية.
class DockBar extends ConsumerWidget {
  const DockBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Container(
        margin: const EdgeInsets.only(bottom: 12, left: 16, right: 16),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        decoration: BoxDecoration(
          color: ColorTokens.glassWhite,
          borderRadius: BorderRadius.circular(32),
          border: Border.all(color: ColorTokens.borderGlass),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _DockIcon(icon: Icons.phone, label: 'Phone'),
            _DockIcon(icon: Icons.message, label: 'Messages'),
            _DockIcon(icon: Icons.camera_alt, label: 'Camera'),
            _DockIcon(icon: Icons.web, label: 'Browser'),
          ],
        ),
      ),
    );
  }
}

class _DockIcon extends StatelessWidget {
  final IconData icon;
  final String label;
  const _DockIcon({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 56,
      height: 56,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.white, size: 28),
          const SizedBox(height: 2),
          Text(
            label,
            style: const TextStyle(color: Colors.white70, fontSize: 10),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
