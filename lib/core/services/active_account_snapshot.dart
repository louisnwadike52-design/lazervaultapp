library;

import 'package:lazervault/core/services/account_manager.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/src/features/account_cards_summary/cubit/account_cards_summary_cubit.dart';
import 'package:lazervault/src/features/account_cards_summary/cubit/account_cards_summary_state.dart';
import 'package:lazervault/src/features/account_cards_summary/domain/entities/account_summary_entity.dart';

/// The account money is being spent FROM right now, with its real balance.
///
/// WHY THIS EXISTS
/// ---------------
/// `AccountManager.activeAccountDetails` is a field nothing in the app ever
/// writes. `setActiveAccountDetails` and `updateAccountDetails` have zero
/// callers, so the getter returns null on every screen, for every user,
/// always. Fifteen-odd places read it, and each one silently takes its
/// fallback branch.
///
/// In LazerSpray that is visible as money the user does not have: the Buy
/// Gifts sheet reads `details?.balance` for the figure it prints, gets null,
/// and renders "Personal Account — NGN 0" over an account with money in it.
/// The Fund Wallet sheet takes the same branch and shows no balance at all,
/// so a user funding ₦5,000 learns whether they could afford it from the
/// failure.
///
/// The live source is the one the dashboard itself draws from: the account
/// cards summary cubit, holding `AccountSummaryEntity` rows refreshed on
/// login, on balance events and on pull-to-refresh. This resolves the active
/// id against that list.
///
/// UNITS
/// -----
/// `AccountSummaryEntity` balances are MAJOR units (naira), unlike the kobo
/// used across the payment paths. [balanceMajor] keeps that explicit in the
/// name so a caller cannot divide by 100 twice — which is the other way this
/// figure goes wrong.
class ActiveAccountSnapshot {
  /// The id a debit must be issued against.
  ///
  /// For a family pot this is the spending (virtual) account, not the group
  /// id — debiting the group id fails server-side.
  final String id;

  /// "Personal •••• 1234" — ready to print.
  final String display;

  /// The wallet's own currency, not a global default.
  final String currency;

  /// Spendable balance in MAJOR units, net of holds and clearing.
  final double balanceMajor;

  /// Full NUBAN, or empty when the wallet has not been provisioned one.
  ///
  /// Needed by the surfaces that have to EXCLUDE the sender from a recipient
  /// list — a batch transfer that lets you pay yourself is a round trip that
  /// costs a fee and moves nothing.
  final String accountNumber;

  /// Last four digits, always present even when the full number is not.
  final String accountNumberLast4;

  /// Frozen, suspended or closed: a debit will be refused.
  final bool isSpendable;

  /// A family pot whose real-money wallet has not finished provisioning. The
  /// id resolves, but nothing can be spent from it yet.
  final bool isProvisioning;

  const ActiveAccountSnapshot({
    required this.id,
    required this.display,
    required this.currency,
    required this.balanceMajor,
    required this.accountNumber,
    required this.accountNumberLast4,
    required this.isSpendable,
    required this.isProvisioning,
  });

  /// Whether [amountMajor] can actually be taken from this account.
  bool covers(double amountMajor) =>
      isSpendable && !isProvisioning && balanceMajor >= amountMajor;
}

/// Resolve the active account from live state, or null when nothing is
/// selected yet.
///
/// Falls back to the first account in the list when the active id matches
/// none — switching region filters the carousel by currency without
/// re-pointing AccountManager, so a stale id is normal rather than
/// exceptional, and showing the first wallet beats showing zero.
///
/// Never throws: every surface that calls this is a money sheet mid-open, and
/// a thrown exception there is a blank bottom sheet.
ActiveAccountSnapshot? activeAccountSnapshot() {
  try {
    final summaries = _summaries();
    if (summaries.isEmpty) return null;

    final activeId = serviceLocator<AccountManager>().activeAccountId;
    AccountSummaryEntity? match;
    for (final a in summaries) {
      if (a.id == activeId || a.spendingAccountId == activeId) {
        match = a;
        break;
      }
    }
    match ??= summaries.first;
    return snapshotOf(match);
  } catch (_) {
    return null;
  }
}

/// Resolve the active account, FETCHING the summaries first if they are not
/// loaded yet.
///
/// [activeAccountSnapshot] is synchronous: it reads
/// AccountCardsSummaryCubit's current state and answers null whenever that
/// cubit has not loaded. Which surfaces have loaded it is an accident of
/// navigation — the dashboard does, so a money sheet reached from the
/// dashboard resolves an account and the SAME sheet reached directly does
/// not. Lazerspray's funding sheet was reported stuck on "No account
/// selected" for exactly that reason: its own balance rendered fine from its
/// own repository, above a source-account row that could never resolve.
///
/// Use this from any sheet that needs an account to ACT on. Use the
/// synchronous form only where null degrades harmlessly (a currency
/// fallback, say).
///
/// Best-effort: returns whatever it can and never throws. A fetch failure
/// yields null, exactly as before, and the server still validates.
Future<ActiveAccountSnapshot?> ensureActiveAccountSnapshot() async {
  final existing = activeAccountSnapshot();
  if (existing != null) return existing;
  try {
    final userId = serviceLocator<AuthenticationCubit>().userId ?? '';
    if (userId.isEmpty) return null;
    await serviceLocator<AccountCardsSummaryCubit>()
        .fetchAccountSummaries(userId: userId, silent: true);
  } catch (_) {
    return null;
  }
  return activeAccountSnapshot();
}

/// The PERSONAL wallet, regardless of which account the dashboard has active.
///
/// Some flows are not "spend from whatever is selected" — they always draw on
/// the user's own main wallet. Lazerspray funding is one: you top up a spray
/// balance from your personal money, and having it silently follow a savings
/// or campaign selection on the dashboard is both surprising and, for a
/// savings wallet, a debit the payment path may refuse outright.
///
/// Falls back to the ordinary active account when the user genuinely has no
/// personal wallet (a business-only profile). Blocking there would strand a
/// user who has money and nothing wrong with them, and the server still
/// validates the debit either way.
///
/// Returns null only when no accounts are loaded at all — use
/// [ensurePersonalAccountSnapshot] from a sheet that needs to act.
ActiveAccountSnapshot? personalAccountSnapshot() {
  try {
    final summaries = _summaries();
    if (summaries.isEmpty) return null;
    for (final a in summaries) {
      if (a.isPersonalAccount && a.status.toLowerCase() == 'active') {
        return snapshotOf(a);
      }
    }
    // A frozen/closed personal wallet still beats silently charging a
    // different one: show it, and let the spendable guards refuse.
    for (final a in summaries) {
      if (a.isPersonalAccount) return snapshotOf(a);
    }
    return activeAccountSnapshot();
  } catch (_) {
    return null;
  }
}

/// [personalAccountSnapshot], fetching the summaries first if they are not
/// loaded. See [ensureActiveAccountSnapshot] for why that is necessary.
Future<ActiveAccountSnapshot?> ensurePersonalAccountSnapshot() async {
  final existing = personalAccountSnapshot();
  if (existing != null) return existing;
  try {
    final userId = serviceLocator<AuthenticationCubit>().userId ?? '';
    if (userId.isEmpty) return null;
    await serviceLocator<AccountCardsSummaryCubit>()
        .fetchAccountSummaries(userId: userId, silent: true);
  } catch (_) {
    return null;
  }
  return personalAccountSnapshot();
}

/// Build a snapshot from a summary row. Exposed so a caller that already has
/// the entity (a picker, say) does not have to go back through the locator.
ActiveAccountSnapshot snapshotOf(AccountSummaryEntity a) {
  // availableBalance is balance less reserved and clearing. It can legitimately
  // be 0 on a wallet with a positive balance — every naira held — so it is
  // used as-is rather than falling back to `balance`, which would promise
  // money the payment path will refuse.
  final spendable = a.availableBalance;
  final last4 = a.accountNumberLast4;
  final label = a.accountTypeEnum.displayName;
  return ActiveAccountSnapshot(
    id: a.spendingAccountId,
    display: last4.isEmpty ? label : '$label •••• $last4',
    currency: a.currency.isNotEmpty ? a.currency : 'NGN',
    balanceMajor: spendable,
    accountNumber: a.accountNumber ?? '',
    accountNumberLast4: last4,
    isSpendable: a.status.toLowerCase() == 'active',
    isProvisioning: a.isFamilyWalletProvisioning,
  );
}

List<AccountSummaryEntity> _summaries() {
  final state = serviceLocator<AccountCardsSummaryCubit>().state;
  return switch (state) {
    AccountCardsSummaryLoaded(:final accountSummaries) => accountSummaries,
    AccountBalanceUpdated(:final accountSummaries) => accountSummaries,
    _ => const <AccountSummaryEntity>[],
  };
}
