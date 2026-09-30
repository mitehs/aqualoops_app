import 'package:flutter_test/flutter_test.dart';
import 'package:aqualoops_app/main.dart';

void main() {
  testWidgets('AquaLoop app renders', (WidgetTester tester) async {
    await tester.pumpWidget(const AquaLoopApp());
    await tester.pump(const Duration(seconds: 3));
    await tester.pumpAndSettle();

    expect(find.text('Login'), findsOneWidget);
  });
}
