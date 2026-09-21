import 'package:lazervault/core/services/grpc_call_options_helper.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/src/generated/accounts.pb.dart' as accounts_pb;
import 'package:lazervault/src/generated/accounts.pbgrpc.dart' as accounts_grpc;

/// Reads what the user holds in a currency OTHER than their active locale's.
///
/// This exists because the default `GetUserAccounts` returns only the
/// LOCALE-CURRENCY accounts. Anything that needs to reason about a foreign
/// balance — "you are being billed in USD, and you do hold USD" — has to ask
/// for `includeAllCurrencies: true` explicitly or it will read every foreign
/// balance as zero. The currency-exchange flow learned that the hard way: its
/// balance check reported `bestBalance=0` for any non-locale source currency
/// and refused perfectly funded international transfers
/// (`exchange_home_screen.dart::_validateBalance`).
///
/// Centralised here so the next flow that needs a foreign balance does not
/// rediscover the same trap.
class CurrencyHoldingsService {
  const CurrencyHoldingsService._();

  /// The user's largest ACTIVE balance in [currency], in major units.
  ///
  /// Returns 0 when they hold nothing in it. Returns null when the lookup
  /// itself failed — callers must not render "you hold 0.00" off the back of a
  /// network error, which would tell someone with a funded wallet that it is
  /// empty. Never throws: this is informational, and no payment decision may
  /// depend on it.
  static Future<double?> largestActiveBalance(String currency) async {
    final wanted = currency.trim().toUpperCase();
    if (wanted.isEmpty) return null;
    try {
      final client = serviceLocator<accounts_grpc.AccountsServiceClient>();
      final options = await serviceLocator<GrpcCallOptionsHelper>().withAuth();
      final response = await client.getUserAccounts(
        // The whole point of this class — see the class comment.
        accounts_pb.GetUserAccountsRequest(includeAllCurrencies: true),
        options: options,
      );

      double best = 0;
      for (final account in response.accounts) {
        if (account.currency.toUpperCase() != wanted) continue;
        if (account.status != 'active') continue;
        // Wire balances are MINOR units (kobo/cents).
        final major = account.balance.toDouble() / 100;
        if (major > best) best = major;
      }
      return best;
    } catch (_) {
      return null;
    }
  }

  /// Every ACTIVE account the user holds in [currency], newest balances first.
  ///
  /// Analytics needs this because "my LazerVault spending" is a question about
  /// a SET of wallets: a user holds a personal, business, savings, family and
  /// campaign account per currency, and production carries 24 to 40 accounts
  /// per user. Scoping analytics to `activeAccountId` alone answered for one of
  /// them and presented it as the whole picture.
  ///
  /// Scoped to a single [currency] deliberately. Wallets are only ever summed
  /// within one currency: adding NGN 100 to USD 5 produces a number that means
  /// nothing, so a cross-currency total must never be offered.
  ///
  /// Returns null when the lookup itself failed, so a caller can say "we could
  /// not load your wallets" instead of silently showing one wallet as if it
  /// were all of them. Never throws.
  static Future<List<accounts_pb.AccountSummary>?> activeAccountsIn(
      String currency) async {
    final wanted = currency.trim().toUpperCase();
    if (wanted.isEmpty) return null;
    try {
      final client = serviceLocator<accounts_grpc.AccountsServiceClient>();
      final options = await serviceLocator<GrpcCallOptionsHelper>().withAuth();
      final response = await client.getUserAccounts(
        // Same trap as above: the default response is locale-currency only.
        accounts_pb.GetUserAccountsRequest(includeAllCurrencies: true),
        options: options,
      );

      // `uuid` is the account identifier analytics keys on; `id` is an
      // internal numeric surrogate and is NOT what the ledger references.
      final out = response.accounts
          .where((a) =>
              a.currency.toUpperCase() == wanted &&
              a.status == 'active' &&
              a.uuid.isNotEmpty)
          .toList();
      out.sort((a, b) => b.balance.compareTo(a.balance));
      return out;
    } catch (_) {
      return null;
    }
  }
}
