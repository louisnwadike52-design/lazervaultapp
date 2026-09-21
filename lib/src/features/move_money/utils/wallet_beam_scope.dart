/// Which transfers belong on LazerBeam's "LazerVault Wallet" tab.
///
/// The tab called `getPaymentHistory(accountId)` with no filter at all, so it
/// listed EVERY payment made from that account — money sent to other people
/// included — and painted it with Beam branding. A user looking at "my wallet
/// moves" saw transfers that had nothing to do with LazerBeam.
///
/// A wallet beam is a move between two of the user's OWN LazerVault wallets.
/// That is a property of the data, not a label someone has to remember to
/// stamp: the destination account is already on the wire, and it belongs to the
/// user precisely when the transfer was a wallet move. So the scope is derived
/// rather than marked, which means it is also correct for every transfer
/// already in history — nothing needs backfilling.
///
/// Deliberately NOT done with a `metadata.channel` marker: that needs a new
/// proto field plumbed through four services on a money path, and it could only
/// ever label transfers made AFTER it shipped.
///
/// WHY THE IDENTITY SET IS BUILT HERE
/// ----------------------------------
/// The first version keyed only on `AccountSummaryEntity.accountNumber` — the
/// full NUBAN, which is NULLABLE and only present once a virtual account has
/// been provisioned. For a user whose accounts had no NUBAN the set came back
/// empty, and an empty set falls through to "return everything unfiltered" —
/// so the tab was still showing every payment, which is exactly the bug the
/// filter was added to fix. Building the set in one place, from every identity
/// an account actually carries, is what stops that recurring.
library;

// The parent library — `..._widgets.dart` is a `part of` this and cannot be
// imported directly.
import '../../funds/data/datasources/payments_transfer_data_source.dart';

/// The account identities a beam can be matched against.
///
/// Two levels, because accounts do not all carry the same fields:
///   - [full] NUBANs, matched exactly. Always preferred.
///   - [last4] suffixes, the fallback for accounts with no full number.
class WalletBeamIdentities {
  final Set<String> full;
  final Set<String> last4;

  const WalletBeamIdentities({this.full = const {}, this.last4 = const {}});

  static const empty = WalletBeamIdentities();

  bool get isEmpty => full.isEmpty && last4.isEmpty;
}

class WalletBeamScope {
  const WalletBeamScope._();

  /// Normalise an account number for comparison: digits only.
  ///
  /// The same account arrives formatted differently depending on the writer
  /// ("0279098300", "027 909 8300"), and a string mismatch here would silently
  /// empty the tab — a failure indistinguishable from "no transfers yet", which
  /// is exactly the kind of bug that hides.
  static String _digits(String? v) =>
      (v ?? '').replaceAll(RegExp(r'[^0-9]'), '');

  /// Builds the identity set from whatever the account summaries carry.
  ///
  /// [fullNumbers] are nullable NUBANs; [last4s] are the always-present
  /// four-digit suffixes. Callers pass both and let this decide what is usable,
  /// rather than each screen reimplementing the fallback and getting it wrong
  /// in a different way.
  static WalletBeamIdentities identities({
    required Iterable<String?> fullNumbers,
    required Iterable<String?> last4s,
  }) {
    final full = <String>{};
    for (final n in fullNumbers) {
      final d = _digits(n);
      // A "full" number shorter than five digits is a last-4 in disguise and
      // would match far too much if treated as exact.
      if (d.length >= 5) full.add(d);
    }
    final suffixes = <String>{};
    for (final n in last4s) {
      final d = _digits(n);
      if (d.length == 4) suffixes.add(d);
    }
    // A full number also yields a usable suffix, so an account with a NUBAN
    // still matches a counterparty recorded only by its last four.
    for (final f in full) {
      suffixes.add(f.substring(f.length - 4));
    }
    return WalletBeamIdentities(full: full, last4: suffixes);
  }

  /// True when [transfer] moved money between the user's own wallets.
  static bool isWalletMove(
    PaymentsTransferResult transfer,
    WalletBeamIdentities ids,
  ) {
    if (ids.isEmpty) return false;
    final dest = _digits(transfer.counterpartyAccount);
    if (dest.isEmpty) return false;

    // Exact match first — unambiguous.
    if (ids.full.contains(dest)) return true;

    // Suffix fallback, ONLY when we have no full number to compare against.
    // Using it alongside exact matching would let a stranger's account whose
    // last four happen to collide with the user's be claimed as a wallet move;
    // restricting it to the no-NUBAN case keeps that risk where there is no
    // better signal available at all.
    if (ids.full.isEmpty && dest.length >= 4) {
      return ids.last4.contains(dest.substring(dest.length - 4));
    }
    return false;
  }

  /// Keep only the user's own wallet-to-wallet moves.
  ///
  /// When the identity set is EMPTY the list is returned unchanged: we cannot
  /// judge, and showing slightly too much beats a confident, wrong "no
  /// transfers yet". That path should now be unreachable in practice —
  /// [identities] derives suffixes from `accountNumberLast4`, which is
  /// non-nullable — and that is the point: it used to be reached on every
  /// account without a NUBAN, which is why the tab still showed everything.
  static List<PaymentsTransferResult> filter(
    List<PaymentsTransferResult> transfers,
    WalletBeamIdentities ids,
  ) {
    if (ids.isEmpty) return transfers;
    return transfers
        .where((t) => isWalletMove(t, ids))
        .toList(growable: false);
  }
}
