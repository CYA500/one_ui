// lib/app/app.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oneui85_simulator/app/routes.dart';
import 'package:oneui85_simulator/app/theme/app_theme.dart';
import 'package:oneui85_simulator/core/constants/strings.dart';

class OneUiApp extends ConsumerWidget {
  const OneUiApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = createRouter();
    return MaterialApp.router(
      title: AppStrings.appTitle,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.dark,
      routerConfig: router,
    );
  }
}
