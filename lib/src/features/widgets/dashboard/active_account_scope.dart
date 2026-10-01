library;

import 'package:lazervault/core/config/locale_gating.dart';
import 'package:lazervault/src/features/account_cards_summary/domain/entities/account_summary_entity.dart';

/// Which account is active RIGHT NOW, answered from live data.
///
/// WHY NOT THE EXISTING HELPER
/// ---------------------------
/// `AppServicesBuilder.activeAccountIsPersonal()` reads a static
/// (`_lastResolvedAccountType`) that is written as a SIDE EFFECT of the
/// quick-services grid rebuilding. The dashboard's communal rails live
/// outside that grid, in a subtree nothing re-runs when the account changes
/// — so after switching to a Savings account the static still said
/// `personal` and Trending crowdfunds / Public groups stayed on screen.
/// Reported twice.
///
/// A value that is only correct when some other widget happens to have
/// rebuilt is not a predicate. This one takes the summaries and the active
/// id as arguments, so it is correct whenever it is called and can be tested
/// without building a widget.
///
/// FAILS CLOSED
/// ------------
/// Unknown account → false. These rails invite someone to join a communal
/// Naira pot; showing one on an account that cannot join is the failure
/// worth avoiding, and they appear the moment the summaries load.

/// Whether [activeAccountId] identifies a PERSONAL wallet in [summaries].
bool activeAccountIsPersonalNow(
  List<AccountSummaryEntity>? summaries,
  String? activeAccountId,
) {
  if (summaries == null || summaries.isEmpty) return false;
  if (activeAccountId == null || activeAccountId.isEmpty) return false;

  for (final a in summaries) {
    // spendingAccountId is the id a family pot actually debits through, and
    // AccountManager may hold either — match both, as the family predicate
    // in the dashboard does.
    if (a.id != activeAccountId && a.spendingAccountId != activeAccountId) {
      continue;
    }
    // A wallet in another currency is not the active card: switching region
    // filters the carousel by currency without re-pointing AccountManager,
    // so a stale id can still match a row that is no longer on screen.
    if (!LocaleGating.accountCurrencyAllowed(a.currency)) return false;
    // A family pot can carry a non-family accountTypeEnum on some payloads,
    // so the explicit flag is checked first.
    if (a.isFamilyAccount) return false;
    return a.accountTypeEnum == VirtualAccountType.personal ||
        a.accountTypeEnum == VirtualAccountType.main;
  }
  return false;
}
