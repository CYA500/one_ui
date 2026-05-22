// lib/features/lockscreen/presentation/widgets/notification_stack.dart
import 'package:flutter/material.dart';
import 'package:oneui85_simulator/core/constants/dimensions.dart';
import 'package:oneui85_simulator/core/constants/durations.dart';
import 'package:oneui85_simulator/core/constants/strings.dart';
import 'package:oneui85_simulator/features/lockscreen/presentation/widgets/blurred_notification_card.dart';

class NotificationItem {
  const NotificationItem({required this.id, required this.title, required this.body});

  final String id;
  final String title;
  final String body;
}

class NotificationStack extends StatefulWidget {
  const NotificationStack({super.key});

  @override
  State<NotificationStack> createState() => _NotificationStackState();
}

class _NotificationStackState extends State<NotificationStack> {
  final List<NotificationItem> _items = [
    NotificationItem(
      id: '1',
      title: AppStrings.sampleNotificationTitle,
      body: AppStrings.sampleNotificationBody,
    ),
    NotificationItem(
      id: '2',
      title: AppStrings.sampleNotificationTitle2,
      body: AppStrings.sampleNotificationBody2,
    ),
    NotificationItem(
      id: '3',
      title: AppStrings.sampleNotificationTitle3,
      body: AppStrings.sampleNotificationBody3,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final visible = _items.take(AppDimensions.notificationMaxCards.toInt()).toList();
    return Column(
      children: visible.asMap().entries.map((entry) {
        final index = entry.key;
        final item = entry.value;
        return Padding(
          padding: EdgeInsets.only(bottom: index == 0 ? 0 : 8),
          child: Dismissible(
            key: ValueKey(item.id),
            direction: DismissDirection.horizontal,
            onDismissed: (_) {
              setState(() => _items.removeWhere((e) => e.id == item.id));
            },
            child: TweenAnimationBuilder<double>(
              tween: Tween(begin: 0, end: 1),
              duration: AppDurations.notificationEnter,
              curve: AppDurations.defaultCurve,
              builder: (context, value, child) {
                return Opacity(
                  opacity: value,
                  child: Transform.translate(
                    offset: Offset(0, (1 - value) * 20),
                    child: child,
                  ),
                );
              },
              child: BlurredNotificationCard(
                title: item.title,
                body: item.body,
                scale: 1 - index * 0.03,
                offsetY: index * 4,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
