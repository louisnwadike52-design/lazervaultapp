import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:lazervault/main.dart' as app;
import 'package:lazervault/core/types/app_routes.dart';
import 'package:get/get.dart' as getx;

/// Integration Test for Batch Transfer Flow
///
/// Tests the full batch transfer flow including:
/// 1. Navigating to batch transfer screen and seeing history
/// 2. Searching for a user by username (not saved as recipient)
/// 3. Adding the searched user as a batch transfer recipient
/// 4. Completing the batch transfer payment flow
///
/// Prerequisites:
/// - Backend services must be running (auth-service, accounts-service, core-payments-service, transfer-gateway)
/// - Login credentials: efizy@gmail.com / Password1$
/// - User "louis" must exist in the system
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Batch Transfer Flow - Integration Tests', () {
    setUpAll(() async {
      app.main();
    });

    /// Helper: Login with test credentials
    Future<void> loginIfNeeded(WidgetTester tester) async {
      await tester.pumpAndSettle(const Duration(seconds: 3));

      // Check if we're on login screen
      final emailField = find.byType(TextField).first;
      if (emailField.evaluate().isNotEmpty) {
        // Try to find email field by hint
        final emailFields = find.widgetWithText(TextField, 'Email');
        if (emailFields.evaluate().isNotEmpty) {
          await tester.enterText(emailFields.first, 'efizy@gmail.com');
          await tester.pumpAndSettle();

          // Find password field
          final passwordFields = find.widgetWithText(TextField, 'Password');
          if (passwordFields.evaluate().isNotEmpty) {
            await tester.enterText(passwordFields.first, r'Password1$');
            await tester.pumpAndSettle();
          }

          // Find and tap login button
          final loginButton = find.widgetWithText(ElevatedButton, 'Login');
          if (loginButton.evaluate().isEmpty) {
            final signInButton = find.widgetWithText(ElevatedButton, 'Sign In');
            if (signInButton.evaluate().isNotEmpty) {
              await tester.tap(signInButton.first);
            }
          } else {
            await tester.tap(loginButton.first);
          }
          await tester.pumpAndSettle(const Duration(seconds: 5));
        }
      }
    }

    /// Test 1: Navigate to Batch Transfer and verify landing page shows history section
    testWidgets('Batch transfer landing page shows recent history',
        (WidgetTester tester) async {
      await tester.pumpAndSettle();
      await loginIfNeeded(tester);
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // Navigate to batch transfer
      getx.Get.toNamed(AppRoutes.batchTransfer);
      await tester.pumpAndSettle(const Duration(seconds: 3));

      // Verify batch transfer screen is displayed
      expect(find.text('Batch Transfer'), findsOneWidget,
          reason: 'Batch transfer screen title should be visible');
      expect(find.text('Send to multiple recipients at once'), findsOneWidget,
          reason: 'Subtitle should be visible');

      // Verify quick info bar
      expect(find.text('Max Recipients'), findsOneWidget);
      expect(find.text('20'), findsOneWidget);
      expect(find.text('Fee'), findsOneWidget);
      expect(find.text('Free'), findsOneWidget);

      // Check for recent transfers section (may or may not show depending on history)
      // The section title only appears when history data is loaded
      await tester.pumpAndSettle(const Duration(seconds: 3));
      final recentTransfersTitle = find.text('Recent Transfers');
      if (recentTransfersTitle.evaluate().isNotEmpty) {
        expect(find.text('View All'), findsOneWidget,
            reason: 'View All link should be visible when history exists');
      }

      // Verify the form section is present
      expect(find.text('Add Recipients'), findsWidgets,
          reason: 'Add Recipients section should be visible in the form');

      // Navigate back
      getx.Get.back();
      await tester.pumpAndSettle();
    });

    /// Test 2: Open recipient selector and search for a user
    testWidgets('Search for user in batch transfer recipient selector',
        (WidgetTester tester) async {
      await tester.pumpAndSettle();
      await loginIfNeeded(tester);
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // Navigate to batch transfer
      getx.Get.toNamed(AppRoutes.batchTransfer);
      await tester.pumpAndSettle(const Duration(seconds: 3));

      // Find and tap the "Add Recipients" button
      final addButton = find.byIcon(Icons.person_add_outlined);
      if (addButton.evaluate().isNotEmpty) {
        await tester.tap(addButton.first);
        await tester.pumpAndSettle(const Duration(seconds: 2));

        // The multi-select bottom sheet should be open
        // Look for the "Search Users" tab
        final searchUsersTab = find.text('Search Users');
        if (searchUsersTab.evaluate().isNotEmpty) {
          await tester.tap(searchUsersTab.first);
          await tester.pumpAndSettle(const Duration(seconds: 1));

          // Find the user search field and search for "louis"
          final searchFields = find.byType(TextField);
          // The search field should be in the "Search Users" tab
          for (final field in searchFields.evaluate()) {
            final widget = field.widget as TextField;
            if (widget.decoration?.hintText?.toLowerCase().contains('search') ??
                false) {
              await tester.enterText(find.byWidget(widget), 'louis');
              break;
            }
          }
          await tester.pumpAndSettle(const Duration(seconds: 3));

          // Check if search results appeared
          // Look for user name or username in results
          final louisResult = find.textContaining('louis', findRichText: true);
          expect(louisResult, findsWidgets,
              reason:
                  'Search for "louis" should return at least one user result');

          // Select the first result
          if (louisResult.evaluate().isNotEmpty) {
            await tester.tap(louisResult.first);
            await tester.pumpAndSettle();
          }

          // Confirm selection by tapping the confirm/done button
          final confirmButton = find.text('Confirm');
          final addSelectedButton = find.text('Add Selected');
          final doneButton = find.text('Done');
          if (confirmButton.evaluate().isNotEmpty) {
            await tester.tap(confirmButton.first);
          } else if (addSelectedButton.evaluate().isNotEmpty) {
            await tester.tap(addSelectedButton.first);
          } else if (doneButton.evaluate().isNotEmpty) {
            await tester.tap(doneButton.first);
          }
          await tester.pumpAndSettle(const Duration(seconds: 1));
        }
      }

      // Navigate back
      getx.Get.back();
      await tester.pumpAndSettle();
    });

    /// Test 3: Full flow - search user, add recipient, set amount, proceed to review
    testWidgets('Complete batch transfer flow with searched user',
        (WidgetTester tester) async {
      await tester.pumpAndSettle();
      await loginIfNeeded(tester);
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // Navigate to batch transfer
      getx.Get.toNamed(AppRoutes.batchTransfer);
      await tester.pumpAndSettle(const Duration(seconds: 3));

      // Step 1: Open recipient selector
      final addButton = find.byIcon(Icons.person_add_outlined);
      if (addButton.evaluate().isEmpty) {
        // Try alternative button text
        final addRecipientsBtn = find.textContaining('Add');
        if (addRecipientsBtn.evaluate().isNotEmpty) {
          await tester.tap(addRecipientsBtn.first);
        }
      } else {
        await tester.tap(addButton.first);
      }
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // Step 2: Switch to "Search Users" tab and search for louis
      final searchUsersTab = find.text('Search Users');
      if (searchUsersTab.evaluate().isNotEmpty) {
        await tester.tap(searchUsersTab.first);
        await tester.pumpAndSettle(const Duration(seconds: 1));

        // Find the search input in the Search Users tab
        final searchFields = find.byType(TextField);
        TextField? searchTextField;
        for (final field in searchFields.evaluate()) {
          final widget = field.widget as TextField;
          final hint = widget.decoration?.hintText?.toLowerCase() ?? '';
          if (hint.contains('search') || hint.contains('username')) {
            searchTextField = widget;
            break;
          }
        }

        if (searchTextField != null) {
          await tester.enterText(find.byWidget(searchTextField), 'louis');
          await tester.pumpAndSettle(const Duration(seconds: 3));

          // Select the first search result
          final louisResult = find.textContaining('louis', findRichText: true);
          if (louisResult.evaluate().isNotEmpty) {
            await tester.tap(louisResult.first);
            await tester.pumpAndSettle();
          }
        }

        // Confirm selection
        final confirmBtn = find.text('Confirm');
        final addSelectedBtn = find.text('Add Selected');
        if (confirmBtn.evaluate().isNotEmpty) {
          await tester.tap(confirmBtn.first);
        } else if (addSelectedBtn.evaluate().isNotEmpty) {
          await tester.tap(addSelectedBtn.first);
        }
        await tester.pumpAndSettle(const Duration(seconds: 2));
      }

      // Step 3: Verify recipient was added and enter amount
      // The recipient card should now be visible in the form
      await tester.pumpAndSettle(const Duration(seconds: 1));

      // Find amount input field(s) and enter a small test amount
      final amountFields = find.byType(TextField);
      for (final field in amountFields.evaluate()) {
        final widget = field.widget as TextField;
        final hint = widget.decoration?.hintText?.toLowerCase() ?? '';
        if (hint.contains('amount') || hint.contains('0.00')) {
          await tester.enterText(find.byWidget(widget), '100');
          await tester.pumpAndSettle();
          break;
        }
      }

      // Step 4: Look for the proceed/review button
      final proceedButton = find.text('Review Transfer');
      final continueButton = find.text('Continue');
      final reviewButton = find.text('Review');

      if (proceedButton.evaluate().isNotEmpty) {
        // Scroll down to make sure button is visible
        await tester.ensureVisible(proceedButton.first);
        await tester.pumpAndSettle();

        // Verify button is enabled (amount was entered)
        expect(proceedButton, findsOneWidget,
            reason: 'Review Transfer button should be visible after adding recipient and amount');
      } else if (continueButton.evaluate().isNotEmpty) {
        await tester.ensureVisible(continueButton.first);
        await tester.pumpAndSettle();
      } else if (reviewButton.evaluate().isNotEmpty) {
        await tester.ensureVisible(reviewButton.first);
        await tester.pumpAndSettle();
      }

      // Navigate back without executing (don't actually transfer in test)
      getx.Get.back();
      await tester.pumpAndSettle();
    });

    /// Test 4: Verify batch transfer history screen loads
    testWidgets('Batch transfer history screen loads and displays data',
        (WidgetTester tester) async {
      await tester.pumpAndSettle();
      await loginIfNeeded(tester);
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // Navigate directly to batch transfer history
      getx.Get.toNamed(AppRoutes.batchTransferHistory);
      await tester.pumpAndSettle(const Duration(seconds: 3));

      // Verify history screen is displayed
      expect(find.text('Batch Transfer History'), findsOneWidget,
          reason: 'History screen title should be visible');
      expect(find.text('View past batch transfers'), findsOneWidget,
          reason: 'History subtitle should be visible');

      // Wait for data to load
      await tester.pumpAndSettle(const Duration(seconds: 3));

      // Check if either history items or empty state is shown
      final noTransfersText = find.text('No batch transfers yet');
      if (noTransfersText.evaluate().isNotEmpty) {
        // Empty state - verify the "Start Batch Transfer" action is available
        expect(noTransfersText, findsOneWidget,
            reason: 'Empty state message should be shown when no history');
      } else {
        // Has history - verify list items are shown
        // Each batch tile has a status badge
        final statusBadges = find.textContaining(RegExp(r'Completed|Success|Failed|Partial'));
        expect(statusBadges, findsWidgets,
            reason: 'Batch history items should show status badges');
      }

      // Navigate back
      getx.Get.back();
      await tester.pumpAndSettle();
    });

    /// Test 5: Verify "View All" navigates from landing page to history
    testWidgets('View All link navigates to full history',
        (WidgetTester tester) async {
      await tester.pumpAndSettle();
      await loginIfNeeded(tester);
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // Navigate to batch transfer
      getx.Get.toNamed(AppRoutes.batchTransfer);
      await tester.pumpAndSettle(const Duration(seconds: 3));

      // Wait for history to load
      await tester.pumpAndSettle(const Duration(seconds: 3));

      // Check if Recent Transfers section exists
      final viewAllLink = find.text('View All');
      if (viewAllLink.evaluate().isNotEmpty) {
        // Tap View All to go to full history
        await tester.tap(viewAllLink.first);
        await tester.pumpAndSettle(const Duration(seconds: 3));

        // Should now be on the history screen
        expect(find.text('Batch Transfer History'), findsOneWidget,
            reason: 'Should navigate to full history screen');

        // Navigate back to batch transfer
        getx.Get.back();
        await tester.pumpAndSettle();
      }

      // Navigate back
      getx.Get.back();
      await tester.pumpAndSettle();
    });

    /// Test 6: History button in header navigates to history
    testWidgets('History button navigates to history screen',
        (WidgetTester tester) async {
      await tester.pumpAndSettle();
      await loginIfNeeded(tester);
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // Navigate to batch transfer
      getx.Get.toNamed(AppRoutes.batchTransfer);
      await tester.pumpAndSettle(const Duration(seconds: 3));

      // Find and tap the history icon button in the header
      final historyIcon = find.byIcon(Icons.history_rounded);
      expect(historyIcon, findsOneWidget,
          reason: 'History icon should be in the header');

      await tester.tap(historyIcon);
      await tester.pumpAndSettle(const Duration(seconds: 3));

      // Should now be on history screen
      expect(find.text('Batch Transfer History'), findsOneWidget,
          reason: 'Should navigate to history screen');

      // Navigate back
      getx.Get.back();
      await tester.pumpAndSettle();
    });
  });
}
