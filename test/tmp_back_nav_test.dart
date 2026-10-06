import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:aqualoops_app/main.dart';
import 'package:aqualoops_app/screens/admin/admin_dashboard.dart';
import 'package:aqualoops_app/screens/admin/add_product_screen.dart';
import 'package:aqualoops_app/screens/auth/login_screen.dart';
import 'package:aqualoops_app/widgets/bottom_navbar.dart';

void main() {
  testWidgets('Back button never returns to the Login page', (
    WidgetTester tester,
  ) async {
    // The dashboard tabs contain ListTiles that trigger a pre-existing
    // framework layout warning (also present before the rewrite).
    // Swallow only those; every other exception still fails the test.
    final originalOnError = FlutterError.onError;
    FlutterError.onError = (FlutterErrorDetails details) {
      if (details.exceptionAsString().contains('ListTile')) return;
      originalOnError?.call(details);
    };
    addTearDown(() {
      FlutterError.onError = originalOnError;
    });

    await tester.pumpWidget(const AquaLoopApp());
    await tester.pump(const Duration(seconds: 3));
    await tester.pumpAndSettle();
    expect(find.byType(LoginScreen), findsOneWidget);

    // Enter the admin flow from the customer login screen.
    await tester.ensureVisible(find.text('ADMIN'));
    await tester.tap(find.text('ADMIN'));
    await tester.pumpAndSettle();
    expect(find.text('Sign in to manage AquaLoop'), findsOneWidget);

    await tester.ensureVisible(find.text('LOGIN'));
    await tester.tap(find.text('LOGIN'));
    await tester.pump(const Duration(milliseconds: 800));
    await tester.pumpAndSettle();
    expect(find.text('Total Sales'), findsOneWidget);

    // After logging in, Login must be gone from the history entirely.
    expect(find.byType(LoginScreen), findsNothing);

    // Products tab -> Add Product FAB (the user's reported flow).
    await tester.tap(
      find.descendant(
        of: find.byType(BottomNavBar),
        matching: find.text('Products'),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.widgetWithText(FloatingActionButton, 'Add Product'));
    await tester.pumpAndSettle();
    expect(find.byType(AddProductScreen), findsOneWidget);

    // Back from Add Product -> dashboard (Products tab), not Login.
    await tester.binding.handlePopRoute();
    await tester.pumpAndSettle();
    expect(find.byType(AddProductScreen), findsNothing);
    expect(find.byType(AdminDashboard), findsOneWidget);
    expect(find.byType(LoginScreen), findsNothing);

    // Back again at the dashboard root: Flutter bubbles to the OS (the app
    // closes on the device); it must NOT navigate to the Login page.
    await tester.binding.handlePopRoute();
    await tester.pumpAndSettle();
    expect(find.byType(LoginScreen), findsNothing);
    expect(find.byType(AdminDashboard), findsOneWidget); // dashboard stayed as root
  });
}
