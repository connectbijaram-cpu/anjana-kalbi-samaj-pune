import 'package:flutter_test/flutter_test.dart';
import 'package:anjana_kalbi_samaj_app/main.dart';

void main() {
  testWidgets('App loads successfully', (WidgetTester tester) async {
    await tester.pumpWidget(const AnjanaKalbiSamajApp());
    expect(find.text('आंजणा कलबी समाज'), findsWidgets);
  });
}
