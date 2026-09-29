import 'package:lazervault/core/types/unified_transaction.dart';

/// Collapse the two sources that both describe an external transfer.
///
/// accounts-service writes a LEDGER row for the hold — the money that actually
/// left the account, principal PLUS fee — keyed `HOLD-CAP-<reserveId>` in both
/// its pending and settled state. core-payments separately reports the PAYMENT,
/// keyed `TRF-…`, and it is the only side that knows who was paid.
///
/// Without this collapse the user sees one transfer as two unrelated entries.
/// Reported live: a single ₦200 transfer rendered as "Transfer Sent / External
/// transfer ₦223" and "Transfer to GRACE C. ON… ₦200", both pending.
///
/// The join key is the ORIGINATING reference. Only a `HOLD-CAP` row substitutes
/// `metadata.reference` for its own: every other ledger row keeps its own, so
/// unrelated rows that happen to share a metadata reference are never
/// over-collapsed.
///
/// Extracted from the repository because it is pure: no gRPC client, no
/// account manager, no storage. Testing it should not require constructing any
/// of those.
List<UnifiedTransaction> mergeExternalTransfers(
  List<UnifiedTransaction> ledger,
  List<UnifiedTransaction> external,
) {
  String keyFor(UnifiedTransaction tx) {
    final selfRef = tx.transactionReference ?? tx.id;
    final metaRef = (tx.metadata?['reference'] as String?)?.trim();
    final ref = (selfRef.startsWith('HOLD-CAP') &&
            metaRef != null &&
            metaRef.isNotEmpty)
        ? metaRef
        : selfRef;
    final base = ref.endsWith('-CR') ? ref.substring(0, ref.length - 3) : ref;
    return '${base}_${tx.flow.name}';
  }

  final byKey = <String, UnifiedTransaction>{};
  for (final tx in ledger) {
    byKey[keyFor(tx)] = tx;
  }
  for (final tx in external) {
    final key = keyFor(tx);
    final existing = byKey[key];
    if (existing == null) {
      byKey[key] = tx;
      continue;
    }
    // Same transfer, and each side knows something the other does not. The
    // ledger row wins on amount and status because it is the money that moved;
    // the payment row contributes the payee. Keeping the ledger row wholesale
    // left the user with "Transfer Sent / External transfer" and no recipient
    // anywhere, which is what made the two rows look unrelated.
    byKey[key] = existing.copyWith(
      counterpartyName: existing.counterpartyName?.isNotEmpty == true
          ? existing.counterpartyName
          : tx.counterpartyName,
      counterpartyAccount: existing.counterpartyAccount?.isNotEmpty == true
          ? existing.counterpartyAccount
          : tx.counterpartyAccount,
    );
  }
  return byKey.values.toList()
    ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
}
