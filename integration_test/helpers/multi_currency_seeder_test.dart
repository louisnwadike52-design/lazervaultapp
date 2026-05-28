// Unit test for the multi-currency wallet seeder.
//
// What it proves:
//   1. All 10 supported currencies are attempted (CreateAccount + CreditBalance).
//   2. A re-run (idempotent replay) returns the SAME accountId map and re-uses
//      the existing wallets (no duplicate CreateAccount calls when accounts
//      already exist on GetUserAccounts).
//   3. References + idempotency keys follow the SEED-{currency}-{userIdShort}
//      shape so accounts-service can dedupe on replay.
//
// This is a pure unit test — no app boot, no real gRPC channel. The seeder
// drives an in-process fake [SeederAccountsClient]; we assert on the call
// log it records.

import 'package:fixnum/fixnum.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:grpc/grpc.dart';

import 'package:lazervault/src/generated/accounts.pb.dart' as accounts_pb;

import 'multi_currency_seeder.dart';

class _FakeAccountsClient implements SeederAccountsClient {
  // accountId -> currency assignment so re-runs return stable ids.
  final Map<String, String> _walletsByCurrency = {};
  // Idempotency key -> already-applied (so a replay isn't double-credited).
  final Set<String> _seenIdempotencyKeys = {};

  final List<accounts_pb.GetUserAccountsRequest> getUserAccountsCalls = [];
  final List<accounts_pb.CreateAccountRequest> createAccountCalls = [];
  final List<accounts_pb.CreditBalanceRequest> creditBalanceCalls = [];

  int _accountCounter = 0;

  @override
  Future<accounts_pb.GetUserAccountsResponse> getUserAccounts(
    accounts_pb.GetUserAccountsRequest request, {
    required CallOptions options,
  }) async {
    getUserAccountsCalls.add(request);
    final resp = accounts_pb.GetUserAccountsResponse();
    for (final entry in _walletsByCurrency.entries) {
      final summary = accounts_pb.AccountSummary()
        ..currency = entry.key
        ..status = 'active'
        ..uuid = entry.value;
      resp.accounts.add(summary);
    }
    return resp;
  }

  @override
  Future<accounts_pb.CreateAccountResponse> createAccount(
    accounts_pb.CreateAccountRequest request, {
    required CallOptions options,
  }) async {
    createAccountCalls.add(request);
    final cur = request.currency.toUpperCase();
    // Idempotent: if the wallet already exists (race with getUserAccounts),
    // return the existing id. In practice the seeder prefers the lookup
    // path, but the fake honours the dedupe contract regardless.
    final existing = _walletsByCurrency[cur];
    if (existing != null) {
      final account = accounts_pb.Account()..id = existing;
      return accounts_pb.CreateAccountResponse()..account = account;
    }
    _accountCounter += 1;
    final newId = 'acct-${cur.toLowerCase()}-$_accountCounter';
    _walletsByCurrency[cur] = newId;
    final account = accounts_pb.Account()..id = newId;
    return accounts_pb.CreateAccountResponse()..account = account;
  }

  @override
  Future<accounts_pb.CreditBalanceResponse> creditBalance(
    accounts_pb.CreditBalanceRequest request, {
    required CallOptions options,
  }) async {
    creditBalanceCalls.add(request);
    // accounts-service dedupes on idempotencyKey. Mirror that here so a
    // replay is a no-op but still resolves success=true.
    _seenIdempotencyKeys.add(request.idempotencyKey);
    return accounts_pb.CreditBalanceResponse()..success = true;
  }
}

void main() {
  // ClientChannel is required by the seeder signature but is never used when
  // [clientForTesting] is provided. Build a no-op channel just to satisfy
  // the type.
  ClientChannel buildUnusedChannel() => ClientChannel(
        'localhost',
        port: 50052,
        options: const ChannelOptions(
          credentials: ChannelCredentials.insecure(),
        ),
      );

  group('seedAllCurrencyWallets', () {
    test('attempts CreateAccount + CreditBalance for all 10 currencies', () async {
      final fake = _FakeAccountsClient();
      final channel = buildUnusedChannel();

      final map = await seedAllCurrencyWallets(
        accountsDirect: channel,
        accessToken: 'test-token',
        userId: 'user-1234-5678-90abcdef',
        clientForTesting: fake,
      );

      // Every supported currency must be in the result.
      expect(map.keys.toSet(), equals(kSeederCurrencies.toSet()));
      expect(map.length, equals(10));

      // CreditBalance fires once per currency. The seeder skips
      // CreateAccount when the wallet already exists (cold start = none of
      // them exist, so 10 creates).
      expect(fake.creditBalanceCalls.length, equals(10));
      expect(fake.createAccountCalls.length, equals(10));

      // References + idempotency keys follow the SEED-{currency}-{userShort}
      // shape so accounts-service can dedupe on replay.
      final userShort = 'user-123'; // first 8 chars of 'user-1234-...'
      for (final req in fake.creditBalanceCalls) {
        expect(req.reference, equals('SEED-${req.currency}-$userShort'));
        expect(req.idempotencyKey, equals(req.reference));
        expect(req.serviceName, equals('test-harness'));
        expect(req.type, equals('deposit'));
      }

      await channel.shutdown();
    });

    test('replay returns the same accountId map (idempotent re-seed)',
        () async {
      final fake = _FakeAccountsClient();
      final channel = buildUnusedChannel();

      final first = await seedAllCurrencyWallets(
        accountsDirect: channel,
        accessToken: 'test-token',
        userId: 'user-1234-5678-90abcdef',
        clientForTesting: fake,
      );

      // Replay. The fake's getUserAccounts now returns all 10 wallets, so
      // the seeder should resolve each accountId via the lookup path and
      // NOT call CreateAccount again.
      final beforeCreates = fake.createAccountCalls.length;
      final second = await seedAllCurrencyWallets(
        accountsDirect: channel,
        accessToken: 'test-token',
        userId: 'user-1234-5678-90abcdef',
        clientForTesting: fake,
      );

      expect(second, equals(first));
      // No new CreateAccount calls on replay — every wallet resolves via
      // the GetUserAccounts lookup.
      expect(fake.createAccountCalls.length, equals(beforeCreates));
      // CreditBalance is re-attempted (accounts-service dedupes via
      // idempotencyKey), so we expect another 10 calls — same keys.
      expect(fake.creditBalanceCalls.length, equals(20));
      final replayKeys =
          fake.creditBalanceCalls.skip(10).map((r) => r.idempotencyKey).toSet();
      final originalKeys =
          fake.creditBalanceCalls.take(10).map((r) => r.idempotencyKey).toSet();
      expect(replayKeys, equals(originalKeys));

      await channel.shutdown();
    });

    test('default seed amounts match the documented per-currency table',
        () async {
      final fake = _FakeAccountsClient();
      final channel = buildUnusedChannel();

      await seedAllCurrencyWallets(
        accountsDirect: channel,
        accessToken: 'test-token',
        userId: 'user-1234-5678-90abcdef',
        clientForTesting: fake,
      );

      final amountByCurrency = {
        for (final r in fake.creditBalanceCalls) r.currency: r.amount,
      };
      // amounts are minor units (kobo/cents) — major * 100.
      expect(amountByCurrency['NGN'], equals(Int64(50000000)));
      expect(amountByCurrency['USD'], equals(Int64(100000)));
      expect(amountByCurrency['GBP'], equals(Int64(100000)));
      expect(amountByCurrency['EUR'], equals(Int64(100000)));
      expect(amountByCurrency['GHS'], equals(Int64(1000000)));
      expect(amountByCurrency['KES'], equals(Int64(10000000)));
      expect(amountByCurrency['ZAR'], equals(Int64(1500000)));
      expect(amountByCurrency['UGX'], equals(Int64(370000000)));
      expect(amountByCurrency['TZS'], equals(Int64(250000000)));
      expect(amountByCurrency['XOF'], equals(Int64(55000000)));

      await channel.shutdown();
    });

    test('caller-supplied amounts override defaults per currency', () async {
      final fake = _FakeAccountsClient();
      final channel = buildUnusedChannel();

      await seedAllCurrencyWallets(
        accountsDirect: channel,
        accessToken: 'test-token',
        userId: 'user-1234-5678-90abcdef',
        clientForTesting: fake,
        amounts: const {
          'NGN': 1000, // ₦1,000 == 100_000 minor
          'USD': 5, // $5 == 500 minor
        },
      );

      final byCurrency = {
        for (final r in fake.creditBalanceCalls) r.currency: r.amount,
      };
      expect(byCurrency['NGN'], equals(Int64(100000)));
      expect(byCurrency['USD'], equals(Int64(500)));
      // Unspecified currencies still fall back to the default table.
      expect(byCurrency['GBP'], equals(Int64(100000)));

      await channel.shutdown();
    });

    test('rejects empty accessToken or userId', () async {
      final channel = buildUnusedChannel();
      await expectLater(
        seedAllCurrencyWallets(
          accountsDirect: channel,
          accessToken: '',
          userId: 'user-1234',
        ),
        throwsArgumentError,
      );
      await expectLater(
        seedAllCurrencyWallets(
          accountsDirect: channel,
          accessToken: 'token',
          userId: '',
        ),
        throwsArgumentError,
      );
      await channel.shutdown();
    });
  });
}
