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
/// Strip the suffixes that mark a row as one LEG of a transfer rather than a
/// transfer of its own.
///
/// `-CR` is the credit leg of an internal transfer.
///
/// `-EXEC` IS THE ONE THAT WAS MISSING, and it made a crypto-funded transfer
/// appear TWICE in history. Such a transfer writes two payment rows: the
/// authorising row at `TRF-…`, created when the customer chose to pay with
/// crypto and nothing had moved yet, and the execution at `TRF-…-EXEC`, which
/// runs once the conversion lands and is what actually debits the wallet. Both
/// are external, both are completed, and with different keys both were listed
/// — one transfer, two identical entries.
///
/// It also kept the breakdown off the receipt. core-payments records the
/// crypto/wallet split on the AUTHORISING row (that is where the funding event
/// meets the payment), while the ledger debit joins on the EXECUTION
/// reference. Collapsing them is what puts the split and the money that moved
/// on the same row.
String _baseReference(String ref) {
  for (final suffix in const ['-EXEC', '-CR']) {
    if (ref.endsWith(suffix)) {
      return ref.substring(0, ref.length - suffix.length);
    }
  }
  return ref;
}

/// The funding keys the payment row contributes to a merged row.
///
/// A CLOSED LIST, in step with core-payments' own projection. The ledger row
/// and the payment row describe the same transfer and disagree about
/// `reference` — that is the join key — so a blanket spread would re-key the
/// row and un-join it on the next merge. Naming the keys also means a new
/// field on the payment row cannot silently start overwriting ledger state.
///
/// `funding_source` is required: without it the receipt refuses to render a
/// breakdown, so the figures alone are keys nothing reads. Carrying them
/// anyway would invite a later "any funding_* key means crypto" reading, and
/// that is how an ordinary wallet payment comes to claim it was paid in coin.
Map<String, dynamic> _fundingKeys(Map<String, dynamic>? payment) {
  if (payment == null || payment.isEmpty) return const {};
  if ((payment['funding_source'] ?? '').toString().trim().isEmpty) {
    return const {};
  }
  const keys = [
    'funding_source',
    'funding_asset',
    'funding_crypto_minor',
    'funding_fiat_minor',
    'funding_total_minor',
    'funding_asset_amount',
  ];
  final out = <String, dynamic>{};
  for (final k in keys) {
    final v = payment[k];
    if (v != null) out[k] = v;
  }
  return out;
}

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
    return '${_baseReference(ref)}_${tx.flow.name}';
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
    // THE PRINCIPAL WAS BEING THROWN AWAY HERE.
    //
    // The ledger row's amount is principal PLUS fee — it is the money that
    // left the account — and it rightly wins the headline. But the payment row
    // is the ONLY place that knows the principal, and discarding it left the
    // receipt unable to say what the payee actually received.
    //
    // Measured on prod 2026-11-02: external transfers stored as 223, 523, 973,
    // 1123, 5023 — every one of them principal + a 23 fee, rendered as a
    // single figure with no breakdown. A sender who shares that receipt is
    // telling the recipient 223 arrived when 200 did.
    //
    // So both halves are carried forward and the receipt renders Amount sent /
    // Fee / Total paid. Stored in MAJOR units, matching UnifiedTransaction
    // .amount, because mixing naira and kobo in one metadata bag is how a
    // receipt comes to show a 100x figure.
    final total = existing.amount;
    final principal = tx.amount;
    final mergedMetadata = <String, dynamic>{
      ...?existing.metadata,
      // HOW IT WAS FUNDED COMES FROM THE PAYMENT ROW, AND ONLY FROM THERE.
      //
      // The ledger row is the money that moved; the payment row is the only
      // side that knows a crypto conversion paid for part of it. This merge
      // kept the ledger's metadata wholesale and dropped the payment's, so a
      // crypto-funded transfer's split was fetched by the app and thrown away
      // one line before anything could render it.
      //
      // Named keys rather than a blanket spread: the two sides disagree on
      // `reference` (the join key itself), and letting the payment row
      // overwrite the ledger's would re-key the row on the next merge.
      ..._fundingKeys(tx.metadata),
      // Only when the two sides genuinely disagree. When they match there is
      // no fee to report and inventing a zero row adds noise to every receipt.
      if (principal > 0 && total > principal) ...{
        'external_principal': principal,
        'external_fee': double.parse((total - principal).toStringAsFixed(2)),
      },
    };

    byKey[key] = existing.copyWith(
      counterpartyName: existing.counterpartyName?.isNotEmpty == true
          ? existing.counterpartyName
          : tx.counterpartyName,
      counterpartyAccount: existing.counterpartyAccount?.isNotEmpty == true
          ? existing.counterpartyAccount
          : tx.counterpartyAccount,
      metadata: mergedMetadata,
    );
  }
  return byKey.values.toList()
    ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
}
