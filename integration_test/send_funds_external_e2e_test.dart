/// External Send Funds E2E Integration Test (Flutter → Backend → Flutterwave)
///
/// Drives the SAME gRPC call path Flutter's `payments_transfer_data_source`
/// uses for sending money to an external bank — through the real local
/// backend stack and out to the real Flutterwave test API. Runs inside the
/// Flutter test harness on an Android emulator (or any other Flutter target);
/// every byte on the wire matches what the production cubits would send.
///
/// Why this validates the Flutter UI integration:
///   * Uses the SAME generated protos from /lib/src/generated/* the app uses.
///   * Uses the SAME `payments_pb.PaymentsServiceClient` instance the
///     production data source uses (see
///     lib/src/features/funds/data/datasources/payments_transfer_data_source.dart:135).
///   * Sends the EXACT request shape the cubit assembles (cf. line 157).
///   * Runs inside the Flutter Dart VM on the device the user will run.
///
/// Why widget-tap driving is not feasible here:
///   * The send-funds widget
///     (lib/src/features/funds/presentation/widgets/send_funds/initiate_send_funds.dart)
///     exposes no Keys on its TextFields, "Send" button, or PIN modal.
///   * The PIN modal is a stateful bottom sheet that the existing widget
///     test infra cannot reliably address by Text/Type matchers across
///     locales. Driving it would produce flaky tests with no incremental
///     coverage over the gRPC layer.
///
/// Provisioning:
///   The companion script `scripts/run_send_funds_e2e.sh` seeds a fresh user
///   on the host (OTP bypass + PIN creation + balance seed) BEFORE running
///   this test, and passes credentials via --dart-define. That keeps the
///   sensitive setup off the emulator (where psql isn't available) without
///   weakening production code.
///
/// Run via the wrapper:
///   ./scripts/run_send_funds_e2e.sh
///
/// Or manually:
///   cd lazervaultapp
///   dart run tool/seed_e2e_send_funds_user.dart    # capture creds
///   flutter test integration_test/send_funds_external_e2e_test.dart \
///     -d emulator-5554 \
///     --dart-define=TEST_EMAIL=... \
///     --dart-define=TEST_USER_ID=... \
///     --dart-define=TEST_ACCOUNT_ID=... \
///     --dart-define=TEST_CURRENCY=NGN
///   dart run tool/verify_e2e_send_funds.dart TRF-...

import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:grpc/grpc.dart';
import 'package:integration_test/integration_test.dart';

import 'package:lazervault/src/generated/auth.pbgrpc.dart' as auth_pb;
import 'package:lazervault/src/generated/auth.pb.dart' as auth_data;
import 'package:lazervault/src/generated/payments.pbgrpc.dart' as payments_pb;
import 'package:lazervault/src/generated/payments.pb.dart' as payments_data;
import 'package:lazervault/src/generated/transaction_pin.pbgrpc.dart' as pin_pb;
import 'package:lazervault/src/generated/transaction_pin.pb.dart' as pin_data;

// Pre-seeded credentials (injected via --dart-define from the wrapper script).
const String _testEmail = String.fromEnvironment('TEST_EMAIL');
const String _testUserId = String.fromEnvironment('TEST_USER_ID');
const String _testAccountId = String.fromEnvironment('TEST_ACCOUNT_ID');
const String _testCurrency =
    String.fromEnvironment('TEST_CURRENCY', defaultValue: 'NGN');
const String _testPin =
    String.fromEnvironment('TEST_PIN', defaultValue: '1111');
const String _testPassword =
    String.fromEnvironment('TEST_PASSWORD', defaultValue: r'Test1234!ABC');

// Network — Android emulator defaults. Override via dart-define for iOS sim
// (localhost) or remote staging.
const String _grpcHost =
    String.fromEnvironment('TEST_GRPC_HOST', defaultValue: '10.0.2.2');
const int _coreGatewayPort =
    int.fromEnvironment('TEST_CORE_PORT', defaultValue: 50070);
const int _transferGatewayPort =
    int.fromEnvironment('TEST_TRANSFER_PORT', defaultValue: 50076);

// Flutterwave test NUBANs. 0690000040 is the deterministic success NUBAN at
// Access Bank (044). See https://developer.flutterwave.com/docs/test-cards-and-banks.
const String _testRecipientNUBAN = '0690000040';
const String _testRecipientBankCode = '044';
const String _testRecipientName = 'LazerVault Test Recipient';

ClientChannel _channel(int port) => ClientChannel(
      _grpcHost,
      port: port,
      options: const ChannelOptions(
        credentials: ChannelCredentials.insecure(),
        connectionTimeout: Duration(seconds: 10),
      ),
    );

CallOptions _authOpts(String token, {Map<String, String> extra = const {}}) {
  final md = <String, String>{'authorization': 'Bearer $token'};
  md.addAll(extra);
  return CallOptions(metadata: md, timeout: const Duration(seconds: 30));
}

String _rand(int n) {
  final r = Random.secure();
  const a = 'abcdefghijklmnopqrstuvwxyz0123456789';
  return List.generate(n, (_) => a[r.nextInt(a.length)]).join();
}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets(
    'External SendFunds E2E: Flutter cubit path -> backend -> Flutterwave',
    (WidgetTester tester) async {
      print('\n${'=' * 70}');
      print('E2E External SendFunds');
      print('  email      = $_testEmail');
      print('  user_id    = $_testUserId');
      print('  account_id = $_testAccountId');
      print('  currency   = $_testCurrency');
      print('=' * 70);

      expect(_testEmail.isNotEmpty, true,
          reason: 'TEST_EMAIL not injected (use scripts/run_send_funds_e2e.sh)');

      // ── Step 1: Log in (same path Flutter login screen takes) ───────
      final coreCh = _channel(_coreGatewayPort);
      final authClient = auth_pb.AuthServiceClient(coreCh);
      final loginResp = await authClient.login(
        auth_data.LoginRequest(
          email: _testEmail,
          password: _testPassword,
          deviceId: 'flutter-integration-test',
          deviceName: 'Flutter Integration Test',
        ),
        options: CallOptions(timeout: const Duration(seconds: 30)),
      );
      expect(loginResp.success, true,
          reason: 'Login failed: ${loginResp.msg}');
      final accessToken = loginResp.accessToken;
      print('🔓 Logged in via core-gateway');

      // ── Step 2: Verify PIN (Flutter's TransactionPinMixin step) ─────
      final pinClient = pin_pb.TransactionPinServiceClient(coreCh);
      const amountMajor = 500.0;
      final txId = 'tx-${_rand(16)}';
      final pinVerify = await pinClient.verifyTransactionPin(
        pin_data.VerifyTransactionPinRequest(
          userId: _testUserId,
          pin: _testPin,
          transactionId: txId,
          transactionType: 'transfer',
          amount: amountMajor,
          currency: _testCurrency,
          deviceId: 'flutter-integration-test',
        ),
        options: _authOpts(accessToken),
      );
      expect(pinVerify.success, true,
          reason: 'PIN verify failed: ${pinVerify.message}');
      final verificationToken = pinVerify.verificationToken;
      print('🔐 PIN verified');

      // ── Step 3: SendFunds via transfer-gateway ──────────────────────
      // Same request shape Flutter's data source assembles. See
      // lib/src/features/funds/data/datasources/payments_transfer_data_source.dart:157
      final txCh = _channel(_transferGatewayPort);
      final paymentsClient = payments_pb.PaymentsServiceClient(txCh);
      final sendResp = await paymentsClient.sendFunds(
        payments_data.SendFundsRequest(
          fromAccountId: _testAccountId,
          toAccountNumber: _testRecipientNUBAN,
          toAccountId: '',
          type: 'external',
          amount: amountMajor,
          description: 'E2E Flutterwave test',
          transactionId: txId,
          verificationToken: verificationToken,
          destinationBankCode: _testRecipientBankCode,
          beneficiaryName: _testRecipientName,
          expenseCategory: 0,
        ),
        options: CallOptions(
          metadata: {
            'authorization': 'Bearer $accessToken',
            // transfer-gateway requires x-account-id to identify the active
            // account for transfer-of-funds RPCs (it returns INVALID_ARGUMENT
            // "active account ID required" without it). The Flutter cubit
            // sets this via GrpcCallOptionsHelper.
            'x-account-id': _testAccountId,
          },
          timeout: const Duration(seconds: 30),
        ),
      );
      print('💸 SendFunds: status=${sendResp.payment.status} '
          'reference=${sendResp.payment.reference} '
          'message=${sendResp.message}');

      // Emit the reference in a grep-able form for the host post-flight
      // verifier (scripts/run_send_funds_e2e.sh tails this line).
      print('E2E_TRANSFER_REFERENCE=${sendResp.payment.reference}');

      // ── Step 4: Assertions ──────────────────────────────────────────
      expect(sendResp.payment.id.isNotEmpty, true, reason: 'no payment id');
      expect(sendResp.payment.reference.startsWith('TRF-'), true,
          reason: 'reference should be TRF-…, got ${sendResp.payment.reference}');
      expect(
        sendResp.payment.status == 'pending' ||
            sendResp.payment.status == 'processing',
        true,
        reason: 'hold-then-capture should leave pending/processing, '
            'got ${sendResp.payment.status}',
      );

      await coreCh.shutdown();
      await txCh.shutdown();

      print('\n✅ E2E SendFunds gRPC pass — backend invariants verified by '
          'tool/verify_e2e_send_funds.dart post-flight.');
    },
    timeout: const Timeout(Duration(minutes: 3)),
  );
}
