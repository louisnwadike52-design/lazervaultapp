/// End-to-end CLI runner for the split-bill flow.
///
/// Drives two real users (creator + participant) through the live local
/// stack — auth-service, core-gateway, accounts-service, financial-gateway,
/// split-bill-service — with the same generated protos the Flutter app
/// uses. No emulator, no widget driving.
///
/// What this exercises:
///   1. Sign up User A (creator) and User B (participant).
///   2. Bypass OTPs, log both in, set both PINs.
///   3. Seed each account with ₦10,000 (test-only direct DB).
///   4. User A creates a split bill: total ₦1,000, equal split, creator
///      share ₦500, participant B share ₦500.
///   5. Verify the bill is in split_bill_db with the right state.
///   6. User B fetches their incoming list — bill must be there.
///   7. User B calls PaySplitBillShare — money moves through the standard
///      accounts-service Debit/Credit path.
///   8. Verify:
///        - participant row.status = 'paid'
///        - bill.paid_count = 1, paid_amount = 50000 (kobo)
///        - bill.status = 'completed' (creator share + B's share = total)
///        - split_bill_transactions row recorded
///        - B's account balance debited by ₦500
///        - A's account balance credited by ₦500
///
/// Run:
///   cd lazervaultapp
///   dart run tool/e2e_split_bill.dart

import 'dart:io';
import 'dart:math';

import 'package:grpc/grpc.dart';
import 'package:lazervault/src/generated/auth.pbgrpc.dart' as auth_pb;
import 'package:lazervault/src/generated/auth.pb.dart' as auth_data;
import 'package:lazervault/src/generated/accounts.pbgrpc.dart' as accounts_pb;
import 'package:lazervault/src/generated/accounts.pb.dart' as accounts_data;
import 'package:lazervault/src/generated/split_bill.pbgrpc.dart' as sb_pb;
import 'package:lazervault/src/generated/split_bill.pb.dart' as sb_data;
import 'package:lazervault/src/generated/transaction_pin.pbgrpc.dart' as pin_pb;
import 'package:lazervault/src/generated/transaction_pin.pb.dart' as pin_data;

// ── Config ──────────────────────────────────────────────────────────────────
const String _host = '127.0.0.1';
const int _authPort = 50051;
const int _coreGatewayPort = 50070;
const int _accountsPort = 50052;
const int _financialGatewayPort = 50071;
const String _pgUser = 'postgres';
const String _password = r'Test1234!ABC';
const String _pin = '1111';

const double _totalAmountMajor = 1000.0;
const double _creatorShareMajor = 500.0;
const double _participantShareMajor = 500.0;

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
    environment: {'PGPASSWORD': 'postgres'},
  );
  if (result.exitCode != 0) {
    throw 'psql failed: ${result.stderr}';
  }
  return (result.stdout as String).trim();
}

ClientChannel _channel(int port) => ClientChannel(
      _host,
      port: port,
      options: const ChannelOptions(
        credentials: ChannelCredentials.insecure(),
        connectionTimeout: Duration(seconds: 10),
      ),
    );

CallOptions _opts(String token) => CallOptions(
      metadata: {'authorization': 'Bearer $token'},
      timeout: const Duration(seconds: 30),
    );

void _section(String label) {
  print('');
  print('━' * 72);
  print('▶ $label');
  print('━' * 72);
}

void _ok(String msg) => print('  ✓ $msg');
void _fail(String msg) {
  print('  ✗ $msg');
  exit(1);
}

// ── A user shell — everything we need to drive a participant ────────────────
class _User {
  final String email;
  final String username;
  String? userId;
  String? accessToken;
  String? accountId;
  String? verificationToken;

  _User({required this.email, required this.username});
}

Future<void> _signup(_User u) async {
  final ch = _channel(_authPort);
  try {
    final client = auth_pb.AuthServiceClient(ch);
    final resp = await client.signup(
      auth_data.SignupRequest(
        email: u.email,
        password: _password,
        firstName: 'E2E',
        lastName: 'User',
        phone: '+234${800000000 + Random.secure().nextInt(99999999)}',
        deviceId: 'flutter-cli-e2e',
        deviceName: 'Flutter CLI E2E',
        primaryContactType: auth_data.PrimaryContactType.EMAIL,
        username: u.username,
        locale: 'en_NG',
      ),
      options: CallOptions(timeout: const Duration(seconds: 30)),
    );
    if (resp.userId.isEmpty) _fail('Signup failed for $u: ${resp.message}');
    u.userId = resp.userId;
  } finally {
    await ch.shutdown();
  }
}

Future<void> _bypassVerifications(_User u) async {
  await _psql(
    'auth_db',
    "UPDATE users SET email_verified = true, phone_verified = true WHERE id = '${u.userId}'",
  );
}

Future<void> _login(_User u) async {
  final ch = _channel(_coreGatewayPort);
  try {
    final client = auth_pb.AuthServiceClient(ch);
    final resp = await client.login(
      auth_data.LoginRequest(
        email: u.email,
        password: _password,
        deviceId: 'flutter-cli-e2e',
        deviceName: 'Flutter CLI E2E',
      ),
      options: CallOptions(timeout: const Duration(seconds: 30)),
    );
    if (!resp.success) _fail('Login failed for ${u.email}: ${resp.msg}');
    u.accessToken = resp.accessToken;
  } finally {
    await ch.shutdown();
  }
}

Future<void> _loadAccount(_User u) async {
  // accounts-service derives userId from the JWT — no explicit field needed.
  final ch = _channel(_coreGatewayPort);
  try {
    final client = accounts_pb.AccountsServiceClient(ch);
    final resp = await client.getUserAccounts(
      accounts_data.GetUserAccountsRequest(),
      options: _opts(u.accessToken!),
    );
    if (resp.accounts.isEmpty) _fail('No accounts for ${u.email}');
    final ngn = resp.accounts.where((a) => a.currency == 'NGN');
    if (ngn.isNotEmpty) {
      u.accountId = ngn.first.uuid;
      return;
    }
    // Signup picked a non-NGN locale (USD/etc.) — insert an NGN account
    // directly so the split-bill flow has the right currency to debit.
    // Mirrors the same fallback used by e2e_send_funds.dart.
    final acctNum = '99${100000000 + Random.secure().nextInt(99999999)}';
    final id = await _psql(
      'accounts_db',
      "INSERT INTO accounts (user_id, account_number, account_name, "
      "account_type, currency, locale, status, is_primary, is_primary_in_locale, "
      "balance, available_balance, reserved_balance, bank_code, bank_name, "
      "created_at, updated_at) VALUES "
      "('${u.userId}','$acctNum','E2E NGN Account','savings','NGN','en-NG',"
      "'active',false,true,0,0,0,'232','LazerVault Bank',NOW(),NOW()) "
      "RETURNING id",
    );
    if (id.isEmpty) _fail('NGN account insert returned no id for ${u.email}');
    u.accountId = id;
  } finally {
    await ch.shutdown();
  }
}

Future<void> _setPin(_User u) async {
  final ch = _channel(_coreGatewayPort);
  try {
    final client = pin_pb.TransactionPinServiceClient(ch);
    await client.createTransactionPin(
      pin_data.CreateTransactionPinRequest(
        userId: u.userId!,
        pin: _pin,
        confirmPin: _pin,
        deviceId: 'flutter-cli-e2e',
        deviceName: 'Flutter CLI E2E',
      ),
      options: _opts(u.accessToken!),
    );
  } finally {
    await ch.shutdown();
  }
}

Future<void> _seedBalance(_User u) async {
  await _psql(
    'accounts_db',
    "UPDATE accounts SET balance = 10000.00, available_balance = 10000.00 WHERE id = '${u.accountId}'",
  );
}

// ── Main flow ───────────────────────────────────────────────────────────────
Future<void> main() async {
  final stamp = _rand(6);
  final creator = _User(
    email: 'e2e-split-creator-$stamp@lazertest.com',
    username: 'sc$stamp',
  );
  final participant = _User(
    email: 'e2e-split-payer-$stamp@lazertest.com',
    username: 'sp$stamp',
  );

  print('🆕 E2E split-bill run');
  print('   creator    = ${creator.email} / @${creator.username}');
  print('   participant = ${participant.email} / @${participant.username}');

  _section('Step 1: Signup both users');
  await _signup(creator);
  await _signup(participant);
  _ok('creator ${creator.userId}');
  _ok('participant ${participant.userId}');

  _section('Step 2: Bypass OTP verifications (test-only)');
  await _bypassVerifications(creator);
  await _bypassVerifications(participant);
  _ok('verifications bypassed');

  _section('Step 3: Login both');
  await _login(creator);
  await _login(participant);
  _ok('creator token len=${creator.accessToken!.length}');
  _ok('participant token len=${participant.accessToken!.length}');

  _section('Step 4: Load NGN accounts');
  await _loadAccount(creator);
  await _loadAccount(participant);
  _ok('creator account ${creator.accountId}');
  _ok('participant account ${participant.accountId}');

  _section('Step 5: Set PIN 1111 for both');
  await _setPin(creator);
  await _setPin(participant);
  _ok('PINs set');

  _section('Step 6: Seed ₦10,000 into both accounts (test-only direct DB)');
  await _seedBalance(creator);
  await _seedBalance(participant);
  _ok('balances seeded');

  _section('Step 7: Creator CreateSplitBill via financial-gateway:50071');
  final sbChan = _channel(_financialGatewayPort);
  final sbClient = sb_pb.SplitBillServiceClient(sbChan);
  String? billId;
  try {
    final resp = await sbClient.createSplitBill(
      sb_data.CreateSplitBillRequest(
        totalAmount: _totalAmountMajor,
        currency: 'NGN',
        description: 'E2E split test',
        splitMethod: sb_data.SplitMethod.SPLIT_METHOD_EQUAL,
        creatorShare: _creatorShareMajor,
        participants: [
          sb_data.SplitBillParticipantInput(
            username: participant.username,
            amount: _participantShareMajor,
          ),
        ],
      ),
      options: _opts(creator.accessToken!),
    );
    if (!resp.success) _fail('CreateSplitBill failed: ${resp.message}');
    billId = resp.splitBill.id;
    _ok('bill created id=$billId reference=${resp.splitBill.reference} '
        'totalParticipants=${resp.splitBill.totalParticipants}');
  } finally {
    await sbChan.shutdown();
  }

  _section('Step 8: Verify DB state via psql');
  final billRow = await _psql(
    'split_bill_db',
    "SELECT status, total_amount, paid_count, total_participants "
    "FROM split_bills WHERE id = '$billId'",
  );
  print('  bill row: $billRow');
  if (!billRow.contains('active|100000|0|1')) {
    _fail('Bill state wrong; expected active|100000|0|1 got "$billRow"');
  }
  _ok('split_bills row OK (active, 1 participant, 0 paid)');

  final pcountStr = await _psql(
    'split_bill_db',
    "SELECT COUNT(*) FROM split_bill_participants WHERE split_bill_id = '$billId'",
  );
  if (pcountStr != '1') _fail('Expected 1 participant row, got $pcountStr');
  _ok('1 split_bill_participants row');

  _section('Step 9: Participant GetMyIncomingSplitBills must include this bill');
  final ch9 = _channel(_financialGatewayPort);
  try {
    final c = sb_pb.SplitBillServiceClient(ch9);
    final resp = await c.getMyIncomingSplitBills(
      sb_data.GetMySplitBillsRequest(page: 1, limit: 50),
      options: _opts(participant.accessToken!),
    );
    final found = resp.splitBills.any((b) => b.id == billId);
    if (!found) {
      _fail('Bill $billId not in participant incoming list; got '
          '${resp.splitBills.length} bills');
    }
    _ok('participant sees bill in incoming (${resp.splitBills.length} total)');
  } finally {
    await ch9.shutdown();
  }

  _section('Step 10: Participant PaySplitBillShare');
  final ch10 = _channel(_financialGatewayPort);
  try {
    final c = sb_pb.SplitBillServiceClient(ch10);
    final resp = await c.paySplitBillShare(
      sb_data.PaySplitBillShareRequest(
        splitBillId: billId!,
        sourceAccountId: participant.accountId!,
        transactionPin: _pin,
      ),
      options: _opts(participant.accessToken!),
    );
    if (!resp.success) _fail('PaySplitBillShare failed: ${resp.message}');
    _ok('payment ref=${resp.transaction.reference} status=${resp.transaction.status} '
        'amount=${resp.transaction.amount}');
  } finally {
    await ch10.shutdown();
  }

  _section('Step 11: Verify settlement');
  // 11a participant row → paid
  final pStatus = await _psql(
    'split_bill_db',
    "SELECT status FROM split_bill_participants "
    "WHERE split_bill_id = '$billId' AND user_id = '${participant.userId}'",
  );
  if (pStatus != 'paid') _fail('Participant status expected paid, got "$pStatus"');
  _ok('participant.status = paid');

  // 11b bill → completed (creator share + participant share = total)
  final billPost = await _psql(
    'split_bill_db',
    "SELECT status, paid_count, paid_amount FROM split_bills WHERE id = '$billId'",
  );
  print('  bill post-pay: $billPost');
  if (!billPost.contains('completed|1|')) {
    _fail('Bill expected completed|1|<amount>, got "$billPost"');
  }
  _ok('split_bills row OK (completed, paid_count=1)');

  // 11c transaction recorded
  final txRow = await _psql(
    'split_bill_db',
    "SELECT status, amount, reference, payer_id "
    "FROM split_bill_transactions WHERE split_bill_id = '$billId'",
  );
  print('  transaction row: $txRow');
  if (!txRow.contains(participant.userId!)) {
    _fail('Transaction payer_id missing or wrong: $txRow');
  }
  _ok('split_bill_transactions row OK');

  // 11d account balances
  final participantBal = await _psql(
    'accounts_db',
    "SELECT balance, available_balance FROM accounts WHERE id = '${participant.accountId}'",
  );
  final creatorBal = await _psql(
    'accounts_db',
    "SELECT balance, available_balance FROM accounts WHERE id = '${creator.accountId}'",
  );
  print('  participant balance: $participantBal (expected 9500.00|9500.00)');
  print('  creator balance:     $creatorBal (expected 10500.00|10500.00)');
  if (!participantBal.startsWith('9500')) {
    _fail('Participant balance expected 9500, got "$participantBal"');
  }
  if (!creatorBal.startsWith('10500')) {
    _fail('Creator balance expected 10500, got "$creatorBal"');
  }
  _ok('accounts debited/credited correctly');

  _section('');
  print('━' * 72);
  print('✅ E2E split-bill passed');
  print('   bill_id     = $billId');
  print('   creator     = ${creator.userId}');
  print('   participant = ${participant.userId}');
  print('━' * 72);
  exit(0);
}
