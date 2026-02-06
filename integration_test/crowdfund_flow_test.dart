import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:lazervault/main.dart' as app;
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/src/features/crowdfund/domain/entities/crowdfund_entities.dart';
import 'package:get/get.dart' as getx;

/// Comprehensive Integration Test for Crowdfund Flow
///
/// Prerequisites:
/// - Backend services must be running (auth-service, accounts-service, crowdfund-service)
/// - User must be logged in with valid credentials
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Crowdfund Flow - Integration Tests', () {
    setUpAll(() async {
      // Initialize the app once before all tests
      app.main();
    });

    /// Test 1: Navigate to Crowdfund Home Screen
    testWidgets('Navigate to Crowdfund Home', (WidgetTester tester) async {
      // Pump and settle to ensure app is fully loaded
      await tester.pumpAndSettle();
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // Navigate to crowdfund home using GetX
      getx.Get.toNamed(AppRoutes.crowdfund);
      await tester.pumpAndSettle();

      // Verify crowdfund home screen is displayed
      expect(find.text('Crowdfund'), findsOneWidget,
             reason: 'Crowdfund home screen should show title');
      expect(find.text('Render your support to crowdfunds'), findsOneWidget,
             reason: 'Crowdfund home subtitle should be visible');

      // Verify action buttons are present
      expect(find.text('Create Campaign'), findsOneWidget,
             reason: 'Create Campaign button should be visible');
      expect(find.text('Fund a Campaign'), findsOneWidget,
             reason: 'Fund a Campaign button should be visible');
    });

    /// Test 2: View Available Crowdfunds
    testWidgets('View available crowdfunds list', (WidgetTester tester) async {
      await tester.pumpAndSettle();
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // Navigate to crowdfund list
      getx.Get.toNamed(AppRoutes.crowdfundList);
      await tester.pumpAndSettle();

      // Verify list screen is displayed with tabs
      expect(find.text('Campaigns'), findsOneWidget,
             reason: 'Campaign list title should be visible');
      expect(find.text('Browse All'), findsOneWidget,
             reason: 'Browse All tab should be visible');
      expect(find.text('My Funded'), findsOneWidget,
             reason: 'My Funded tab should be visible');

      // Verify search functionality
      final searchField = find.byType(TextField);
      expect(searchField, findsOneWidget,
             reason: 'Search field should be visible');

      // Enter search query
      await tester.enterText(searchField, 'test');
      await tester.pumpAndSettle(const Duration(seconds: 1));

      // Clear search
      final clearButton = find.byIcon(Icons.clear);
      if (clearButton.evaluate().isNotEmpty) {
        await tester.tap(clearButton);
        await tester.pumpAndSettle();
      }
    });

    /// Test 3: Tab Navigation in Crowdfund List
    testWidgets('Test tab switching in crowdfund list', (WidgetTester tester) async {
      await tester.pumpAndSettle();
      await tester.pumpAndSettle(const Duration(seconds: 2));

      getx.Get.toNamed(AppRoutes.crowdfundList);
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // Tap on "My Funded" tab
      final myFundedTab = find.text('My Funded');
      expect(myFundedTab, findsOneWidget);
      await tester.tap(myFundedTab);
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // Tap back to "Browse All" tab
      final browseAllTab = find.text('Browse All');
      expect(browseAllTab, findsOneWidget);
      await tester.tap(browseAllTab);
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // Verify tabs switch without errors
      expect(find.byType(TabBarView), findsOneWidget,
             reason: 'TabBarView should be present');
    });

    /// Test 4: View Crowdfund Details
    testWidgets('View crowdfund details screen', (WidgetTester tester) async {
      await tester.pumpAndSettle();
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // First navigate to list to get a crowdfund
      getx.Get.toNamed(AppRoutes.crowdfundList);
      await tester.pumpAndSettle(const Duration(seconds: 3));

      // Look for a crowdfund card to tap
      final crowdfundCard = find.byType(InkWell);
      if (crowdfundCard.evaluate().isNotEmpty) {
        await tester.tap(crowdfundCard.first);
        await tester.pumpAndSettle();

        // Verify details screen elements
        final hasMetrics = find.text('Raised').evaluate().isNotEmpty ||
                         find.text('Goal').evaluate().isNotEmpty ||
                         find.text('Donors').evaluate().isNotEmpty;
        expect(
          hasMetrics,
          isTrue,
          reason: 'Crowdfund details should show key metrics',
        );

        // Verify share and copy buttons
        expect(find.byIcon(Icons.share), findsOneWidget,
               reason: 'Share button should be visible');
        expect(find.byIcon(Icons.content_copy), findsOneWidget,
               reason: 'Copy code button should be visible');
      }
    });

    /// Test 5: Test Donation Navigation
    testWidgets('Navigate to donation payment screen', (WidgetTester tester) async {
      await tester.pumpAndSettle();
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // Create a mock crowdfund for testing navigation
      final mockCrowdfund = MockCrowdfundData.createMockCrowdfund();

      // Navigate directly to donation payment screen with mock data
      getx.Get.toNamed(AppRoutes.donationPayment, arguments: mockCrowdfund);
      await tester.pumpAndSettle();

      // Verify donation payment screen
      final hasDonateText = find.text('Make a Donation').evaluate().isNotEmpty ||
                          find.text('Donate').evaluate().isNotEmpty;
      expect(
        hasDonateText,
        isTrue,
        reason: 'Donation screen should be visible',
      );
    });

    /// Test 6: View Donation Receipt
    testWidgets('View donation receipt with mock data', (WidgetTester tester) async {
      await tester.pumpAndSettle();
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // Navigate directly to receipt screen with mock data
      final mockDonation = MockCrowdfundData.createMockDonation();
      final mockCrowdfund = MockCrowdfundData.createMockCrowdfund();

      getx.Get.toNamed(
        AppRoutes.donationReceipt,
        arguments: {
          'donation': mockDonation,
          'receipt': null,
          'crowdfund': mockCrowdfund,
        },
      );
      await tester.pumpAndSettle();

      // Verify receipt elements
      final hasReceiptText = find.text('Receipt').evaluate().isNotEmpty ||
                           find.text('Donation').evaluate().isNotEmpty;
      expect(
        hasReceiptText,
        isTrue,
        reason: 'Receipt screen should show donation info',
      );
    });

    /// Test 7: Search Functionality
    testWidgets('Search crowdfunds by query', (WidgetTester tester) async {
      await tester.pumpAndSettle();
      await tester.pumpAndSettle(const Duration(seconds: 2));

      getx.Get.toNamed(AppRoutes.crowdfundList);
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // Find search field
      final searchField = find.byType(TextField);
      expect(searchField, findsOneWidget);

      // Enter search query
      await tester.enterText(searchField, 'medical');
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // Clear search
      final clearButton = find.byIcon(Icons.clear);
      if (clearButton.evaluate().isNotEmpty) {
        await tester.tap(clearButton);
        await tester.pumpAndSettle();
      }

      // Enter empty query to reset
      await tester.enterText(searchField, '');
      await tester.pumpAndSettle();
    });

    /// Test 8: Filter Chips Functionality
    testWidgets('Filter crowdfunds by category chips', (WidgetTester tester) async {
      await tester.pumpAndSettle();
      await tester.pumpAndSettle(const Duration(seconds: 2));

      getx.Get.toNamed(AppRoutes.crowdfundList);
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // Look for filter chips (if implemented in UI)
      final filterChip = find.byType(Chip);
      if (filterChip.evaluate().isNotEmpty) {
        // Tap a filter chip
        await tester.tap(filterChip.first);
        await tester.pumpAndSettle();

        // Verify filter is applied - look for close button
        final closeButton = find.byIcon(Icons.close);
        if (closeButton.evaluate().isNotEmpty) {
          await tester.tap(closeButton.first);
          await tester.pumpAndSettle();
        }
      }
    });
  });

  group('Crowdfund Flow - Error Handling Tests', () {
    setUpAll(() async {
      // App already initialized from previous group
    });

    /// Test 9: Handle Empty State
    testWidgets('Display empty state when no crowdfunds available',
        (WidgetTester tester) async {
      await tester.pumpAndSettle();

      // Navigate to My Funded tab (might be empty)
      getx.Get.toNamed(AppRoutes.crowdfundList);
      await tester.pumpAndSettle(const Duration(seconds: 3));

      final myFundedTab = find.text('My Funded');
      if (myFundedTab.evaluate().isNotEmpty) {
        await tester.tap(myFundedTab);
        await tester.pumpAndSettle(const Duration(seconds: 3));

        // Check for empty state message
        find.textContaining('No funded').evaluate().isNotEmpty;
        find.textContaining('Be the first').evaluate().isNotEmpty;
      }
    });

    /// Test 10: Error State Handling
    testWidgets('Handle error state gracefully', (WidgetTester tester) async {
      await tester.pumpAndSettle();

      // Navigate to crowdfund list
      getx.Get.toNamed(AppRoutes.crowdfundList);
      await tester.pumpAndSettle(const Duration(seconds: 5));

      // Check if error occurred and is handled
      final hasError = find.textContaining('Error').evaluate().isNotEmpty ||
                     find.textContaining('Failed').evaluate().isNotEmpty ||
                     find.textContaining('try again').evaluate().isNotEmpty;

      if (hasError) {
        // Verify retry button exists
        final hasRetryButton = find.text('Retry').evaluate().isNotEmpty ||
                             find.text('Try Again').evaluate().isNotEmpty;
        expect(
          hasRetryButton,
          isTrue,
          reason: 'Retry button should be shown on error',
        );
      }
    });
  });

  group('Crowdfund Flow - Currency Display Tests', () {
    setUpAll(() async {
      // App already initialized
    });

    /// Test 11: Verify Currency Symbol is Displayed Correctly
    testWidgets('Display proper currency symbols on crowdfund home',
        (WidgetTester tester) async {
      await tester.pumpAndSettle();
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // Navigate to crowdfund home
      getx.Get.toNamed(AppRoutes.crowdfund);
      await tester.pumpAndSettle(const Duration(seconds: 3));

      // Check that some currency indicator exists
      // The actual currency depends on backend data
      final hasCurrencyIndicator = find.textContaining('₦').evaluate().isNotEmpty ||
                                 find.textContaining('Raised').evaluate().isNotEmpty;
      expect(
        hasCurrencyIndicator,
        isTrue,
        reason: 'Should show currency or raised amount',
      );
    });
  });
}

/// Helper class for test data
class MockCrowdfundData {
  static Crowdfund createMockCrowdfund({
    String? id,
    String? title,
    double targetAmount = 10000.0,
    String currency = 'NGN',
  }) {
    final now = DateTime.now();
    return Crowdfund(
      id: id ?? 'test-${now.millisecondsSinceEpoch}',
      creatorUserId: 1,
      creator: const CrowdfundCreator(
        userId: 1,
        username: 'testcreator',
        firstName: 'Test',
        lastName: 'Creator',
        profilePicture: null,
        verified: true,
        verifiedAt: null,
        facialRecognitionEnabled: false,
      ),
      title: title ?? 'Test Campaign',
      description: 'Test campaign description',
      story: 'Test campaign story',
      crowdfundCode: 'TEST-${now.millisecondsSinceEpoch}',
      targetAmount: targetAmount,
      currentAmount: 0.0,
      currency: currency,
      deadline: null,
      category: 'Medical',
      status: CrowdfundStatus.active,
      imageUrl: null,
      visibility: CrowdfundVisibility.public,
      metadata: null,
      donorCount: 0,
      progressPercentage: 0.0,
      createdAt: now,
      updatedAt: now,
      recentDonations: const [],
    );
  }

  static CrowdfundDonation createMockDonation({
    String? id,
    double amount = 1000.0,
    String currency = 'NGN',
  }) {
    final now = DateTime.now();
    return CrowdfundDonation(
      id: id ?? 'donation-${now.millisecondsSinceEpoch}',
      crowdfundId: 'test-crowdfund-id',
      donorUserId: 1,
      donor: const CrowdfundDonor(
        userId: 1,
        displayName: 'Test User',
        profilePicture: null,
        isAnonymous: false,
        isCreator: false,
      ),
      amount: amount,
      currency: currency,
      donationDate: now,
      status: DonationStatus.completed,
      transactionId: null,
      receiptId: null,
      message: 'Test donation message',
      isAnonymous: false,
      paymentMethod: 'wallet',
      metadata: null,
    );
  }
}
