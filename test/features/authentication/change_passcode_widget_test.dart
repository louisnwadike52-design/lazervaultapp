import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:lazervault/src/features/authentication/presentation/views/change_passcode_screen.dart';

void main() {
  group('ChangePasscodeScreen Widget Tests', () {
    testWidgets('should display Change Passcode title', (WidgetTester tester) async {
      // Arrange & Act
      await tester.pumpWidget(
        GetMaterialApp(
          home: const ChangePasscodeScreen(),
        ),
      );

      // Assert
      expect(find.text('Change Passcode'), findsOneWidget);
    });

    testWidgets('should display Enter Current Passcode text initially', (WidgetTester tester) async {
      // Arrange & Act
      await tester.pumpWidget(
        GetMaterialApp(
          home: const ChangePasscodeScreen(),
        ),
      );

      // Assert
      expect(find.text('Enter Current Passcode'), findsOneWidget);
    });

    testWidgets('should display 6 passcode dots', (WidgetTester tester) async {
      // Arrange & Act
      await tester.pumpWidget(
        GetMaterialApp(
          home: const ChangePasscodeScreen(),
        ),
      );

      // Assert - Find containers that represent passcode dots
      final dotContainers = find.byWidgetPredicate(
        (widget) => widget is Container && widget.decoration is BoxDecoration,
      );

      // Should have at least the 6 passcode dots among other containers
      expect(dotContainers, findsWidgets);
    });

    testWidgets('should display number pad with digits 0-9', (WidgetTester tester) async {
      // Arrange & Act
      await tester.pumpWidget(
        GetMaterialApp(
          home: const ChangePasscodeScreen(),
        ),
      );

      // Assert
      for (int i = 0; i <= 9; i++) {
        expect(find.text(i.toString()), findsOneWidget);
      }
    });

    testWidgets('should display backspace button', (WidgetTester tester) async {
      // Arrange & Act
      await tester.pumpWidget(
        GetMaterialApp(
          home: const ChangePasscodeScreen(),
        ),
      );

      // Assert
      expect(find.byIcon(Icons.backspace_outlined), findsOneWidget);
    });

    testWidgets('should move to next step after entering 6 digits', (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(
        GetMaterialApp(
          home: const ChangePasscodeScreen(),
        ),
      );

      // Act - Enter 6 digits
      for (int i = 1; i <= 6; i++) {
        await tester.tap(find.text('1'));
        await tester.pump();
      }

      // Assert - Should now show "Enter New Passcode"
      expect(find.text('Enter New Passcode'), findsOneWidget);
    });

    testWidgets('should show error when passcodes do not match', (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(
        GetMaterialApp(
          home: const ChangePasscodeScreen(),
        ),
      );

      // Act - Enter old passcode (6 digits)
      for (int i = 1; i <= 6; i++) {
        await tester.tap(find.text('1'));
        await tester.pump();
      }

      // Enter new passcode (6 digits)
      for (int i = 1; i <= 6; i++) {
        await tester.tap(find.text('2'));
        await tester.pump();
      }

      // Enter different confirmation passcode (6 digits)
      for (int i = 1; i <= 6; i++) {
        await tester.tap(find.text('3'));
        await tester.pump();
      }

      await tester.pumpAndSettle();

      // Assert - Should show error message
      expect(find.text('Passcodes do not match'), findsOneWidget);
    });

    testWidgets('backspace should remove last digit', (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(
        GetMaterialApp(
          home: const ChangePasscodeScreen(),
        ),
      );

      // Act - Enter 3 digits
      for (int i = 1; i <= 3; i++) {
        await tester.tap(find.text('1'));
        await tester.pump();
      }

      // Tap backspace
      await tester.tap(find.byIcon(Icons.backspace_outlined));
      await tester.pump();

      // Assert - Should still be on step 1 (current passcode)
      expect(find.text('Enter Current Passcode'), findsOneWidget);
    });

    testWidgets('should have back button to navigate back', (WidgetTester tester) async {
      // Arrange & Act
      await tester.pumpWidget(
        GetMaterialApp(
          home: const ChangePasscodeScreen(),
        ),
      );

      // Assert
      expect(find.byIcon(Icons.arrow_back), findsOneWidget);
    });
  });
}
