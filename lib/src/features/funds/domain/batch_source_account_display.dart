import 'package:lazervault/core/services/account_summaries_store.dart';
import 'package:lazervault/src/features/account_cards_summary/domain/entities/account_summary_entity.dart';

/// WHICH ACCOUNT PAID FOR THIS BATCH, DESCRIBED HONESTLY.
///
/// The batch detail showed `source_account_name` on its own, which the server
/// reads from `accounts.account_name`. That column is frozen at mint time and
/// is NOT updated when a wallet's virtual account is re-minted onto another
/// rail: after the Flutterwave to Nomba switch it still says "Praiz Onah FLW"
/// for a number Nomba now issues. So every batch, on every provider, was
/// described by whichever rail happened to mint the account first.
///
/// The correct per-rail holder name already exists on the device as
/// `AccountSummaryEntity.virtualAccountHolderName`, projected by
/// accounts-service from `account_virtual_accounts.account_name` for the
/// account's ACTIVE provider. Being derived, it follows a rail switch with no
/// backfill — which is exactly the property this display needed.
///
/// Resolved from the local store rather than by adding fields to the batch
/// response: the data is already on the phone, it is the same source the
/// dashboard card and the account-details sheet read, so the three cannot
/// disagree about one account, and it needs no contract change.
class BatchSourceAccountDisplay {
  /// What the user calls this wallet: their own label if they set one, else
  /// the account type's name ("Personal", "Family & Friends").
  final String label;

  /// The name on the account at the rail currently issuing its number. Falls
  /// back to the server's value when the account is not on the device.
  final String holder;

  /// The bank behind the provider actually in use. Empty when unknown.
  final String bankName;

  /// False when the account could not be found locally, so the caller knows
  /// the holder name is the server's frozen value rather than the live one.
  final bool resolvedLocally;

  const BatchSourceAccountDisplay({
    required this.label,
    required this.holder,
    required this.bankName,
    required this.resolvedLocally,
  });
}

/// Last four digits, for matching a full NUBAN against a summary that may
/// only carry the masked tail.
String _last4(String v) {
  final digits = v.replaceAll(RegExp(r'\D'), '');
  if (digits.length <= 4) return digits;
  return digits.substring(digits.length - 4);
}

/// Resolve the display for a batch's source account.
///
/// [accounts] is injectable for tests; in the app it defaults to the same
/// static store the dashboard publishes into.
BatchSourceAccountDisplay batchSourceAccountDisplay({
  required String sourceAccountNumber,
  required String sourceAccountName,
  List<AccountSummaryEntity>? accounts,
}) {
  final rows = accounts ?? AccountSummariesStore.rows();
  final wanted = sourceAccountNumber.trim();

  AccountSummaryEntity? match;
  if (wanted.isNotEmpty) {
    for (final a in rows) {
      final full = (a.accountNumber ?? '').trim();
      if (full.isNotEmpty && full == wanted) {
        match = a;
        break;
      }
    }
    // Fall back to the tail. The batch response carries a full NUBAN while a
    // summary may only have been given the masked last four, and refusing to
    // match on that would send a perfectly identifiable account down the
    // unresolved path.
    if (match == null) {
      final tail = _last4(wanted);
      if (tail.length == 4) {
        for (final a in rows) {
          if (_last4(a.accountNumberLast4) == tail ||
              _last4(a.accountNumber ?? '') == tail) {
            match = a;
            break;
          }
        }
      }
    }
  }

  if (match == null) {
    // Nothing local to improve on. The server's name is shown as-is rather
    // than invented, and `resolvedLocally: false` lets the caller omit a
    // label it cannot honestly supply.
    return BatchSourceAccountDisplay(
      label: '',
      holder: sourceAccountName.trim(),
      bankName: '',
      resolvedLocally: false,
    );
  }

  final custom = (match.accountLabel ?? '').trim();
  final typed = VirtualAccountType.fromString(match.accountType).displayName;
  final railHolder = (match.virtualAccountHolderName ?? '').trim();

  return BatchSourceAccountDisplay(
    label: custom.isNotEmpty ? custom : typed,
    // The rail's name first; the server's frozen value only when the rail has
    // not reported one yet (a wallet with no virtual account minted).
    holder: railHolder.isNotEmpty ? railHolder : sourceAccountName.trim(),
    bankName: (match.bankName ?? '').trim(),
    resolvedLocally: true,
  );
}
