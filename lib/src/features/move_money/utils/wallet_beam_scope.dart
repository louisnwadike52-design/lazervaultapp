/// Which transfers belong on LazerBeam's "LazerVault Wallet" tab.
///
/// The tab called `getPaymentHistory(accountId)` with no filter at all, so it
/// listed EVERY payment made from that account — money sent to other people
/// included — and painted it with Beam branding. A user looking at "my wallet
/// moves" saw transfers that had nothing to do with LazerBeam.
///
/// A wallet beam is a move between two of the user's OWN LazerVault wallets.
/// That is a property of the data, not a label someone has to remember to
/// stamp: the destination account number is already on the wire, and it
/// belongs to the user precisely when the transfer was a wallet move. So the
/// scope is derived rather than marked, which means it is also correct for
/// every transfer already in history — nothing needs backfilling.
///
/// Deliberately NOT done with a `metadata.channel` marker: that needs a new
/// proto field plumbed through four services on a money path, and it could
/// only ever label transfers made AFTER it shipped.
library;

// The parent library — `..._widgets.dart` is a `part of` this and cannot be
// imported directly.
import '../../funds/data/datasources/payments_transfer_data_source.dart';

class WalletBeamScope {
  const WalletBeamScope._();

  /// Normalise an account number for comparison: digits only.
  ///
  /// The same account arrives formatted differently depending on the writer
  /// ("0279098300", "027 909 8300"), and a string mismatch here would silently
  /// empty the tab — the failure mode is indistinguishable from "no transfers
  /// yet", which is exactly the kind of bug that hides.
  static String _digits(String? v) =>
      (v ?? '').replaceAll(RegExp(r'[^0-9]'), '');

  /// True when [transfer] moved money between the user's own wallets.
  static bool isWalletMove(
    PaymentsTransferResult transfer,
    Set<String> ownAccountNumbers,
  ) {
    if (ownAccountNumbers.isEmpty) return false;
    final dest = _digits(transfer.counterpartyAccount);
    if (dest.isEmpty) return false;
    return ownAccountNumbers.contains(dest);
  }

  /// Keep only the user's own wallet-to-wallet moves.
  ///
  /// [ownAccountNumbers] should be every LazerVault account number the user
  /// holds. When it is EMPTY the list is returned unchanged rather than
  /// emptied: an unknown set of accounts means we cannot judge, and showing
  /// slightly too much beats showing a confident, wrong "no transfers yet".
  static List<PaymentsTransferResult> filter(
    List<PaymentsTransferResult> transfers,
    Set<String> ownAccountNumbers,
  ) {
    if (ownAccountNumbers.isEmpty) return transfers;
    final normalised =
        ownAccountNumbers.map(_digits).where((s) => s.isNotEmpty).toSet();
    if (normalised.isEmpty) return transfers;
    return transfers
        .where((t) => isWalletMove(t, normalised))
        .toList(growable: false);
  }
}
