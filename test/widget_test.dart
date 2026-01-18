import 'package:flutter_test/flutter_test.dart';

import 'package:waste_not_app/main.dart';

void main() {
  testWidgets('Check if WasteNot text is shown', (WidgetTester tester) async {
    // Build our app
    await tester.pumpWidget(const WasteNotApp());

    // Verify that WasteNot text appears
    expect(find.text('WasteNot'), findsOneWidget);
  });
}
