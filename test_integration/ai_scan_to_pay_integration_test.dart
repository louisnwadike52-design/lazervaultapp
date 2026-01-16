import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;

import 'package:lazervaultapp/src/features/ai_scan_to_pay/presentation/view/ai_scan_to_pay_screen.dart';
import 'package:lazervaultapp/src/features/ai_scan_to_pay/presentation/cubit/ai_scan_cubit.dart';
import 'package:lazervaultapp/src/features/ai_scan_to_pay/data/repositories/ai_scan_repository_impl.dart';
import 'package:lazervaultapp/src/features/ai_scan_to_pay/data/datasources/ai_scan_remote_datasource.dart';
import 'package:lazervaultapp/src/features/ai_scan_to_pay/domain/usecases/scan_bank_details_usecase.dart';
import 'package:lazervaultapp/src/features/ai_scan_to_pay/domain/usecases/process_bank_details_payment_usecase.dart';

/// Integration tests for the complete AI Scan to Pay flow.
///
/// These tests verify the integration between:
/// - UI layer (widgets, screens)
/// - State management layer (Cubits)
/// - Domain layer (use cases)
/// - Data layer (repositories, data sources)
///
/// Run with: flutter test integration_test/ai_scan_to_pay_integration_test.dart
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('AI Scan to Pay - Integration Tests', () {
    late http.Client httpClient;
    late AiScanRemoteDataSource remoteDataSource;
    late AiScanRepository repository;
    late ScanBankDetailsUseCase scanUseCase;
    late ProcessBankDetailsPaymentUseCase processPaymentUseCase;
    late AiScanCubit cubit;

    setUp(() {
      httpClient = http.Client();
      remoteDataSource = AiScanRemoteDataSourceImpl(
        httpClient: httpClient,
        baseUrl: 'http://localhost:3011', // Use mock server or test environment
      );
      repository = AiScanRepositoryImpl(remoteDataSource: remoteDataSource);
      scanUseCase = ScanBankDetailsUseCase(repository: repository);
      processPaymentUseCase = ProcessBankDetailsPaymentUseCase(repository: repository);
      cubit = AiScanCubit(
        scanBankDetailsUseCase: scanUseCase,
        processBankDetailsPaymentUseCase: processPaymentUseCase,
      );
    });

    tearDown(() {
      cubit.close();
      httpClient.close();
    });

    testWidgets(
      'Complete scan-to-pay flow: camera → scan → edit → PIN → receipt',
      (WidgetTester tester) async {
        // Build the app with the cubit
        await tester.pumpWidget(
          MaterialApp(
            home: BlocProvider.value(
              value: cubit,
              child: AiScanToPayScreen(),
            ),
          ),
        );

        // Step 1: Initial screen should show camera/upload options
        expect(find.text('Scan Bank Details'), findsOneWidget);
        expect(find.byIcon(Icons.camera_alt), findsOneWidget);

        // Step 2: Simulate camera capture (in real E2E, this would use camera plugin)
        // For integration test, we'll directly call the cubit method
        await tester.runAsync(() async {
          await cubit.processBankDetailsImage('/mock/path/to/check.jpg');
        });
        await tester.pumpAndSettle();

        // Step 3: Verify processing state is shown
        expect(find.textContaining('Extracting'), findsOneWidget);
        await tester.pumpAndSettle(const Duration(seconds: 2));

        // Step 4: Verify bottomsheet appears with extracted details
        expect(find.text('Bank Details'), findsOneWidget);
        expect(find.text('Account Number'), findsOneWidget);

        // Step 5: Enter amount
        final amountField = find.byType(TextFormField).last;
        await tester.enterText(amountField, '150.00');
        await tester.pumpAndSettle();

        // Step 6: Tap "Proceed to Pay"
        await tester.tap(find.text('Proceed to Pay'));
        await tester.pumpAndSettle();

        // Step 7: Verify PIN modal appears
        expect(find.text('Enter Transaction PIN'), findsOneWidget);
        expect(find.byType(PinCodeFields), findsOneWidget);

        // Step 8: Enter PIN
        await tester.enterText(find.byType(PinCodeFields), '1234');
        await tester.pumpAndSettle();

        // Step 9: Submit PIN
        await tester.tap(find.text('Confirm'));
        await tester.pumpAndSettle();

        // Step 10: Verify processing screen
        expect(find.textContaining('Processing'), findsOneWidget);
        await tester.pumpAndSettle(const Duration(seconds: 3));

        // Step 11: Verify receipt screen appears
        expect(find.text('Transfer Successful'), findsOneWidget);
        expect(find.text('150.00'), findsOneWidget);
        expect(find.text('Share Receipt'), findsOneWidget);
        expect(find.text('Done'), findsOneWidget);
      },
    );

    testWidgets(
      'Handles low confidence OCR results with user warning',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: BlocProvider.value(
              value: cubit,
              child: AiScanToPayScreen(),
            ),
          ),
        );

        // Simulate scanning blurry image
        await tester.runAsync(() async {
          await cubit.processBankDetailsImage('/mock/path/to/blurry.jpg');
        });
        await tester.pumpAndSettle();

        // Verify low confidence warning is shown
        expect(find.textContaining('may be incorrect'), findsOneWidget);
        expect(find.text('Medium'), findsOneWidget); // Confidence badge

        // Verify user can still proceed but with warning
        expect(find.text('Proceed to Pay'), findsOneWidget);

        // Verify "Retake Photo" option is available
        expect(find.text('Retake Photo'), findsOneWidget);
      },
    );

    testWidgets(
      'Handles insufficient funds error gracefully',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: BlocProvider.value(
              value: cubit,
              child: AiScanToPayScreen(),
            ),
          ),
        );

        // Process image successfully
        await tester.runAsync(() async {
          await cubit.processBankDetailsImage('/mock/path/to/check.jpg');
        });
        await tester.pumpAndSettle();

        // Enter amount exceeding balance
        final amountField = find.byType(TextFormField).last;
        await tester.enterText(amountField, '10000.00');
        await tester.pumpAndSettle();

        // Tap proceed
        await tester.tap(find.text('Proceed to Pay'));
        await tester.pumpAndSettle();

        // Verify validation error is shown
        expect(find.textContaining('Insufficient balance'), findsOneWidget);
      },
    );

    testWidgets(
      'Handles network timeout with retry option',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: BlocProvider.value(
              value: cubit,
              child: AiScanToPayScreen(),
            ),
          ),
        );

        // Simulate network timeout during scan
        await tester.runAsync(() async {
          // This would trigger a network timeout in real scenario
          await cubit.processBankDetailsImage('/mock/path/to/check.jpg');
        });
        await tester.pumpAndSettle();

        // Verify error dialog is shown
        expect(find.text('Network Error'), findsOneWidget);
        expect(find.textContaining('timed out'), findsOneWidget);

        // Verify retry button is available
        expect(find.text('Retry'), findsOneWidget);

        // Tap retry
        await tester.tap(find.text('Retry'));
        await tester.pumpAndSettle();

        // Verify processing restarts
        expect(find.textContaining('Extracting'), findsOneWidget);
      },
    );

    testWidgets(
      'External bank transfer shows processing status',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: BlocProvider.value(
              value: cubit,
              child: AiScanToPayScreen(),
            ),
          ),
        );

        // Scan external bank details (Access Bank Nigeria)
        await tester.runAsync(() async {
          await cubit.processBankDetailsImage('/mock/path/to/external_bank.jpg');
        });
        await tester.pumpAndSettle();

        // Verify "External Bank" badge
        expect(find.text('External Bank'), findsOneWidget);

        // Enter amount and proceed
        final amountField = find.byType(TextFormField).last;
        await tester.enterText(amountField, '50000');
        await tester.pumpAndSettle();

        await tester.tap(find.text('Proceed to Pay'));
        await tester.pumpAndSettle();

        // Enter PIN
        await tester.enterText(find.byType(PinCodeFields), '1234');
        await tester.tap(find.text('Confirm'));
        await tester.pumpAndSettle(const Duration(seconds: 3));

        // Verify "Transfer Initiated" message for external transfer
        expect(find.text('Transfer Initiated'), findsOneWidget);
        expect(find.textContaining('You\'ll be notified'), findsOneWidget);
      },
    );

    testWidgets(
      'Rate limit error shows appropriate message',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: BlocProvider.value(
              value: cubit,
              child: AiScanToPayScreen(),
            ),
          ),
        );

        // Simulate multiple rapid scans to trigger rate limit
        for (int i = 0; i < 12; i++) {
          await tester.runAsync(() async {
            await cubit.processBankDetailsImage('/mock/path/to/check.jpg');
          });
          await tester.pump(const Duration(milliseconds: 100));
        }

        await tester.pumpAndSettle();

        // Verify rate limit error
        expect(find.textContaining('Too many'), findsOneWidget);
        expect(find.textContaining('Try again'), findsOneWidget);
      },
    );

    testWidgets(
      'Invalid PIN shows error and allows retry',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: BlocProvider.value(
              value: cubit,
              child: AiScanToPayScreen(),
            ),
          ),
        );

        // Complete scan flow
        await tester.runAsync(() async {
          await cubit.processBankDetailsImage('/mock/path/to/check.jpg');
        });
        await tester.pumpAndSettle();

        final amountField = find.byType(TextFormField).last;
        await tester.enterText(amountField, '100.00');
        await tester.tap(find.text('Proceed to Pay'));
        await tester.pumpAndSettle();

        // Enter wrong PIN
        await tester.enterText(find.byType(PinCodeFields), '0000');
        await tester.tap(find.text('Confirm'));
        await tester.pumpAndSettle();

        // Verify error message
        expect(find.textContaining('Invalid PIN'), findsOneWidget);

        // Verify PIN field is still shown for retry
        expect(find.byType(PinCodeFields), findsOneWidget);
      },
    );

    testWidgets(
      'Account name verification badge shows correctly',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: BlocProvider.value(
              value: cubit,
              child: AiScanToPayScreen(),
            ),
          ),
        );

        await tester.runAsync(() async {
          await cubit.processBankDetailsImage('/mock/path/to/check.jpg');
        });
        await tester.pumpAndSettle();

        // Verify "Verified" badge appears next to account name
        // (Account name was validated via Paystack API)
        expect(find.text('Verified'), findsOneWidget);
        expect(find.byIcon(Icons.verified), findsOneWidget);

        // Verify account name field is read-only
        final accountNameFields = find.byType(TextFormField).evaluate().toList();
        final accountNameField = accountNameFields.firstWhere(
          (element) => (element.widget as TextFormField).decoration?.labelText == 'Account Name',
        );
        expect((accountNameField.widget as TextFormField).readOnly, isTrue);
      },
    );

    testWidgets(
      'Receipt screen allows sharing and navigation',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: BlocProvider.value(
              value: cubit,
              child: AiScanToPayScreen(),
            ),
          ),
        );

        // Complete full payment flow
        await tester.runAsync(() async {
          await cubit.processBankDetailsImage('/mock/path/to/check.jpg');
        });
        await tester.pumpAndSettle();

        final amountField = find.byType(TextFormField).last;
        await tester.enterText(amountField, '100.00');
        await tester.tap(find.text('Proceed to Pay'));
        await tester.pumpAndSettle();

        await tester.enterText(find.byType(PinCodeFields), '1234');
        await tester.tap(find.text('Confirm'));
        await tester.pumpAndSettle(const Duration(seconds: 3));

        // Verify receipt screen
        expect(find.text('Transfer Successful'), findsOneWidget);

        // Test share button
        expect(find.text('Share Receipt'), findsOneWidget);
        await tester.tap(find.text('Share Receipt'));
        await tester.pumpAndSettle();

        // Verify share dialog/bottom sheet appears
        // (In real app, this would trigger system share sheet)

        // Test "Done" button navigation
        await tester.tap(find.text('Done'));
        await tester.pumpAndSettle();

        // Verify navigation to dashboard
        expect(find.byType(AiScanToPayScreen), findsNothing);
      },
    );

    testWidgets(
      'Multiple account numbers detected shows selection UI',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: BlocProvider.value(
              value: cubit,
              child: AiScanToPayScreen(),
            ),
          ),
        );

        // Scan image with multiple account numbers
        await tester.runAsync(() async {
          await cubit.processBankDetailsImage('/mock/path/to/multi_account.jpg');
        });
        await tester.pumpAndSettle();

        // Verify account selection dialog
        expect(find.text('Multiple Accounts Detected'), findsOneWidget);
        expect(find.text('Please select the correct account'), findsOneWidget);

        // Verify radio buttons or list items for each account
        expect(find.byType(RadioListTile), findsNWidgets(2));
      },
    );
  });

  group('AI Scan to Pay - Performance Tests', () {
    testWidgets(
      'Image processing completes within 5 seconds',
      (WidgetTester tester) async {
        final httpClient = http.Client();
        final remoteDataSource = AiScanRemoteDataSourceImpl(
          httpClient: httpClient,
          baseUrl: 'http://localhost:3011',
        );
        final repository = AiScanRepositoryImpl(remoteDataSource: remoteDataSource);
        final scanUseCase = ScanBankDetailsUseCase(repository: repository);
        final cubit = AiScanCubit(
          scanBankDetailsUseCase: scanUseCase,
          processBankDetailsPaymentUseCase: ProcessBankDetailsPaymentUseCase(repository: repository),
        );

        await tester.pumpWidget(
          MaterialApp(
            home: BlocProvider.value(
              value: cubit,
              child: AiScanToPayScreen(),
            ),
          ),
        );

        final stopwatch = Stopwatch()..start();

        await tester.runAsync(() async {
          await cubit.processBankDetailsImage('/mock/path/to/check.jpg');
        });
        await tester.pumpAndSettle();

        stopwatch.stop();

        expect(stopwatch.elapsed.inSeconds, lessThan(5));

        cubit.close();
        httpClient.close();
      },
    );

    testWidgets(
      'Payment processing completes within 10 seconds',
      (WidgetTester tester) async {
        final httpClient = http.Client();
        final remoteDataSource = AiScanRemoteDataSourceImpl(
          httpClient: httpClient,
          baseUrl: 'http://localhost:3011',
        );
        final repository = AiScanRepositoryImpl(remoteDataSource: remoteDataSource);
        final processPaymentUseCase = ProcessBankDetailsPaymentUseCase(repository: repository);

        final stopwatch = Stopwatch()..start();

        await tester.runAsync(() async {
          await processPaymentUseCase(
            bankDetails: BankDetailsModel(
              accountNumber: '0123456789',
              accountName: 'John Doe',
              bankName: 'Chase Bank',
              accountType: 'internal',
              confidenceScore: 0.95,
              fieldConfidence: {},
            ),
            amount: 100.0,
            description: 'Test payment',
            verificationToken: 'test-token',
            transactionId: 'test-txn-123',
          );
        });

        stopwatch.stop();

        expect(stopwatch.elapsed.inSeconds, lessThan(10));

        httpClient.close();
      },
    );
  });
}
