import 'package:lazervault/core/services/grpc_call_options_helper.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/src/generated/accounts.pb.dart' as accounts_pb;
import 'package:lazervault/src/generated/accounts.pbgrpc.dart' as accounts_grpc;

/// The user's spendable balance per currency, for the exchange screen.
///
/// ONE source for both the balance SHOWN beside each currency and the balance
/// the pre-flight validator checks. They were about to be two reads of the
/// same thing, which is how a screen comes to offer a MAX the next step
/// refuses — and the backend had just been bitten by exactly that shape, with
/// the quoted margin and the booked margin resolved from different places.
class ExchangeWalletBalances {
  const ExchangeWalletBalances(this._byCurrencyMinor);

  const ExchangeWalletBalances.empty() : _byCurrencyMinor = const {};

  /// Highest ACTIVE balance per currency, in minor units.
  ///
  /// Highest rather than summed: a conversion debits ONE account, so the most
  /// that can be spent is the largest single balance. Summing would offer a
  /// MAX that no single wallet can cover. This mirrors `_validateBalance`,
  /// which picks the same account.
  final Map<String, int> _byCurrencyMinor;

  bool get isEmpty => _byCurrencyMinor.isEmpty;

  /// Minor units held in [currency], or null when the user has no active
  /// account in it — which is different from holding zero, and reads
  /// differently in the UI.
  int? minorFor(String currency) => _byCurrencyMinor[currency.toUpperCase()];

  /// Major units held in [currency]; 0 when none.
  double majorFor(String currency) => (minorFor(currency) ?? 0) / 100.0;

  /// The most that can be converted out of [currency] after [feeMajor].
  ///
  /// The platform's margin is inside the rate, not added on top, so it must
  /// NOT be subtracted here — the user converts their whole balance and
  /// receives the margin-adjusted amount. Only an explicit service fee (off
  /// by default) is deducted, because that genuinely leaves the balance on
  /// top of the amount.
  double maxSpendableMajor(String currency, {double feeMajor = 0}) {
    final available = majorFor(currency) - (feeMajor > 0 ? feeMajor : 0);
    if (available <= 0) return 0;
    // Floor to the minor unit. Rounding UP by a fraction of a cent is enough
    // to make the debit exceed the balance and fail at the ledger.
    return (available * 100).floorToDouble() / 100;
  }

  /// Read every currency the user holds, not just the locale's.
  ///
  /// `includeAllCurrencies` is load-bearing: the default response carries only
  /// locale-currency accounts, so a Naira-locale user exchanging FROM dollars
  /// reads as a zero balance.
  static Future<ExchangeWalletBalances> fetch() async {
    try {
      final client = serviceLocator<accounts_grpc.AccountsServiceClient>();
      final options = await serviceLocator<GrpcCallOptionsHelper>().withAuth();
      final response = await client.getUserAccounts(
        accounts_pb.GetUserAccountsRequest(includeAllCurrencies: true),
        options: options,
      );
      final out = <String, int>{};
      for (final account in response.accounts) {
        if (account.status != 'active') continue;
        final code = account.currency.toUpperCase();
        if (code.isEmpty) continue;
        final minor = account.balance.toInt();
        final existing = out[code];
        if (existing == null || minor > existing) out[code] = minor;
      }
      return ExchangeWalletBalances(out);
    } catch (_) {
      // Never block the screen on this. An unknown balance renders as unknown
      // and MAX hides itself; the backend remains the authority on funds.
      return const ExchangeWalletBalances.empty();
    }
  }
}
