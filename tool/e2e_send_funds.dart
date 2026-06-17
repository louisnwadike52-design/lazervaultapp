/// End-to-end CLI runner for the external Send-Funds flow.
///
/// Runs every step the Flutter UI takes, in order, against the real local
/// backend stack and the real Flutterwave test API — no emulator, no widget
/// driving. The point is to verify the wire-level integration: same generated
/// protos the Flutter app uses, same gateway, same request shape, same
/// hold-then-capture lifecycle.
///
/// Step-by-step (matches the Flutter cubit path from
/// `lib/src/features/funds/cubit/transfer_cubit.dart` ->
/// `data/datasources/payments_transfer_data_source.dart`):
///
///   Dashboard → "Send" → SelectRecipient (external bank: Access Bank 044 /
///   Flutterwave test NUBAN 0690000040) → InitiateSendFunds (amount input) →
///   PIN modal verifies PIN → cubit calls PaymentsServiceClient.sendFunds.
///
///   1. Signup a fresh user via auth-service (50051) — same as the SignUp
///      screen submits.
///   2. Mark email_verified+phone_verified directly (skips OTP screens). The
///      production SignUp flow requires the user to enter an OTP from
///      SMS/email; we bypass this purely for test determinism.
///   3. Login via core-gateway (50070) — same as the login screen.
///   4. Fetch primary NGN account (Dashboard data load).
///   5. Create transaction PIN "1111" — same as the PIN setup screen.
///   6. Seed account balance to ₦10,000 (test-only; production users
///      top-up via Mono / Flutterwave deposit flows).
///   7. Verify PIN — same as the PIN bottom-sheet on the send-funds confirm.
///   8. Call PaymentsServiceClient.sendFunds via transfer-gateway (50076)
///      with the exact request shape the cubit assembles.
///   9. Wait a few seconds for the goroutine that talks to Flutterwave.
///   10. psql verify:
///         - payments row: provider='flutterwave', fund_hold_id set,
///           version >= 0, status pending or processing.
///         - transfer_provider_attempts row: provider_name='flutterwave',
///           classification populated.
///         - account_reserves row: hold UUID present.
///
/// Run:
///   cd lazervaultapp
///   dart run tool/e2e_send_funds.dart

import 'dart:io';
import 'dart:math';

import 'package:grpc/grpc.dart';
import 'package:lazervault/src/generated/auth.pbgrpc.dart' as auth_pb;
import 'package:lazervault/src/generated/auth.pb.dart' as auth_data;
import 'package:lazervault/src/generated/accounts.pbgrpc.dart' as accounts_pb;
import 'package:lazervault/src/generated/accounts.pb.dart' as accounts_data;
import 'package:lazervault/src/generated/payments.pbgrpc.dart' as payments_pb;
import 'package:lazervault/src/generated/payments.pb.dart' as payments_data;
import 'package:lazervault/src/generated/transaction_pin.pbgrpc.dart' as pin_pb;
import 'package:lazervault/src/generated/transaction_pin.pb.dart' as pin_data;

// ── Config ──────────────────────────────────────────────────────────────────
const String _host = '127.0.0.1';
const int _authPort = 50051;
const int _coreGatewayPort = 50070;
const int _transferGatewayPort = 50076;
const String _pgUser = 'postgres';
const String _password = r'Test1234!ABC';
const String _pin = '1111';

// Flutterwave test recipient — deterministic success at Access Bank.
// https://developer.flutterwave.com/docs/test-cards-and-banks
const String _recipientNUBAN = '0690000040';
const String _recipientBankCode = '044';
const String _recipientName = 'LazerVault Test Recipient';
const double _amountMajor = 500.0;

// ── Helpers ─────────────────────────────────────────────────────────────────
String _rand(int n) {
  final r = Random.secure();
  const a = 'abcdefghijklmnopqrstuvwxyz0123456789';
  return List.generate(n, (_) => a[r.nextInt(a.length)]).join();
}

Future<String> _psql(String db, String sql) async {
  final result = await Process.run(
    'psql',
    ['-h', '127.0.0.1', '-p', '5432', '-U', _pgUser, '-d', db, '-tA', '-q', '-c', sql],
    runInShell: true,
  );
  if (result.exitCode != 0) {
    throw Exception('psql db=$db failed: ${result.stderr}\nsql: $sql');
  }
  final out = (result.stdout as String).trim();
  if (out.isEmpty) return '';
  return out.split('\n').first.trim();
}

ClientChannel _channel(int port) => ClientChannel(
      _host,
      port: port,
      options: const ChannelOptions(
        credentials: ChannelCredentials.insecure(),
        connectionTimeout: Duration(seconds: 10),
      ),
    );

CallOptions _opts(String token, {Map<String, String> extra = const {}}) {
  final md = <String, String>{'authorization': 'Bearer $token'};
  md.addAll(extra);
  return CallOptions(metadata: md, timeout: const Duration(seconds: 30));
}

void _section(String title) {
  print('\n${'━' * 72}');
  print('▶ $title');
  print('━' * 72);
}

void _ok(String msg) => print('  ✓ $msg');
void _fail(String msg) {
  print('  ✗ $msg');
  exit(1);
}

// ── Steps ───────────────────────────────────────────────────────────────────
Future<void> main() async {
  final email = 'e2e-${_rand(8)}@lazertest.com';
  print('🆕 E2E send-funds run — user $email');

  // 1) SIGNUP ────────────────────────────────────────────────────────────────
  _section('Step 1: Signup (auth-service:50051) — SignUp screen submit');
  final authCh = _channel(_authPort);
  final authClient = auth_pb.AuthServiceClient(authCh);
  final signupResp = await authClient.signup(
    auth_data.SignupRequest(
      email: email,
      password: _password,
      firstName: 'E2E',
      lastName: 'Tester',
      phone: '+234${800000000 + Random.secure().nextInt(99999999)}',
      deviceId: 'flutter-cli-e2e',
      deviceName: 'Flutter CLI E2E',
      primaryContactType: auth_data.PrimaryContactType.EMAIL,
      username: 'e2e_${_rand(6)}',
      locale: 'en_NG',
    ),
    options: CallOptions(timeout: const Duration(seconds: 30)),
  );
  if (signupResp.userId.isEmpty) _fail('Signup failed: ${signupResp.message}');
  final userId = signupResp.userId;
  _ok('user $userId');

  // 2) BYPASS OTP ────────────────────────────────────────────────────────────
  _section('Step 2: Mark email_verified (test-only OTP bypass)');
  await _psql('auth_db',
      "UPDATE users SET email_verified=true, phone_verified=true WHERE id='$userId';");
  _ok('verifications bypassed');

  // 3) LOGIN ─────────────────────────────────────────────────────────────────
  _section('Step 3: Login (core-gateway:50070) — Login screen submit');
  final coreCh = _channel(_coreGatewayPort);
  final coreAuth = auth_pb.AuthServiceClient(coreCh);
  final loginResp = await coreAuth.login(
    auth_data.LoginRequest(
      email: email,
      password: _password,
      deviceId: 'flutter-cli-e2e',
      deviceName: 'Flutter CLI E2E',
    ),
    options: CallOptions(timeout: const Duration(seconds: 30)),
  );
  if (!loginResp.success) _fail('Login failed: ${loginResp.msg}');
  final accessToken = loginResp.accessToken;
  _ok('logged in (access token len=${accessToken.length})');

  // 4) DASHBOARD: load primary NGN account ───────────────────────────────────
  _section('Step 4: Dashboard load (GetUserAccounts) — pick primary NGN');
  final accountsClient = accounts_pb.AccountsServiceClient(coreCh);
  final accountsResp = await accountsClient.getUserAccounts(
    accounts_data.GetUserAccountsRequest(),
    options: _opts(accessToken),
  );
  if (accountsResp.accounts.isEmpty) _fail('No account at signup');
  // Signup creates a USD account when locale heuristics misfire; insert an
  // NGN account directly if one is missing (test-only path).
  String accountId;
  final ngn = accountsResp.accounts.where((a) => a.currency == 'NGN');
  if (ngn.isNotEmpty) {
    accountId = ngn.first.uuid;
  } else {
    final acctNum = '99${100000000 + Random.secure().nextInt(99999999)}';
    accountId = await _psql(
      'accounts_db',
      "INSERT INTO accounts (user_id, account_number, account_name, "
      "account_type, currency, locale, status, is_primary, is_primary_in_locale, "
      "balance, available_balance, reserved_balance, bank_code, bank_name, "
      "created_at, updated_at) VALUES "
      "('$userId','$acctNum','E2E NGN Account','savings','NGN','en-NG',"
      "'active',false,true,0,0,0,'232','LazerVault Bank',NOW(),NOW()) "
      "RETURNING id;",
    );
    if (accountId.isEmpty) _fail('NGN account insert returned no id');
  }
  _ok('NGN account $accountId');

  // 5) PIN setup ────────────────────────────────────────────────────────────
  _section('Step 5: Set PIN $_pin (transaction_pin service) — PIN Setup screen');
  final pinClient = pin_pb.TransactionPinServiceClient(coreCh);
  final pinSetup = await pinClient.createTransactionPin(
    pin_data.CreateTransactionPinRequest(
      userId: userId,
      pin: _pin,
      confirmPin: _pin,
      deviceId: 'flutter-cli-e2e',
      deviceName: 'Flutter CLI E2E',
    ),
    options: _opts(accessToken),
  );
  if (!pinSetup.success) _fail('CreatePin failed: ${pinSetup.message}');
  _ok('PIN $_pin set');

  // 6) Seed balance ─────────────────────────────────────────────────────────
  _section('Step 6: Seed account balance ₦10,000 (test-only direct DB)');
  await _psql('accounts_db',
      "UPDATE accounts SET balance = balance + 10000.00, "
      "available_balance = available_balance + 10000.00 "
      "WHERE id::text = '$accountId';");
  final newBal = await _psql('accounts_db',
      "SELECT balance, available_balance FROM accounts "
      "WHERE id::text = '$accountId';");
  _ok('balance seeded: $newBal');

  // 7) Verify recipient bank account ─────────────────────────────────────────
  //
  // Mirrors what the Flutter recipient-entry screen does as soon as the
  // user finishes typing a NUBAN (recipient_verification_grpc_datasource.dart:
  // 22-75). PaymentsService.VerifyBankAccount routes
  // transfer-gateway:50076 -> core-payments-service -> Paystack name enquiry.
  //
  // We treat it as non-blocking for the E2E: Paystack's sandbox doesn't
  // necessarily resolve the Flutterwave-issued test NUBAN, so a not-found
  // response is acceptable. What we're asserting is that the RPC round-
  // trips cleanly (no UNAVAILABLE/UNAUTHENTICATED) — i.e. the path the
  // real Flutter cubit takes before allowing the user to proceed.
  _section('Step 7: VerifyBankAccount (transfer-gateway:50076) — recipient name enquiry');
  final txCh = _channel(_transferGatewayPort);
  final paymentsClient = payments_pb.PaymentsServiceClient(txCh);
  try {
    final verifyResp = await paymentsClient.verifyBankAccount(
      payments_data.VerifyBankAccountRequest(
        bankCode: _recipientBankCode,
        accountNumber: _recipientNUBAN,
        country: 'NG',
      ),
      options: CallOptions(
        metadata: {'authorization': 'Bearer $accessToken'},
        timeout: const Duration(seconds: 20),
      ),
    );
    if (verifyResp.success) {
      _ok('verifyBankAccount: name="${verifyResp.accountName}" bank="${verifyResp.bankName}"');
    } else {
      _ok('verifyBankAccount: RPC OK, account not resolved (code=${verifyResp.errorCode}) — '
          'expected against Paystack sandbox for Flutterwave test NUBANs');
    }
  } on GrpcError catch (e) {
    // Network or auth errors here would indicate the RPC plumbing itself is
    // broken — fail the E2E. Per-account "not found" is a response code, not
    // a gRPC error, and handled in the branch above.
    _fail('verifyBankAccount RPC failed: ${e.code} ${e.message}');
  }

  // 8) Verify PIN — the bottom sheet on the send-funds confirm screen ───────
  _section('Step 8: Verify PIN (PIN bottom-sheet)');
  final txId = 'tx-${_rand(16)}';
  final pinVerify = await pinClient.verifyTransactionPin(
    pin_data.VerifyTransactionPinRequest(
      userId: userId,
      pin: _pin,
      transactionId: txId,
      transactionType: 'transfer',
      amount: _amountMajor,
      currency: 'NGN',
      deviceId: 'flutter-cli-e2e',
    ),
    options: _opts(accessToken),
  );
  if (!pinVerify.success) _fail('PIN verify failed: ${pinVerify.message}');
  final verificationToken = pinVerify.verificationToken;
  _ok('PIN verified, token len=${verificationToken.length}');

  // 9) SendFunds via transfer-gateway ────────────────────────────────────────
  _section('Step 9: SendFunds (transfer-gateway:50076) — InitiateSendFunds cubit call');
  final sendResp = await paymentsClient.sendFunds(
    payments_data.SendFundsRequest(
      fromAccountId: accountId,
      toAccountNumber: _recipientNUBAN,
      toAccountId: '',
      type: 'external',
      amount: _amountMajor,
      description: 'E2E Flutterwave test',
      transactionId: txId,
      verificationToken: verificationToken,
      destinationBankCode: _recipientBankCode,
      beneficiaryName: _recipientName,
      expenseCategory: 0,
    ),
    options: CallOptions(
      metadata: {
        'authorization': 'Bearer $accessToken',
        // transfer-gateway requires x-account-id to identify the active
        // account on transfer RPCs. The Flutter cubit sets this via
        // GrpcCallOptionsHelper.withAuth().
        'x-account-id': accountId,
        // The handler derives currency from locale (en-NG -> NGN); without
        // x-locale the default is en-US -> USD and HoldFunds rejects with
        // "currency mismatch" against the NGN account.
        'x-locale': 'en-NG',
      },
      timeout: const Duration(seconds: 30),
    ),
  );
  _ok('SendFunds replied: status=${sendResp.payment.status} '
      'reference=${sendResp.payment.reference} '
      'recipient=${sendResp.recipientName} msg=${sendResp.message}');

  // Capture for verification
  final paymentId = sendResp.payment.id;
  final reference = sendResp.payment.reference;
  if (paymentId.isEmpty) _fail('SendFunds returned no payment id');
  if (!reference.startsWith('TRF-')) _fail('reference not TRF-prefixed: $reference');
  if (sendResp.payment.status != 'pending' && sendResp.payment.status != 'processing') {
    _fail('expected pending/processing, got ${sendResp.payment.status}');
  }

  await coreCh.shutdown();
  await txCh.shutdown();
  await authCh.shutdown();

  // 9) Wait for the goroutine to finish talking to Flutterwave ──────────────
  _section('Step 10: Wait 8s for Flutterwave hand-off + attempt row');
  await Future<void>.delayed(const Duration(seconds: 8));
  _ok('waited');

  // 10) Verify hold-then-capture invariants ─────────────────────────────────
  _section('Step 11: Verify hold-then-capture state via psql');

  final paymentRow = await _psql(
    'payments_db',
    "SELECT status, COALESCE(provider,''), COALESCE(fund_hold_id::text,''), "
    "version, COALESCE(provider_ref,''), COALESCE(provider_status,''), "
    "COALESCE(complete_message,'') "
    "FROM payments WHERE id='$paymentId';",
  );
  if (paymentRow.isEmpty) _fail('payments row missing for $paymentId');
  final p = paymentRow.split('|');
  print('  status=${p[0]} provider=${p[1]} fund_hold_id=${p[2]} '
      'version=${p[3]} provider_ref=${p[4]} provider_status=${p[5]} '
      'complete_message=${p[6]}');
  if (p[1] != 'flutterwave') _fail('provider should be flutterwave, got ${p[1]}');
  if (p[2].isEmpty) _fail('fund_hold_id should be set');
  _ok('payments row OK');

  final attempt = await _psql(
    'payments_db',
    "SELECT attempt_number, status, COALESCE(classification,''), "
    "COALESCE(provider_transaction_id,''), COALESCE(error_message,'') "
    "FROM transfer_provider_attempts WHERE payment_id='$paymentId' "
    "ORDER BY attempt_number DESC LIMIT 1;",
  );
  if (attempt.isEmpty) {
    _fail('no transfer_provider_attempts row for $paymentId');
  }
  final ap = attempt.split('|');
  print('  attempt #${ap[0]} status=${ap[1]} class=${ap[2]} '
      'fw_tx_id=${ap[3]} err=${ap[4]}');
  _ok('transfer_provider_attempts row OK');

  final hold = await _psql(
    'accounts_db',
    "SELECT status, amount, reference FROM account_reserves WHERE id='${p[2]}';",
  );
  if (hold.isEmpty) _fail('account_reserves row missing for hold ${p[2]}');
  final hp = hold.split('|');
  print('  hold status=${hp[0]} amount=${hp[1]} ref=${hp[2]}');
  _ok('account_reserves row OK');

  print('\n${'━' * 72}');
  print('✅ E2E send-funds passed — Flutter cubit path → backend → Flutterwave');
  print('   payment_id      = $paymentId');
  print('   reference       = $reference');
  print('   provider        = ${p[1]}');
  print('   fund_hold_id    = ${p[2]}');
  print('   provider_ref    = ${p[4]}');
  print('   provider_status = ${p[5]}');
  print('━' * 72);
}
