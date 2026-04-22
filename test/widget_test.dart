import 'package:flutter_test/flutter_test.dart';
import 'package:plank_app/main.dart';

void main() {
  testWidgets('PlankApp smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const PlankApp());
    expect(find.text('スタート'), findsOneWidget);
  });
}
