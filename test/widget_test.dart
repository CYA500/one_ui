import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oneui85_simulator/app/app.dart';

void main() {
  testWidgets('OneUiApp smoke test', (tester) async {
    await tester.pumpWidget(
      const ProviderScope(child: OneUiApp()),
    );
    expect(find.byType(OneUiApp), findsOneWidget);
  });
}
