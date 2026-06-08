/// E2E (debug-mode) tests for AutoSave-from-external-bank:
/// REAL Flutter gRPC clients against the REAL local backends and the REAL
/// Mono sandbox — no mocks on the wire.
///
/// Covers, end to end:
///  1. Create an external-inflow rule through products-gateway (50078) with
///     the new trigger + linked-bank fields, and verify the round-trip
///     (trigger, bank, RAW-percent amount encoding).
///  2. The closed money loop: an external.inflow.detected event (emitted via
///     banking's transaction_outbox, drained by the REAL Kafka publisher)
///     drives the fp consumer → ExecuteExternalInflow → banking
///     InitiateDeposit (mandate tier → REAL Mono sandbox mandate debit).
///     Asserts the AutoSave transaction row (amount = 50% of inflow clamped
///     by max_per_save) + deposit linkage metadata.
///  3. Replay safety: re-publishing the SAME event produces no second save
///     (fp idempotency + banking idempotency key are one and the same).
///  4. Settlement: the wallet credit lands in accounts-service history with
///     category auto_save and an "AutoSave"-prefixed description...
///  5. ...which the on_deposit consumer's recursion guard deny-lists: an
///     active on_deposit rule on the destination account does NOT fire.
///
/// Prereqs (the local stack):
///   * core-gateway 7878/50070, products-gateway 50078, banking-service
///     50073, financial-products-service 50056, Kafka 9092, postgres.
///   * provetest2@gmail.com / Password1$ with GTBank linked account
///     660a683f… holding a ready_to_debit Mono sandbox mandate.
///
/// Run: flutter test test/e2e/autosave_external_e2e_test.dart
library autosave_external_e2e_test;

import 'dart:convert';
import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:grpc/grpc.dart';

import 'package:lazervault/core/services/account_manager.dart';
import 'package:lazervault/core/services/grpc_call_options_helper.dart';
import 'package:lazervault/core/services/locale_manager.dart';
import 'package:lazervault/src/generated/accounts.pbgrpc.dart' as accounts_pb;
import 'package:lazervault/src/generated/autosave.pbgrpc.dart' as autosave_pb;

// ── Test fixtures (live local stack) ────────────────────────────────────────
const _host = 'localhost';
const _email = 'provetest2@gmail.com';
const _password = 'Password1\$';
const _userId = 'e233d0fd-88fe-4be8-a919-4b25ac4442b4';
// Destination: the user's NGN savings wallet.
const _savingsAccountId = '0900a17d-cc97-4b2e-8cfd-5f683402aedf';
// Source: GTBank linked account with a ready_to_debit Mono sandbox mandate.
const _gtbankLinkedId = '660a683f-95a3-4979-a4d7-aa1ccd041201';
const _gtbankName = 'Guaranty Trust Bank';

// Inflow fixture: ₦20,000 lands in GTBank. Rule saves 50% (₦10,000) but is
// clamped by max_per_save ₦5,000 — exercising the percentage math AND the
// clamp in one shot.
const _inflowKobo = 2000000; // ₦20,000
const _maxPerSaveKobo = 500000.0; // ₦5,000 (gateway contract: kobo)
const _expectedSaveKobo = 500000; // clamp wins over 50% (= ₦10,000)

const _bankingDb = 'lazervault_banking_dev';
const _fpDb = 'financial_products_db';

class _TestStorage extends Fake implements FlutterSecureStorage {
  final Map<String, String> _data = {};

  @override
  Future<String?> read({
    required String key,
    IOSOptions? iOptions,
    AndroidOptions? aOptions,
    LinuxOptions? lOptions,
    WebOptions? webOptions,
    MacOsOptions? mOptions,
    WindowsOptions? wOptions,
  }) async =>
      _data[key];

  @override
  Future<void> write({
    required String key,
    required String? value,
    IOSOptions? iOptions,
    AndroidOptions? aOptions,
    LinuxOptions? lOptions,
    WebOptions? webOptions,
    MacOsOptions? mOptions,
    WindowsOptions? wOptions,
  }) async {
    if (value == null) {
      _data.remove(key);
    } else {
      _data[key] = value;
    }
  }
}

Future<String> _login() async {
  final client = HttpClient();
  try {
    final req =
        await client.postUrl(Uri.parse('http://$_host:7878/api/v1/auth/login'));
    req.headers.contentType = ContentType.json;
    req.write(jsonEncode({'email': _email, 'password': _password}));
    final res = await req.close();
    final body = jsonDecode(await res.transform(utf8.decoder).join());
    expect(body['success'], isTrue,
        reason: 'Login failed: ${body['msg']} — is the stack up and the '
            'provetest2 account unlocked?');
    return body['accessToken'] as String;
  } finally {
    client.close();
  }
}

ClientChannel _channel(int port) => ClientChannel(
      _host,
      port: port,
      options:
          const ChannelOptions(credentials: ChannelCredentials.insecure()),
    );

/// Runs a SQL statement against a local postgres DB; returns trimmed stdout.
Future<String> _psql(String db, String sql) async {
  final result = await Process.run(
    'psql',
    ['-h', 'localhost', '-U', 'postgres', '-d', db, '-tAc', sql],
    environment: {'PGPASSWORD': 'postgres'},
  );
  expect(result.exitCode, 0,
      reason: 'psql failed on $db: ${result.stderr}\nSQL: $sql');
  return (result.stdout as String).trim();
}

void main() {
  late _TestStorage storage;
  late GrpcCallOptionsHelper authHelper;
  late ClientChannel productsChannel; // AutoSaveService (products-gateway)
  late ClientChannel coreChannel; // accounts-service RPCs (core-gateway)
  late autosave_pb.AutoSaveServiceClient autoSaveClient;
  late accounts_pb.AccountsServiceClient accountsClient;

  // Synthetic external txn id — unique per run so the test is re-runnable
  // (the outbox EventID and both idempotency keys derive from it).
  final runTag = DateTime.now().millisecondsSinceEpoch;
  final externalTxnId = 'e2einflow$runTag';
  final ruleName = 'E2E Bank Inflow $runTag';
  final guardRuleName = 'E2E Recursion Guard $runTag';
  final testStart = DateTime.now().toUtc();

  String? ruleId; // created in test 1, consumed by the rest
  String? guardRuleId; // on_deposit rule on the destination account

  Future<CallOptions> authOptions() =>
      authHelper.withAuth(CallOptions(timeout: const Duration(seconds: 20)));

  setUpAll(() async {
    final token = await _login();
    storage = _TestStorage();
    await storage.write(key: 'access_token', value: token);
    await storage.write(key: 'user_id', value: _userId);

    authHelper = GrpcCallOptionsHelper(
      storage,
      localeManager: LocaleManager(),
      accountManager: AccountManager()..setActiveAccount(_savingsAccountId),
    );

    productsChannel = _channel(50078);
    coreChannel = _channel(50070);
    autoSaveClient = autosave_pb.AutoSaveServiceClient(productsChannel);
    accountsClient = accounts_pb.AccountsServiceClient(coreChannel);
  });

  tearDownAll(() async {
    // Best-effort cleanup: cancel the rules so reruns don't accumulate
    // active rules that fire on future inflows.
    for (final id in [ruleId, guardRuleId]) {
      if (id == null) continue;
      try {
        await autoSaveClient.deleteAutoSaveRule(
          autosave_pb.DeleteAutoSaveRuleRequest()..ruleId = id,
          options: await authOptions(),
        );
      } catch (_) {}
    }
    await productsChannel.shutdown();
    await coreChannel.shutdown();
  });

  test('1. create external-inflow rule (trigger + bank fields round-trip)',
      () async {
    final req = autosave_pb.CreateAutoSaveRuleRequest()
      ..name = ruleName
      ..description = 'Save half of every GTBank inflow (e2e)'
      ..triggerType = autosave_pb.TriggerType.TRIGGER_EXTERNAL_INFLOW
      ..amountType = autosave_pb.AmountType.AMOUNT_PERCENTAGE
      ..amountValue = 50.0 // RAW percent — must round-trip unchanged
      ..sourceAccountId = '' // unused for this trigger
      ..sourceLinkedAccountId = _gtbankLinkedId
      ..sourceBankName = _gtbankName
      ..destinationAccountId = _savingsAccountId
      ..maximumPerSave = _maxPerSaveKobo;

    final res =
        await autoSaveClient.createAutoSaveRule(req, options: await authOptions());
    expect(res.success, isTrue, reason: 'create failed: ${res.msg}');
    final rule = res.rule;
    ruleId = rule.id;

    expect(rule.triggerType, autosave_pb.TriggerType.TRIGGER_EXTERNAL_INFLOW);
    expect(rule.sourceLinkedAccountId, _gtbankLinkedId);
    expect(rule.sourceBankName, _gtbankName);
    expect(rule.amountValue, closeTo(50.0, 0.01),
        reason: 'percentage must round-trip RAW (50 = 50%), not kobo-mangled');
    expect(rule.maximumPerSave, closeTo(_maxPerSaveKobo, 1));

    // DB truth: percentage stored kobo-encoded (pct*100 → 5000 = 50%).
    final dbVal = await _psql(_fpDb,
        "SELECT amount_value || '|' || trigger_type || '|' || source_linked_account_id FROM auto_save_rules WHERE id='$ruleId'");
    expect(dbVal, '5000|external_inflow|$_gtbankLinkedId',
        reason: 'DB encoding must be pct*100 (executor divides by 10000)');
  });

  test('2. inflow event → consumer → REAL Mono mandate debit accepted',
      () async {
    expect(ruleId, isNotNull);

    // Recursion-guard fixture FIRST: an active on_deposit rule draining the
    // destination savings account. If the autosave wallet credit were not
    // deny-listed, this rule would fire off it in test 5.
    final guardRes = await autoSaveClient.createAutoSaveRule(
      autosave_pb.CreateAutoSaveRuleRequest()
        ..name = guardRuleName
        ..triggerType = autosave_pb.TriggerType.TRIGGER_ON_DEPOSIT
        ..amountType = autosave_pb.AmountType.AMOUNT_PERCENTAGE
        ..amountValue = 10.0
        ..sourceAccountId = _savingsAccountId
        ..destinationAccountId =
            '2a07884c-f7e5-46b9-bb31-a0ec00df79cc' // personal wallet
      ,
      options: await authOptions(),
    );
    expect(guardRes.success, isTrue, reason: guardRes.msg);
    guardRuleId = guardRes.rule.id;

    // Emit the inflow exactly the way the sync service does: one
    // transaction_outbox row. The (now real) publisher drains it to Kafka
    // topic banking.external-inflow within ~2s.
    final payload = jsonEncode({
      'user_id': _userId,
      'linked_account_id': _gtbankLinkedId,
      'bank_name': _gtbankName,
      'external_txn_id': externalTxnId,
      'amount_kobo': _inflowKobo,
      'currency': 'NGN',
      'narration': 'NIP/E2E/AUTOSAVE INFLOW $runTag',
      'transaction_date': DateTime.now().toUtc().toIso8601String(),
    });
    await _psql(_bankingDb, """
      INSERT INTO transaction_outbox
        (event_id, event_type, aggregate_type, aggregate_id, kafka_topic,
         payload, status, user_id, priority, max_retries, source_service,
         idempotency_key, created_at, updated_at)
      VALUES
        ('extinflow_$externalTxnId', 'external.inflow.detected',
         'external_bank_transaction', '$externalTxnId',
         'banking.external-inflow', '${payload.replaceAll("'", "''")}',
         'pending', '$_userId', 8, 10, 'banking-service',
         'extinflow_$externalTxnId', NOW(), NOW())
    """);

    // Poll the user-facing surface (products-gateway) until the save shows.
    autosave_pb.AutoSaveTransaction? found;
    for (var i = 0; i < 30 && found == null; i++) {
      await Future<void>.delayed(const Duration(seconds: 2));
      final res = await autoSaveClient.getAutoSaveTransactions(
        autosave_pb.GetAutoSaveTransactionsRequest()
          ..ruleId = ruleId!
          ..limit = 10,
        options: await authOptions(),
      );
      for (final t in res.transactions) {
        if (t.success) found = t;
      }
    }
    expect(found, isNotNull,
        reason: 'no successful AutoSave transaction within 60s — check '
            'banking outbox publisher, Kafka, and the fp consumer logs');

    expect(found!.triggerType,
        autosave_pb.TriggerType.TRIGGER_EXTERNAL_INFLOW);
    expect(found.triggerReason, 'external_inflow');
    expect(found.amount.round(), _expectedSaveKobo,
        reason: '50% of ₦20,000 clamped by max_per_save ₦5,000');
    expect(found.sourceAccountId, _gtbankLinkedId);
    expect(found.destinationAccountId, _savingsAccountId);

    // Deposit linkage metadata.
    expect(found.metadata, isNotEmpty, reason: 'metadata must link deposit');
    final meta = jsonDecode(found.metadata) as Map<String, dynamic>;
    expect(meta['external_txn_id'], externalTxnId);
    expect(meta['deposit_reference'], isNotEmpty);
    expect(meta['bank_name'], _gtbankName);

    // Banking truth: ONE direct_debits row carries the shared idempotency
    // key, the credit-label overrides, and the audit external_reference.
    final idemKey = 'autosave_extinflow:$ruleId:$externalTxnId';
    final row = await _psql(_bankingDb,
        "SELECT COUNT(*) || '|' || MIN(credit_type_override) || '|' || MIN(external_reference) || '|' || MIN(amount::text) FROM direct_debits WHERE idempotency_key='$idemKey'");
    expect(row, '1|auto_save|$externalTxnId|$_expectedSaveKobo');
    final desc = await _psql(_bankingDb,
        "SELECT credit_description_override FROM direct_debits WHERE idempotency_key='$idemKey'");
    expect(desc, startsWith('AutoSave'),
        reason: 'recursion guard keys on the AutoSave description prefix');
  }, timeout: const Timeout(Duration(minutes: 3)));

  test('3. replay of the same event does not double-save', () async {
    expect(ruleId, isNotNull);

    // Re-publish the SAME event (simulates Kafka at-least-once / a crashed
    // consumer): flip the outbox row back to pending.
    await _psql(_bankingDb, """
      UPDATE transaction_outbox SET status='pending', published_at=NULL,
        locked_at=NULL, locked_by='', next_retry_at=NULL
      WHERE event_id='extinflow_$externalTxnId'
    """);

    // Give the publisher + consumer ample time to reprocess.
    await Future<void>.delayed(const Duration(seconds: 12));

    final txnCount = await _psql(_fpDb,
        "SELECT COUNT(*) FROM auto_save_transactions WHERE rule_id='$ruleId' AND success=true");
    expect(txnCount, '1', reason: 'replay must not create a second save');

    final idemKey = 'autosave_extinflow:$ruleId:$externalTxnId';
    final depositCount = await _psql(_bankingDb,
        "SELECT COUNT(*) FROM direct_debits WHERE idempotency_key='$idemKey'");
    expect(depositCount, '1', reason: 'replay must not create a second debit');
  }, timeout: const Timeout(Duration(minutes: 1)));

  test('4. settlement lands the wallet credit as "AutoSave Deposit"',
      () async {
    expect(ruleId, isNotNull);

    // The Mono sandbox debit settles via webhook (ngrok) or the deposit
    // reconciler (default 120s tick) — poll accounts history generously.
    accounts_pb.Transaction? credit;
    for (var i = 0; i < 45 && credit == null; i++) {
      await Future<void>.delayed(const Duration(seconds: 5));
      final res = await accountsClient.getTransactionHistory(
        accounts_pb.GetTransactionHistoryRequest()
          ..accountId = _savingsAccountId
          ..type = 'credit'
          ..limit = 20,
        options: await authOptions(),
      );
      for (final t in res.transactions) {
        if (t.category == 'auto_save' &&
            t.description.startsWith('AutoSave (external_inflow):') &&
            t.description.contains(ruleName)) {
          credit = t;
        }
      }
    }
    expect(credit, isNotNull,
        reason: 'wallet credit did not settle within ~225s — check the Mono '
            'webhook proxy / deposit reconciler');
    // The wallet credit is NET of the platform deposit fee (admin-tunable
    // deposit_fee_percentage, default 1.5%): assert against the actual
    // amount/fee persisted on the banking deposit row, not a hardcoded net.
    final idemKey = 'autosave_extinflow:$ruleId:$externalTxnId';
    final feeRow = await _psql(_bankingDb,
        "SELECT amount || '|' || fee FROM direct_debits WHERE idempotency_key='$idemKey'");
    final parts = feeRow.split('|');
    final grossKobo = int.parse(parts[0]);
    final feeKobo = int.parse(parts[1]);
    expect(grossKobo, _expectedSaveKobo);
    // accounts history exposes major units.
    expect(credit!.amount, closeTo((grossKobo - feeKobo) / 100.0, 0.01),
        reason: 'wallet credit must equal gross save minus deposit fee');
    expect(credit.type, 'credit');
  }, timeout: const Timeout(Duration(minutes: 5)));

  test('5. recursion guard: on_deposit rule on the wallet did NOT fire',
      () async {
    expect(guardRuleId, isNotNull);

    // Allow the on_deposit consumer a beat to (not) act on the settled
    // credit's balance-changed event.
    await Future<void>.delayed(const Duration(seconds: 8));

    final fired = await _psql(_fpDb,
        "SELECT COUNT(*) FROM auto_save_transactions WHERE rule_id='$guardRuleId' AND created_at >= '${testStart.toIso8601String()}'");
    expect(fired, '0',
        reason: 'the AutoSave wallet credit must be deny-listed by '
            'isAutoSaveDescription — an on_deposit fire here is the '
            'money-multiplying recursion bug');
  }, timeout: const Timeout(Duration(minutes: 1)));
}
