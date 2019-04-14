import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'current_location_page.dart';

void main() {
  testWidgets('verify location from GetLocationPage',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        title: 'GetLocation',
        home: CurrentLocationPage(),
      ),
    );

    await tester.pump();

    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    await tester.pumpAndSettle();

    expect(find.byType(CircularProgressIndicator), findsNothing);
    var text = find.byType(Text).evaluate().single.widget as Text;
    print(text.data);
  });
}
