import 'package:flutter_test/flutter_test.dart';
import 'package:aqualoops_app/main.dart';

void main() {
  testWidgets('AquaLoop app renders', (WidgetTester tester) async {
    await tester.pumpWidget(const AquaLoopApp());
    await tester.pump(const Duration(seconds: 3));
    await tester.pumpAndSettle();
    expect(find.text('Login'), findsOneWidget);
  });

  testWidgets('Admin login opens the dashboard', (WidgetTester tester) async {
    await tester.pumpWidget(const AquaLoopApp());
    await tester.pump(const Duration(seconds: 3));
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text('ADMIN'));
    await tester.tap(find.text('ADMIN'));
    await tester.pumpAndSettle();
    expect(find.text('Sign in to manage AquaLoop'), findsOneWidget);
    await tester.ensureVisible(find.text('LOGIN'));
    await tester.tap(find.text('LOGIN'));
    await tester.pump(const Duration(milliseconds: 800));
    await tester.pumpAndSettle();
    expect(find.text('Total Sales'), findsOneWidget);
    expect(find.text('Recent Orders'), findsOneWidget);
  });
}
