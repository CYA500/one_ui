// lib/features/lockscreen/presentation/widgets/notification_stack.dart
import 'package:flutter/material.dart';
import 'blurred_notification_card.dart';

class NotificationStack extends StatefulWidget {
  const NotificationStack({super.key});

  @override
  State<NotificationStack> createState() => _NotificationStackState();
}

class _NotificationStackState extends State<NotificationStack> {
  final List<Map<String, String>> _notifications = [
    {'title': 'Messages', 'body': 'Ahmed: See you at 7 PM'},
    {'title': 'Calendar', 'body': 'Team meeting in 30 minutes'},
    {'title': 'Weather', 'body': 'Light rain expected today'},
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Stack(
        children: _notifications.asMap().entries.map((entry) {
          final idx = entry.key;
          final notif = entry.value;
          return Positioned(
            top: idx * 60.0,
            left: 0,
            right: 0,
            child: Dismissible(
              key: Key(notif['title']!),
              direction: DismissDirection.horizontal,
              onDismissed: (_) {
                setState(() {
                  _notifications.removeAt(idx);
                });
              },
              child: FadeTransition(
                opacity: AlwaysStoppedAnimation(1.0 - idx * 0.15),
                child: BlurredNotificationCard(
                  title: notif['title']!,
                  body: notif['body']!,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
