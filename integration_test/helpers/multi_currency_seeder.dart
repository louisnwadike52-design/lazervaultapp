// Multi-currency wallet seeder for the exchange-service E2E tests.
//
// Seeds wallet balances in ALL 10 supported currencies for a fresh test user
// and returns the map of currency -> accountId so the test can pick the right
// source account by currency code.
//
// Design notes:
//  * Uses accounts-service direct (NOT the gateway). This is test setup, not
//    a real user flow — same pattern as the existing _provisionTestUser
//    helper in integration_test/transfer_send_ui_e2e_test.dart.
//  * Deterministic references shaped SEED-{currency}-{userIdShort} so a
//    re-run is idempotent: accounts-service dedupes on the idempotency key
//    (and credits dedupe on the reference for safety), so a re-seed is a
//    no-op rather than a double-credit.
//  * Best-effort retry: each per-currency step retries 3x with 500ms backoff
//    to absorb cold-start flake; a hard failure on ANY currency throws so
//    the test reports a clear "setup failure" rather than continuing with a
//    half-seeded user.
//  * The seeder DOES NOT depend on the exchange-service — it talks to
//    accounts-service directly. Tests for either domain can use it.

import 'dart:async';

import 'package:fixnum/fixnum.dart';
import 'package:grpc/grpc.dart';
import 'package:lazervault/src/generated/accounts.pb.dart' as accounts_pb;
import 'package:lazervault/src/generated/accounts.pbgrpc.dart' as accounts_grpc;

/// Default per-currency seed amounts (major units). Sized to comfortably
/// cover the minimum international-transfer ticket size in each corridor so
/// e2e tests don't fail with "below minimum" errors:
///
///   NGN = 500_000     (₦500k — minimum NGN/USD ~ 6 USD with buffer)
///   USD = 1_000       ($1k — comfortably above 6 USD minimum)
///   GBP = 1_000       (£1k — covers UK CoP-checked test transfers)
///   EUR = 1_000       (€1k)
///   GHS = 10_000      (~$700)
///   KES = 100_000     (~$700)
/// #131: ZAR/UGX/TZS/XOF removed from the seed list — Flutterwave's FX
/// API doesn't reliably support them in our flow. Re-add when coverage
/// expands (keep this aligned with backend supportedCurrenciesFallback +
/// migration 003 + Flutter flutterwave_country_rules.dart).
const Map<String, double> kDefaultSeedAmounts = {
  'NGN': 500000,
  'USD': 1000,
  'GBP': 1000,
  'EUR': 1000,
  'GHS': 10000,
  'KES': 100000,
};

/// The full set of currencies the seeder will provision. Mirrors
/// `kDefaultSeedAmounts.keys`. Kept as its own constant so callers can
/// quickly check membership without instantiating the map.
const List<String> kSeederCurrencies = [
  'NGN',
  'USD',
  'GBP',
  'EUR',
  'GHS',
  'KES',
];

/// Tiny test seam — the seeder talks to accounts-service through a slim
/// interface so unit tests can swap the gRPC client for an in-process fake
/// without spinning up a real channel. Production callers never touch this:
/// they pass [accountsDirect] and let the seeder build a real
/// [accounts_grpc.AccountsServiceClient] internally.
abstract class SeederAccountsClient {
  Future<accounts_pb.GetUserAccountsResponse> getUserAccounts(
    accounts_pb.GetUserAccountsRequest request, {
    required CallOptions options,
  });

  Future<accounts_pb.CreateAccountResponse> createAccount(
    accounts_pb.CreateAccountRequest request, {
    required CallOptions options,
  });

  Future<accounts_pb.CreditBalanceResponse> creditBalance(
    accounts_pb.CreditBalanceRequest request, {
    required CallOptions options,
  });
}

class _RealSeederClient implements SeederAccountsClient {
  final accounts_grpc.AccountsServiceClient _inner;

  _RealSeederClient(this._inner);

  @override
  Future<accounts_pb.GetUserAccountsResponse> getUserAccounts(
    accounts_pb.GetUserAccountsRequest request, {
    required CallOptions options,
  }) =>
      _inner.getUserAccounts(request, options: options);

  @override
  Future<accounts_pb.CreateAccountResponse> createAccount(
    accounts_pb.CreateAccountRequest request, {
    required CallOptions options,
  }) =>
      _inner.createAccount(request, options: options);

  @override
  Future<accounts_pb.CreditBalanceResponse> creditBalance(
    accounts_pb.CreditBalanceRequest request, {
    required CallOptions options,
  }) =>
      _inner.creditBalance(request, options: options);
}

/// Seeds wallet balances in ALL 10 supported currencies for [userId]. Returns
/// the map of currency code -> accountId so tests can pick the right source
/// account by currency.
///
/// [accountsDirect] is a [ClientChannel] pointing at the accounts-service
///   direct port (50052) — NOT the core gateway. Internal write paths like
///   CreditBalance require service-only auth which the gateway interceptor
///   strips.
/// [accessToken] is the user's session token. Used for CreateAccount (which
///   does go through user-auth). Pass the value from the signup response.
/// [userId] is the user's UUID (signupResp.userId). Echoed back into the
///   wire-shape CreditBalanceRequest.
/// [amounts] overrides the per-currency seed amount. Missing keys fall back
///   to [kDefaultSeedAmounts]. Useful when a specific test needs a tighter
///   or larger balance.
///
/// Returns: `Map<currency, accountId>` for every successfully seeded wallet.
/// Throws when ANY currency fails after retries — partial seeding is a setup
/// failure, not a soft warning.
Future<Map<String, String>> seedAllCurrencyWallets({
  required ClientChannel accountsDirect,
  required String accessToken,
  required String userId,
  Map<String, double>? amounts,
  // Test-only: inject a fake client so unit tests can drive the seeder
  // without spinning up a real gRPC channel. Real callers leave this null
  // and let the seeder construct a real client from [accountsDirect].
  SeederAccountsClient? clientForTesting,
}) async {
  if (accessToken.isEmpty) {
    throw ArgumentError('seedAllCurrencyWallets: accessToken is empty');
  }
  if (userId.isEmpty) {
    throw ArgumentError('seedAllCurrencyWallets: userId is empty');
  }

  final userIdShort =
      userId.length > 8 ? userId.substring(0, 8) : userId;
  final accounts = clientForTesting ??
      _RealSeederClient(accounts_grpc.AccountsServiceClient(accountsDirect));

  final result = <String, String>{};

  for (final currency in kSeederCurrencies) {
    final amountMajor = amounts?[currency] ?? kDefaultSeedAmounts[currency]!;
    final amountMinor = (amountMajor * 100).round();

    // 1. CreateAccount — idempotent via the existing dedupe on
    //    (user_id, currency). Returns the existing wallet on conflict, so
    //    re-running the seeder reuses the same accountId.
    final accountId = await _runWithRetry(
      'CreateAccount[$currency]',
      () => _createOrFetchAccount(
        accounts: accounts,
        currency: currency,
        accessToken: accessToken,
        userId: userId,
      ),
    );

    // 2. CreditBalance — deterministic reference + idempotency key so
    //    re-runs are no-ops rather than double-credits.
    final reference = 'SEED-$currency-$userIdShort';
    await _runWithRetry<accounts_pb.CreditBalanceResponse>(
      'CreditBalance[$currency]',
      () async {
        final resp = await accounts.creditBalance(
          accounts_pb.CreditBalanceRequest(
            accountId: accountId,
            userId: userId,
            amount: Int64(amountMinor),
            currency: currency,
            reference: reference,
            type: 'deposit',
            description: 'Multi-currency e2e seed ($currency)',
            serviceName: 'test-harness',
            idempotencyKey: reference,
          ),
          options: CallOptions(timeout: const Duration(seconds: 30)),
        );
        // CreditBalance dedupes on idempotencyKey — on re-run the response
        // still has success=true (same outcome as the original credit) so
        // the seeder cleanly idempotent-passes.
        if (!resp.success) {
          throw Exception(
            'CreditBalance[$currency]: code=${resp.errorCode} '
            'msg=${resp.errorMessage}',
          );
        }
        return resp;
      },
    );

    result[currency] = accountId;
  }

  return result;
}

/// Resolves an existing wallet for [currency] OR creates one. Idempotent: the
/// CreateAccount RPC on accounts-service returns the existing account on a
/// duplicate (user_id, currency) so this can be called many times safely.
Future<String> _createOrFetchAccount({
  required SeederAccountsClient accounts,
  required String currency,
  required String accessToken,
  required String userId,
}) async {
  final authOpts = CallOptions(
    metadata: {'authorization': 'Bearer $accessToken'},
    timeout: const Duration(seconds: 30),
  );

  // First, look up an existing wallet — cheaper than poking the create path
  // when the account is already there.
  final existing = await accounts.getUserAccounts(
    accounts_pb.GetUserAccountsRequest(),
    options: authOpts,
  );
  for (final a in existing.accounts) {
    if (a.currency.toUpperCase() == currency.toUpperCase()) {
      final id = a.uuid.isNotEmpty ? a.uuid : a.id.toString();
      if (id.isNotEmpty) return id;
    }
  }

  // Otherwise create it. CreateAccount on accounts-service handles
  // duplicate-on-race by returning the existing account row.
  final created = await accounts.createAccount(
    accounts_pb.CreateAccountRequest(
      accountName: 'E2E $currency Wallet',
      accountType: 'personal',
      currency: currency,
      locale: 'en-NG',
      isPrimary: false,
    ),
    options: authOpts,
  );
  final id = created.account.id;
  if (id.isEmpty) {
    throw Exception('CreateAccount[$currency]: empty account id in response');
  }
  return id;
}

/// 3x retry with 500ms backoff. Wraps any throwable; the last error is
/// rethrown so the caller sees the real failure when retries are exhausted.
Future<T> _runWithRetry<T>(String label, Future<T> Function() op) async {
  Object? lastErr;
  for (var attempt = 1; attempt <= 3; attempt++) {
    try {
      return await op();
    } catch (e) {
      lastErr = e;
      if (attempt < 3) {
        await Future<void>.delayed(const Duration(milliseconds: 500));
      }
    }
  }
  throw Exception('$label failed after 3 attempts: $lastErr');
}
