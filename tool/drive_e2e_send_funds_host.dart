/// Host-side end-to-end driver for the external Send-Funds path (NO emulator).
///
/// Exercises the EXACT gRPC call path Flutter's send-funds cubit uses —
/// signup → verify-bypass → login → create PIN → seed balance → verifyPin →
/// sendFunds(external Flutterwave NUBAN) — entirely from the host, then reports
/// the reference so the DB invariants can be checked. Ports + DB names match the
/// consolidated local dev stack (auth 50051, core-gateway 50070,
/// transfer-gateway 50076; users/accounts live in core_gateway under the
/// auth/accounts schemas).
///
/// Purpose: validate the SendFunds root-cause reorder (payment row created
/// BEFORE the hold, fund_hold_id attached after) without an Android emulator.
///
/// Run:  cd lazervaultapp && dart run tool/drive_e2e_send_funds_host.dart
/// Then: dart run tool/verify_e2e_send_funds.dart <printed reference>

import 'dart:io';
import 'dart:math';

import 'package:grpc/grpc.dart';
import 'package:lazervault/src/generated/auth.pbgrpc.dart' as auth_pb;
import 'package:lazervault/src/generated/auth.pb.dart' as auth_data;
import 'package:lazervault/src/generated/accounts.pbgrpc.dart' as accounts_pb;
import 'package:lazervault/src/generated/accounts.pb.dart' as accounts_data;
import 'package:lazervault/src/generated/transaction_pin.pbgrpc.dart' as pin_pb;
import 'package:lazervault/src/generated/transaction_pin.pb.dart' as pin_data;
import 'package:lazervault/src/generated/payments.pbgrpc.dart' as payments_pb;
import 'package:lazervault/src/generated/payments.pb.dart' as payments_data;

const String _grpcHost = '127.0.0.1';
const int _authPort = 50051;
const int _coreGatewayPort = 50070;
const int _transferGatewayPort = 50076;
const String _pgUser = 'postgres';
const String _password = r'Test1234!ABC';
const String _pin = '1111';

// Flutterwave deterministic-success test NUBAN (Access Bank 044).
const String _recipientNUBAN = '0690000040';
const String _recipientBank = '044';
const String _recipientName = 'LazerVault Test Recipient';

// Amount can be overridden to toggle fee scenarios (small amounts still carry
// the flat platform + provider fee, so this validates the with-fees path).
final double _amountMajor =
    double.tryParse(Platform.environment['E2E_AMOUNT'] ?? '') ?? 500.0;

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
    environment: {...Platform.environment, 'PGPASSWORD': 'postgres'},
  );
  if (result.exitCode != 0) {
    throw Exception('psql db=$db failed: ${result.stderr}\nsql: $sql');
  }
  final out = (result.stdout as String).trim();
  return out.isEmpty ? '' : out.split('\n').first.trim();
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
  stderr.writeln('🆕 Provisioning $email  (amount=₦$_amountMajor)');

  // ── Signup (auth-service) ──────────────────────────────────────────
  final authCh = _channel(_authPort);
  final signupResp = await auth_pb.AuthServiceClient(authCh).signup(
    auth_data.SignupRequest(
      email: email,
      password: _password,
      firstName: 'E2E',
      lastName: 'Tester',
      phone: '+234${800000000 + Random.secure().nextInt(99999999)}',
      deviceId: 'host-e2e',
      deviceName: 'Host E2E',
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

  // OTP bypass (test-only). users live in core_gateway under the auth schema.
  await _psql('core_gateway',
      "UPDATE auth.users SET email_verified=true, phone_verified=true WHERE id='$userId';");
  stderr.writeln('   ✓ verifications bypassed');

  // ── Login (core-gateway) ───────────────────────────────────────────
  final coreCh = _channel(_coreGatewayPort);
  final loginResp = await auth_pb.AuthServiceClient(coreCh).login(
    auth_data.LoginRequest(
      email: email,
      password: _password,
      deviceId: 'host-e2e',
      deviceName: 'Host E2E',
    ),
    options: CallOptions(timeout: const Duration(seconds: 30)),
  );
  if (!loginResp.success) throw Exception('Login failed: ${loginResp.msg}');
  final accessToken = loginResp.accessToken;
  final authMd = {'authorization': 'Bearer $accessToken'};
  stderr.writeln('   ✓ logged in');

  // ── Resolve NGN account ────────────────────────────────────────────
  final acctResp = await accounts_pb.AccountsServiceClient(coreCh).getUserAccounts(
    accounts_data.GetUserAccountsRequest(),
    options: CallOptions(metadata: authMd, timeout: const Duration(seconds: 30)),
  );
  final ngn = acctResp.accounts.where((a) => a.currency == 'NGN');
  if (ngn.isEmpty) throw Exception('no NGN account provisioned at signup');
  final accountId = ngn.first.uuid;
  stderr.writeln('   ✓ NGN account $accountId');

  // ── Create PIN + seed balance ──────────────────────────────────────
  final pinClient = pin_pb.TransactionPinServiceClient(coreCh);
  final pinCreate = await pinClient.createTransactionPin(
    pin_data.CreateTransactionPinRequest(
      userId: userId, pin: _pin, confirmPin: _pin,
      deviceId: 'host-e2e', deviceName: 'Host E2E',
    ),
    options: CallOptions(metadata: authMd, timeout: const Duration(seconds: 30)),
  );
  if (!pinCreate.success) throw Exception('CreateTransactionPin: ${pinCreate.message}');
  stderr.writeln('   ✓ PIN created');

  await _psql('core_gateway',
      "UPDATE accounts.accounts SET balance = balance + 10000.00, "
      "available_balance = available_balance + 10000.00 WHERE id::text = '$accountId';");
  stderr.writeln('   ✓ balance seeded ₦10,000');

  // ── Verify PIN → verification token ────────────────────────────────
  final txId = 'tx-${_rand(16)}';
  final pinVerify = await pinClient.verifyTransactionPin(
    pin_data.VerifyTransactionPinRequest(
      userId: userId, pin: _pin, transactionId: txId,
      transactionType: 'transfer', amount: _amountMajor,
      currency: 'NGN', deviceId: 'host-e2e',
    ),
    options: CallOptions(metadata: authMd, timeout: const Duration(seconds: 30)),
  );
  if (!pinVerify.success) throw Exception('verifyPin: ${pinVerify.message}');
  stderr.writeln('   ✓ PIN verified → token');

  // ── SendFunds (external Flutterwave) via transfer-gateway ──────────
  final txCh = _channel(_transferGatewayPort);
  final sendResp = await payments_pb.PaymentsServiceClient(txCh).sendFunds(
    payments_data.SendFundsRequest(
      fromAccountId: accountId,
      toAccountNumber: _recipientNUBAN,
      toAccountId: '',
      type: 'external',
      amount: _amountMajor,
      description: 'Host E2E Flutterwave test',
      transactionId: txId,
      verificationToken: pinVerify.verificationToken,
      destinationBankCode: _recipientBank,
      beneficiaryName: _recipientName,
      expenseCategory: 0,
    ),
    options: CallOptions(
      metadata: {...authMd, 'x-account-id': accountId},
      timeout: const Duration(seconds: 40),
    ),
  );

  stderr.writeln('💸 SendFunds: status=${sendResp.payment.status} '
      'reference=${sendResp.payment.reference} msg=${sendResp.message}');

  await coreCh.shutdown();
  await authCh.shutdown();
  await txCh.shutdown();

  // The reference is the only thing on stdout — grep-able for the verifier.
  stdout.write('E2E_TRANSFER_REFERENCE=${sendResp.payment.reference} '
      'STATUS=${sendResp.payment.status} ACCOUNT_ID=$accountId\n');
}
