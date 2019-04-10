import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_weather/ui/getlocation/getlocation_page.dart';

void main() {
  testWidgets('verify location from GetLocationPage',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        title: 'GetLocation',
        home: GetLocationPage(),
      ),
    );

    await tester.pump();
    expect(find.byType(Text), findsOneWidget);
    await tester.pumpAndSettle();
    expect(find.byType(Text), findsOneWidget);
    var text = find.byType(Text).evaluate().single.widget as Text;
    print(text.data + ' done');
  });
}
