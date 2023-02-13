import 'package:flutter_ecommerce/main.dart';
import 'package:flutter_ecommerce/state/auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  testWidgets('startup redirects to home when signed in', (tester) async {
    SharedPreferences.setMockInitialValues({});
    await tester.pumpWidget(
      const ProviderScope(child: App()),
    );
    expect(find.text('Splash Page'), findsOneWidget);

    await tester.pumpAndSettle();
    expect(find.text('Home Page'), findsNothing);
    expect(find.text('Splash Page'), findsNothing);
    expect(find.text('Login Page'), findsOneWidget);

    // Tap the login button
    await tester.tap(find.bySemanticsLabel('Login'));
    // In a real test, you would never wait for a fake timer. Don't do this at home.
    await tester.pumpAndSettle(networkRoundTripTime);

    expect(find.text('Login Page'), findsNothing);
    expect(find.text('Splash Page'), findsNothing);
    expect(find.text('Home Page'), findsOneWidget);

    // Tap the logout button
    await tester.tap(find.bySemanticsLabel('Logout'));
    // In a real test, you would never wait for a fake timer. Don't do this at home.
    await tester.pumpAndSettle(networkRoundTripTime);

    expect(find.text('Splash Page'), findsNothing);
    expect(find.text('Home Page'), findsNothing);
    expect(find.text("Login Page"), findsOneWidget);

    return;
  });
}
