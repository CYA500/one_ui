// lib/features/home_screen/presentation/widgets/app_grid.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oneui85_simulator/app/transitions/app_open_transition.dart';
import 'package:oneui85_simulator/core/constants/dimensions.dart';
import 'package:oneui85_simulator/features/home_screen/domain/providers/home_provider.dart';
import 'package:oneui85_simulator/features/home_screen/presentation/widgets/app_icon.dart';

class AppGrid extends ConsumerStatefulWidget {
  const AppGrid({super.key, required this.pageIndex});

  final int pageIndex;

  @override
  ConsumerState<AppGrid> createState() => _AppGridState();
}

class _AppGridState extends ConsumerState<AppGrid> {
  bool _editing = false;
  int? _dragIndex;

  @override
  Widget build(BuildContext context) {
    final apps = ref.watch(homeProvider).apps;
    final perPage =
        (AppDimensions.appGridColumns * AppDimensions.appGridRows).toInt();
    final start = widget.pageIndex * perPage;
    final end = (start + perPage).clamp(0, apps.length);
    if (start >= apps.length) return const SizedBox.shrink();
    final pageApps = apps.sublist(start, end.toInt());

    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: AppDimensions.appGridColumns.toInt(),
        mainAxisSpacing: 20,
        crossAxisSpacing: 16,
        childAspectRatio: 0.82,
      ),
      itemCount: pageApps.length,
      itemBuilder: (context, index) {
        final globalIndex = start + index;
        final app = pageApps[index];
        return LongPressDraggable<int>(
          data: globalIndex,
          onDragStarted: () => setState(() {
            _editing = true;
            _dragIndex = globalIndex;
          }),
          onDragEnd: (_) => setState(() => _dragIndex = null),
          feedback: Material(
            color: Colors.transparent,
            child: AppIcon(
              app: app,
              isEditing: true,
              onRemove: () {},
              onOpen: () {},
            ),
          ),
          childWhenDragging: Opacity(
            opacity: 0.3,
            child: AppIcon(
              app: app,
              isEditing: _editing,
              onRemove: () {},
              onOpen: () {},
            ),
          ),
          child: DragTarget<int>(
            onAcceptWithDetails: (details) {
              ref.read(homeProvider.notifier).reorderApps(
                    _dragIndex ?? globalIndex,
                    globalIndex,
                  );
            },
            builder: (context, candidateData, rejectedData) {
              return GestureDetector(
                onLongPress: () => setState(() => _editing = true),
                child: AppIcon(
                  app: app,
                  isEditing: _editing,
                  onRemove: () => setState(() => _editing = false),
                  onOpen: () {
                    Navigator.of(context).push(
                      appOpenRoute(
                        Scaffold(
                          backgroundColor: app.color,
                          body: Center(
                            child: Hero(
                              tag: 'app-${app.id}',
                              child: Icon(app.icon, size: 80, color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        );
      },
    );
  }
}
