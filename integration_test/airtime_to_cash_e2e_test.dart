/// Airtime-to-Cash E2E Integration Test - VTU Africa & Automation
///
/// Tests the complete end-to-end flow for Airtime-to-Cash conversions
/// through the Flutter app, connecting to REAL backends (NO mocks).
///
/// Prerequisites:
///   1. All backend services running:
///      - auth-service (50051), accounts-service (50052)
///      - utility-payments-service (50055)
///      - core-gateway (50070), commerce-gateway (50071)
///      - admin-gateway (8096)
///   2. Test user with valid credentials and transaction PIN
///   3. VTU Africa and Automation API credentials configured
///
/// Test Coverage:
///   - VTU Africa: Provider select → Phone entry → Service verification →
///                 Transfer confirmation → Pending → Success
///   - Automation: Provider select → Phone + network + amount →
///                 OTP verification → LazerVault txpin bottom sheet →
///                 Pending → Success
///
/// Run:
///   cd lazervaultapp
///   flutter test integration_test/airtime_to_cash_e2e_test.dart

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:lazervault/main.dart' as app;
import 'package:lazervault/core/types/app_routes.dart';
import 'package:get/get.dart';
import 'package:grpc/grpc.dart';
import 'package:lazervault/src/generated/auth.pbgrpc.dart' as auth_pb;
import 'package:lazervault/src/generated/account.pbgrpc.dart' as accounts_pb;
import 'package:lazervault/src/generated/auth.pb.dart' as auth_pb_data;

// =============================================================================
// Test Configuration
// =============================================================================

const String grpcHost = 'localhost';
const int coreGatewayPort = 50070;

// Test credentials
const String defaultTestEmail = 'dash@gmail.com';
const String defaultTestPassword = r'Password1$';
const String defaultTestPin = '1111';

// Test data
const String testPhoneNumber = '08012345678'; // MTN test number
const String testNetwork = 'MTN';
const double testAmount = 500.0; // NGN - minimum for A2C

// =============================================================================
// Test Session & Results
// =============================================================================

class TestSession {
  final String email;
  final String accessToken;
  final String userId;
  final String accountId;
  final double balance;

  TestSession({
    required this.email,
    required this.accessToken,
    required this.userId,
    required this.accountId,
    required this.balance,
  });
}

class TestResults {
  int passed = 0;
  int failed = 0;
  final List<String> errors = [];
  final List<String> warnings = [];

  void record(String name, bool success, [String detail = '']) {
    if (success) {
      passed++;
      print('  ✓ PASS: $name${detail.isNotEmpty ? ' - $detail' : ''}');
    } else {
      failed++;
      errors.add('$name: $detail');
      print('  ✗ FAIL: $name - $detail');
    }
  }

  void warn(String name, String reason) {
    warnings.add('$name: $reason');
    print('  ⚠ WARN: $name - $reason');
  }

  void summary() {
    final total = passed + failed;
    print('\n${'=' * 70}');
    print('RESULTS: $passed/$total passed, $failed failed, ${warnings.length} warnings');
    if (errors.isNotEmpty) {
      print('\nFailures:');
      for (final e in errors) {
        print('  - $e');
      }
    }
    if (warnings.isNotEmpty) {
      print('\nWarnings:');
      for (final w in warnings) {
        print('  - $w');
      }
    }
    print('=' * 70);
  }

  bool get allPassed => failed == 0;
}

// =============================================================================
// gRPC Helpers
// =============================================================================

ClientChannel _createChannel(int port) {
  return ClientChannel(
    grpcHost,
    port: port,
    options: const ChannelOptions(
      credentials: ChannelCredentials.insecure(),
      connectionTimeout: Duration(seconds: 10),
    ),
  );
}

CallOptions _authCallOptions(String token, [String? accountId]) {
  final metadata = <String, String>{
    'authorization': 'Bearer $token',
  };
  if (accountId != null) {
    metadata['x-account-id'] = accountId;
  }
  return CallOptions(
    metadata: metadata,
    timeout: const Duration(seconds: 30),
  );
}

Future<TestSession> loginUser(
  String email,
  String password,
) async {
  final channel = _createChannel(coreGatewayPort);
  final client = auth_pb.AuthServiceClient(channel);

  final request = auth_pb_data.LoginRequest();
  request.email = email;
  request.password = password;

  final response = await client.login(request,
    options: CallOptions(timeout: Duration(seconds: 30))
  );

  if (!response.success) {
    throw Exception('Login failed: ${response.msg}');
  }

  // Get user's primary account
  final accountsChannel = _createChannel(coreGatewayPort);
  final accountsClient = accounts_pb.AccountServiceClient(accountsChannel);

  final accountsRequest = accounts_pb.GetUserAccountsRequest();
  final accountsResponse = await accountsClient.getUserAccounts(accountsRequest,
    options: _authCallOptions(response.accessToken)
  );

  final primaryAccount = accountsResponse.accounts.firstWhere(
    (acc) => acc.isPrimary,
    orElse: () => accountsResponse.accounts.first,
  );

  return TestSession(
    email: email,
    accessToken: response.accessToken,
    userId: response.data.hasUser() ? response.data.user.id : '',
    accountId: primaryAccount.id.toString(),
    balance: primaryAccount.balance.toDouble() / 100, // Convert from kobo
  );
}

// =============================================================================
// Widget Finders
// =============================================================================

final providerSelectFinder = find.byType(AirtimeToCashProviderSelectScreen);
final vtuafricaScreenFinder = find.byType(VtuafricaAirtimeToCashScreen);
final vtuafricaTransferFinder = find.byType(VtuafricaTransferScreen);
final automationScreenFinder = find.byType(AutomationAirtimeToCashScreen);
final txPinSheetFinder = find.byKey(Key('transaction_pin_modal'));
final successScreenFinder = find.byType(AirtimeToCashSuccessScreen);
final pendingScreenFinder = find.byType(AirtimeToCashPendingScreen);

final phoneNumberFieldFinder = find.byKey(Key('phone_number_field'));
final networkDropdownFinder = find.byKey(Key('network_dropdown'));
final amountFieldFinder = find.byKey(Key('amount_field'));
final pinFieldFinder = find.byKey(Key('pin_field'));
final otpFieldFinder = find.byKey(Key('otp_field'));
final continueButtonFinder = find.byKey(Key('continue_button'));
final confirmButtonFinder = find.byKey(Key('confirm_button'));
final providerCardFinder = find.byType(ProviderCard);

// =============================================================================
// Test Helper Functions
// =============================================================================

Future<void> navigateToAirtimeToCash(WidgetTester tester) async {
  // Navigate from home to airtime landing page
  final dashboardFinder = find.text('Dashboard');
  if (tester.any(dashboardFinder)) {
    await tester.tap(dashboardFinder);
    await tester.pumpAndSettle();
  }

  // Find and tap "Sell" or "Airtime" button
  final sellButtonFinder = find.text('Sell');
  final airtimeButtonFinder = find.textContaining('Airtime');

  if (tester.any(sellButtonFinder)) {
    await tester.tap(sellButtonFinder);
  } else if (tester.any(airtimeButtonFinder)) {
    await tester.tap(airtimeButtonFinder);
  }
  await tester.pumpAndSettle();

  // Navigate to Airtime-to-Cash
  final a2cButtonFinder = find.text('Airtime to Cash');
  expect(a2cButtonFinder, findsOneWidget);
  await tester.tap(a2cButtonFinder);
  await tester.pumpAndSettle();

  // Should be on provider selection screen
  expect(providerSelectFinder, findsOneWidget);
}

Future<void> selectProvider(
  WidgetTester tester,
  String providerName, // 'VTU Africa' or 'Automation'
) async {
  final providerCard = find.text(providerName);
  expect(providerCard, findsOneWidget);
  await tester.tap(providerCard);
  await tester.pumpAndSettle();
}

Future<void> enterPhoneNumber(
  WidgetTester tester,
  String phoneNumber,
) async {
  final field = find.byKey(Key('phone_number_field'));
  expect(field, findsOneWidget);
  await tester.enterText(field, phoneNumber);
  await tester.pumpAndSettle();
}

Future<void> selectNetwork(
  WidgetTester tester,
  String network,
) async {
  // Tap network dropdown
  final dropdown = find.byKey(Key('network_dropdown'));
  await tester.tap(dropdown);
  await tester.pumpAndSettle();

  // Tap network option
  final networkOption = find.text(network);
  expect(networkOption, findsOneWidget);
  await tester.tap(networkOption);
  await tester.pumpAndSettle();
}

Future<void> enterAmount(
  WidgetTester tester,
  double amount,
) async {
  final field = find.byKey(Key('amount_field'));
  expect(field, findsOneWidget);
  await tester.enterText(field, amount.toStringAsFixed(0));
  await tester.pumpAndSettle();
}

Future<void> enterPin(
  WidgetTester tester,
  String pin,
) async {
  final field = find.byKey(Key('pin_field'));
  expect(field, findsOneWidget);
  await tester.enterText(field, pin);
  await tester.pumpAndSettle();
}

Future<void> enterOtp(
  WidgetTester tester,
  String otp,
) async {
  final field = find.byKey(Key('otp_field'));
  expect(field, findsOneWidget);
  await tester.enterText(field, otp);
  await tester.pumpAndSettle();
}

Future<void> tapContinue(WidgetTester tester) async {
  final button = find.byKey(Key('continue_button'));
  expect(button, findsOneWidget);
  await tester.tap(button);
  await tester.pumpAndSettle(Duration(seconds: 2));
}

Future<void> tapConfirm(WidgetTester tester) async {
  final button = find.byKey(Key('confirm_button'));
  expect(button, findsOneWidget);
  await tester.tap(button);
  await tester.pumpAndSettle(Duration(seconds: 3));
}

Future<void> waitForSuccess(
  WidgetTester tester, {
  Duration timeout = const Duration(seconds: 30),
}) async {
  final end = DateTime.now().add(timeout);

  while (DateTime.now().isBefore(end)) {
    await tester.pumpAndSettle(Duration(seconds: 2));
    if (tester.any(successScreenFinder)) {
      return;
    }
    // If we're on pending screen, continue waiting
    if (!tester.any(pendingScreenFinder)) {
      throw Exception('Neither success nor pending screen shown');
    }
  }

  throw Exception('Timeout waiting for success screen');
}

// =============================================================================
// Test Cases
// =============================================================================

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Airtime-to-Cash E2E Tests', () {
    late TestSession session;

    setUpAll(() async {
      // Login once for all tests
      session = await loginUser(defaultTestEmail, defaultTestPassword);
      print('\n✓ Logged in as ${session.email}');
      print('  Account ID: ${session.accountId}');
      print('  Balance: ₦${session.balance.toStringAsFixed(2)}');
    });

    testWidgets(
      'VTU Africa: Complete flow from provider selection to success',
      (WidgetTester tester) async {
        final results = TestResults();

        try {
          // Initialize app with test user token
          await tester.pumpWidget(
            GetMaterialApp(
              home: app.AuthCheckScreen(),
            ),
          );
          await tester.pumpAndSettle();

          // Navigate to Airtime-to-Cash
          await navigateToAirtimeToCash(tester);
          results.record('Navigate to A2C', true);

          // Select VTU Africa provider
          await selectProvider(tester, 'VTU Africa');
          results.record('Select VTU Africa', true);
          expect(vtuafricaScreenFinder, findsOneWidget);

          // Enter phone number
          await enterPhoneNumber(tester, testPhoneNumber);
          results.record('Enter phone number', true);

          // Select network
          await selectNetwork(tester, testNetwork);
          results.record('Select network', true);

          // Enter amount
          await enterAmount(tester, testAmount);
          results.record('Enter amount', true);

          // Tap continue to verify service
          await tapContinue(tester);
          results.record('Verify VTU Africa service', tester.any(vtuafricaTransferFinder));

          // Should show transfer screen with destination phone
          expect(vtuafricaTransferFinder, findsOneWidget);

          // Look for destination phone number in the UI
          final destinationPhoneFinder = find.textContaining('080');
          results.record('Destination phone shown', tester.any(destinationPhoneFinder));

          // Tap confirm to submit conversion
          await tapConfirm(tester);
          results.record('Submit conversion', true);

          // Should show pending screen
          expect(pendingScreenFinder, findsOneWidget);
          results.record('Pending screen shown', true);

          // Wait for success (webhook should complete within 30 seconds)
          await waitForSuccess(tester);
          results.record('Conversion successful', true);

        } catch (e, st) {
          results.record('VTU Africa flow', false, '$e\n$st');
        }

        results.summary();
        expect(results.allPassed, true, reason: results.errors.join(', '));
      },
      timeout: const Timeout(Duration(minutes: 2)),
    );

    testWidgets(
      'Automation: Complete flow from provider selection to success',
      (WidgetTester tester) async {
        final results = TestResults();

        try {
          // Initialize app
          await tester.pumpWidget(
            GetMaterialApp(
              home: app.AuthCheckScreen(),
            ),
          );
          await tester.pumpAndSettle();

          // Navigate to Airtime-to-Cash
          await navigateToAirtimeToCash(tester);
          results.record('Navigate to A2C', true);

          // Select Automation provider
          await selectProvider(tester, 'Automation');
          results.record('Select Automation', true);
          expect(automationScreenFinder, findsOneWidget);

          // Enter phone number
          await enterPhoneNumber(tester, testPhoneNumber);
          results.record('Enter phone number', true);

          // Select network
          await selectNetwork(tester, testNetwork);
          results.record('Select network', true);

          // Enter amount (now collected on the main automation screen, not a
          // separate transfer/PIN screen).
          await enterAmount(tester, testAmount);
          results.record('Enter amount', true);

          // Tap continue to request OTP
          await tapContinue(tester);
          results.record('Request OTP', true);

          // Enter OTP (in real test, this would come from SMS)
          await enterOtp(tester, '123456');
          results.record('Enter OTP', true);

          // Verify OTP — on success the LazerVault transaction PIN bottom
          // sheet is opened (no separate SIM-transfer PIN screen any more).
          await tapContinue(tester);
          results.record('Verify OTP → txpin sheet', tester.any(txPinSheetFinder));

          // Enter the LazerVault transaction PIN in the bottom sheet.
          await enterPin(tester, defaultTestPin);
          results.record('Enter LazerVault txpin', true);

          // Should show pending screen
          expect(pendingScreenFinder, findsOneWidget);
          results.record('Pending screen shown', true);

          // Wait for success
          await waitForSuccess(tester);
          results.record('Conversion successful', true);

        } catch (e, st) {
          results.record('Automation flow', false, '$e\n$st');
        }

        results.summary();
        expect(results.allPassed, true, reason: results.errors.join(', '));
      },
      timeout: const Timeout(Duration(minutes: 2)),
    );
  });
}

// =============================================================================
// Type stubs for generated widgets (replace with actual imports)
// =============================================================================

class AirtimeToCashProviderSelectScreen extends StatelessWidget {
  const AirtimeToCashProviderSelectScreen({super.key});
  @override
  Widget build(BuildContext context) => const SizedBox();
}

class VtuafricaAirtimeToCashScreen extends StatelessWidget {
  const VtuafricaAirtimeToCashScreen({super.key});
  @override
  Widget build(BuildContext context) => const SizedBox();
}

class VtuafricaTransferScreen extends StatelessWidget {
  const VtuafricaTransferScreen({super.key});
  @override
  Widget build(BuildContext context) => const SizedBox();
}

class AutomationAirtimeToCashScreen extends StatelessWidget {
  const AutomationAirtimeToCashScreen({super.key});
  @override
  Widget build(BuildContext context) => const SizedBox();
}

class AirtimeToCashSuccessScreen extends StatelessWidget {
  const AirtimeToCashSuccessScreen({super.key});
  @override
  Widget build(BuildContext context) => const SizedBox();
}

class AirtimeToCashPendingScreen extends StatelessWidget {
  const AirtimeToCashPendingScreen({super.key});
  @override
  Widget build(BuildContext context) => const SizedBox();
}

class ProviderCard extends StatelessWidget {
  const ProviderCard({super.key});
  @override
  Widget build(BuildContext context) => const SizedBox();
}
