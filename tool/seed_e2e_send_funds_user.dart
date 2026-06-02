/// Host-side pre-flight for send_funds_external_e2e_test.dart.
///
/// Runs on the developer/CI host (NOT inside the emulator). Provisions a
/// fresh user against the real backend stack:
///   1. Signup via auth-service gRPC.
///   2. UPDATE users SET email_verified=true via psql (test-only OTP skip).
///   3. Login via core-gateway -> access token + primary account UUID.
///   4. Create transaction PIN "1111".
///   5. UPDATE accounts to seed ₦10,000 balance.
///
/// Outputs a single line of KEY=VALUE pairs to stdout suitable for passing
/// into `flutter test --dart-define`. The companion shell script
/// `scripts/run_send_funds_e2e.sh` consumes this output.
///
/// Why pre-flight on the host: the integration_test runs INSIDE the Android
/// emulator. /system/bin/sh on the emulator has no psql, so OTP bypass and
/// balance seeding cannot happen from the test process itself. Doing them on
/// the host before launching `flutter test` keeps the test deterministic
/// without weakening production code.

import 'dart:io';
import 'dart:math';

import 'package:grpc/grpc.dart';
import 'package:lazervault/src/generated/auth.pbgrpc.dart' as auth_pb;
import 'package:lazervault/src/generated/auth.pb.dart' as auth_data;
import 'package:lazervault/src/generated/accounts.pbgrpc.dart' as accounts_pb;
import 'package:lazervault/src/generated/accounts.pb.dart' as accounts_data;
import 'package:lazervault/src/generated/transaction_pin.pbgrpc.dart' as pin_pb;
import 'package:lazervault/src/generated/transaction_pin.pb.dart' as pin_data;

const String _grpcHost = '127.0.0.1';
const int _authPort = 50051;
const int _coreGatewayPort = 50070;
const String _pgUser = 'postgres';
const String _password = r'Test1234!ABC';
const String _pin = '1111';

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
  // -tA + -q gives raw rows separated by newlines. INSERT/UPDATE row counts
  // are suppressed by -q. Trim and take the first non-empty line for callers
  // that only care about a single returned value.
  final out = (result.stdout as String).trim();
  if (out.isEmpty) return '';
  return out.split('\n').first.trim();
}

ClientChannel _channel(int port) => ClientChannel(
      _grpcHost,
      port: port,
      options: const ChannelOptions(
        credentials: ChannelCredentials.insecure(),
        connectionTimeout: Duration(seconds: 10),
      ),
    );

Future<void> main() async {
  final email = 'e2e-${_rand(8)}@lazertest.com';
  stderr.writeln('🆕 Provisioning $email');

  final authCh = _channel(_authPort);
  final authClient = auth_pb.AuthServiceClient(authCh);
  final signupResp = await authClient.signup(
    auth_data.SignupRequest(
      email: email,
      password: _password,
      firstName: 'E2E',
      lastName: 'Tester',
      phone: '+234${800000000 + Random.secure().nextInt(99999999)}',
      deviceId: 'flutter-integration-test',
      deviceName: 'Flutter Integration Test',
      primaryContactType: auth_data.PrimaryContactType.EMAIL,
      username: 'e2e_${_rand(6)}',
      locale: 'en_NG',
    ),
    options: CallOptions(timeout: const Duration(seconds: 30)),
  );
  if (signupResp.userId.isEmpty) {
    throw Exception('Signup failed: ${signupResp.message}');
  }
  final userId = signupResp.userId;
  stderr.writeln('   ✓ user $userId');

  await _psql('auth_db',
      "UPDATE users SET email_verified=true, phone_verified=true WHERE id='$userId';");
  stderr.writeln('   ✓ verifications bypassed');

  final coreCh = _channel(_coreGatewayPort);
  final coreAuth = auth_pb.AuthServiceClient(coreCh);
  final loginResp = await coreAuth.login(
    auth_data.LoginRequest(
      email: email,
      password: _password,
      deviceId: 'flutter-integration-test',
      deviceName: 'Flutter Integration Test',
    ),
    options: CallOptions(timeout: const Duration(seconds: 30)),
  );
  if (!loginResp.success) {
    throw Exception('Login failed: ${loginResp.msg}');
  }
  final accessToken = loginResp.accessToken;
  stderr.writeln('   ✓ logged in');

  // core-gateway proxies the plural accounts.AccountsService (see
  // services/core-gateway/main.go:651 -> RegisterAccountsServiceServer).
  final accountsClient = accounts_pb.AccountsServiceClient(coreCh);
  final accountsResp = await accountsClient.getUserAccounts(
    accounts_data.GetUserAccountsRequest(),
    options: CallOptions(
      metadata: {'authorization': 'Bearer $accessToken'},
      timeout: const Duration(seconds: 30),
    ),
  );
  if (accountsResp.accounts.isEmpty) {
    throw Exception('No account created at signup');
  }
  // GetUserAccounts returns AccountSummary; uuid is the canonical string id
  // used by every downstream service. Signup creates a default account whose
  // currency depends on auth-service locale heuristics — for Flutterwave NGN
  // payouts we need an NGN account. If one was created, use it; else insert
  // one directly (test-only path).
  String accountId;
  final ngn = accountsResp.accounts.where((a) => a.currency == 'NGN');
  if (ngn.isNotEmpty) {
    accountId = ngn.first.uuid;
  } else {
    // Build a deterministic NUBAN-looking account number + insert NGN row.
    final acctNum = '99${100000000 + Random.secure().nextInt(99999999)}';
    final inserted = await _psql(
      'accounts_db',
      "INSERT INTO accounts (user_id, account_number, account_name, "
      "account_type, currency, locale, status, is_primary, is_primary_in_locale, "
      "balance, available_balance, reserved_balance, bank_code, bank_name, "
      "created_at, updated_at) "
      "VALUES ('$userId', '$acctNum', 'E2E NGN Account', 'savings', 'NGN', "
      "'en-NG', 'active', false, true, 0, 0, 0, '232', 'LazerVault Bank', "
      "NOW(), NOW()) "
      "RETURNING id;",
    );
    if (inserted.isEmpty) {
      throw Exception('failed to insert NGN account for $userId');
    }
    accountId = inserted;
  }
  stderr.writeln('   ✓ NGN account $accountId');

  final pinClient = pin_pb.TransactionPinServiceClient(coreCh);
  final pinResp = await pinClient.createTransactionPin(
    pin_data.CreateTransactionPinRequest(
      userId: userId,
      pin: _pin,
      confirmPin: _pin,
      deviceId: 'flutter-integration-test',
      deviceName: 'Flutter Integration Test',
    ),
    options: CallOptions(
      metadata: {'authorization': 'Bearer $accessToken'},
      timeout: const Duration(seconds: 30),
    ),
  );
  if (!pinResp.success) {
    throw Exception('CreateTransactionPin failed: ${pinResp.message}');
  }
  stderr.writeln('   ✓ PIN created');

  await _psql('accounts_db',
      "UPDATE accounts SET balance = balance + 10000.00, "
      "available_balance = available_balance + 10000.00 "
      "WHERE id::text = '$accountId';");
  final newBal = await _psql('accounts_db',
      "SELECT balance, available_balance FROM accounts "
      "WHERE id::text = '$accountId';");
  stderr.writeln('   ✓ balance seeded: $newBal');

  await coreCh.shutdown();
  await authCh.shutdown();

  // KEY=VALUE on stdout. Trailing newline is intentional.
  stdout.write('TEST_EMAIL=$email '
      'TEST_USER_ID=$userId '
      'TEST_ACCOUNT_ID=$accountId '
      'TEST_CURRENCY=NGN\n');
}
