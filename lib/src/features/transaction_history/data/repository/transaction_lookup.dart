/// Finding ONE transaction when all you have is an identifier someone else
/// minted.
///
/// A notification deep link carries `transaction_id`, `entity_id`, `reference`
/// or `reference_id`, and which of those a given publisher sets is not
/// something the app gets to decide — thirty-odd services emit notifications
/// and they do not agree. Worse, the SAME money movement is keyed differently
/// by the services that record it: accounts-service stores a reference that is
/// also its idempotency marker (`IDEM-CR-SPRAY-WD-<uuid>`), utility-payments
/// reserves under `HOLD-<business ref>`, a credit leg can carry a `-CR`
/// suffix, and a settled external transfer sits under `HOLD-CAP-<reserveId>`
/// with the originating reference only in `metadata.reference`.
///
/// So an exact string compare against `id` finds almost nothing. These helpers
/// compare the NORMALISED forms of every identifier a row carries, which is
/// what makes a tapped push able to open the actual receipt instead of the
/// service's history list.
///
/// Pure by design — no gRPC client, no account manager, no storage — so the
/// matching rules can be tested without constructing any of those. Same reason
/// `external_transfer_merge.dart` lives beside it.
library;

import 'package:lazervault/core/types/unified_transaction.dart';

/// Normalises an identifier to the form two sources can be compared in.
///
/// Uppercases (references are upper-prefixed; ids are lowercase hex, and
/// uppercasing BOTH sides keeps equality intact either way), drops the `-CR`
/// credit-leg suffix, and strips the internal `HOLD-` / `IDEM-XX-` prefixes
/// that are dedup keys rather than identities.
///
/// `HOLD-CAP-` is deliberately NOT stripped: that is a settlement row in its
/// own right, it is what `external_transfer_merge` keys on, and collapsing it
/// to its reserve id would make two different rows compare equal.
String normalizeTransactionRef(String raw) {
  var s = raw.trim().toUpperCase();
  if (s.isEmpty) return s;
  if (s.endsWith('-CR')) s = s.substring(0, s.length - 3);
  if (!s.startsWith('HOLD-CAP')) {
    if (s.startsWith('HOLD-')) {
      final stripped = s.substring(5).trim();
      if (stripped.isNotEmpty) s = stripped;
    }
    final idem = RegExp(r'^IDEM-[A-Z]+-');
    if (idem.hasMatch(s)) {
      final stripped = s.replaceFirst(idem, '').trim();
      if (stripped.isNotEmpty) s = stripped;
    }
  }
  return s;
}

/// Every identifier [tx] can legitimately be addressed by, normalised.
///
/// Metadata is included because it is often the ONLY place the originating
/// reference survives: a `HOLD-CAP` ledger row's own reference is the reserve
/// id, and the reference the notification quoted is in `metadata.reference`.
Set<String> transactionRefCandidates(UnifiedTransaction tx) {
  final out = <String>{};
  void add(Object? v) {
    if (v == null) return;
    final s = v.toString().trim();
    if (s.isEmpty) return;
    out.add(normalizeTransactionRef(s));
  }

  add(tx.id);
  add(tx.transactionReference);
  add(tx.displayReference);
  final meta = tx.metadata;
  if (meta != null) {
    for (final k in const [
      'reference',
      'transaction_id',
      'transaction_reference',
      'external_reference',
      'provider_reference',
      'payment_reference',
      'session_id',
    ]) {
      add(meta[k]);
    }
  }
  out.remove('');
  return out;
}

/// Whether [tx] is the transaction [needle] names.
bool transactionMatches(UnifiedTransaction tx, String needle) {
  final n = normalizeTransactionRef(needle);
  if (n.isEmpty) return false;
  return transactionRefCandidates(tx).contains(n);
}

/// The first row in [rows] that [needle] names, or null.
///
/// Returns the first match rather than asserting uniqueness on purpose: an
/// internal transfer has a debit leg and a credit leg under derived references,
/// and whichever the caller is looking at is the one they were sent to. Rows
/// arrive newest-first, so the first match is also the freshest.
UnifiedTransaction? findTransaction(
  Iterable<UnifiedTransaction> rows,
  String needle,
) {
  final n = normalizeTransactionRef(needle);
  if (n.isEmpty) return null;
  for (final tx in rows) {
    if (transactionRefCandidates(tx).contains(n)) return tx;
  }
  return null;
}
