// Basic smoke test — ensure the app builds without crashing.
import 'package:flutter_test/flutter_test.dart';
import 'package:lab1_ui_login/app/app.dart';

void main() {
  testWidgets('App builds without crashing', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    expect(find.byType(MyApp), findsOneWidget);
  });
}
