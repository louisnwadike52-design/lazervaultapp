import 'package:flutter/material.dart';

// CanonicalStatus (PR8) — single normalised enum for every Quidax status
// string the crypto feature might render. Quidax mixes case across object
// kinds (`Done`/`Processing`/`Rejected` capitalised for withdrawals; lowercase
// `done`/`pending`/`failed` for swaps + orders + deposits). All screens
// flow through this helper so the UI is consistent.

enum CanonicalStatus {
  pending,
  processing,
  completed,
  failed,
  reversed,
  refunded,
  onHold,
  awaitingAML,
  rejected,
  confirmed,
  accepted,
  manualReview,
  cancelled,
  unknown,
}

// StatusKind disambiguates the small number of strings Quidax overloads
// (e.g. `pending` means quote-pending for swaps, but submitted-deposit for
// deposits). Optional — callers can supply `unknown` and we'll do best-effort.
enum StatusKind { swap, deposit, withdraw, order, rollback, unknown }

CanonicalStatus normalizeQuidaxStatus(String raw, [StatusKind kind = StatusKind.unknown]) {
  final r = raw.trim().toLowerCase();
  if (r.isEmpty) return CanonicalStatus.unknown;

  // Universal terminal states. Quidax uses lowercase for orders/swaps and
  // capitalised for withdrawals — both arrive here lowercased.
  switch (r) {
    case 'done':
    case 'completed':
      return CanonicalStatus.completed;
    case 'accepted':
      return CanonicalStatus.accepted;
    case 'checked':
      // Internal-deposit terminal — display as completed.
      return CanonicalStatus.completed;
    case 'confirmed':
      return CanonicalStatus.confirmed;
    case 'rejected':
    case 'failed':
      return CanonicalStatus.rejected;
    case 'reversed':
      return CanonicalStatus.reversed;
    case 'refunded':
      return CanonicalStatus.refunded;
    case 'on_hold':
      return CanonicalStatus.onHold;
    case 'failed_aml':
      return CanonicalStatus.awaitingAML;
    case 'manual_review':
      return CanonicalStatus.manualReview;
    case 'cancel':
    case 'cancelled':
      return CanonicalStatus.cancelled;
    case 'processing':
    case 'wait':
    case 'submitted':
      return CanonicalStatus.processing;
    case 'pending':
    case 'quote_pending':
    case 'swap_pending':
    case 'confirm':
    case 'refund_pending':
      return CanonicalStatus.pending;
  }
  return CanonicalStatus.unknown;
}

// Locale-aware display label. PR8 ships English; PR8b can layer translations
// via LocaleManager when content team supplies copy.
String displayLabel(CanonicalStatus s) {
  switch (s) {
    case CanonicalStatus.pending:
      return 'Pending';
    case CanonicalStatus.processing:
      return 'Processing';
    case CanonicalStatus.completed:
      return 'Completed';
    case CanonicalStatus.failed:
      return 'Failed';
    case CanonicalStatus.reversed:
      return 'Reversed';
    case CanonicalStatus.refunded:
      return 'Refunded';
    case CanonicalStatus.onHold:
      return 'On hold';
    case CanonicalStatus.awaitingAML:
      return 'AML review';
    case CanonicalStatus.rejected:
      return 'Rejected';
    case CanonicalStatus.confirmed:
      return 'Confirming';
    case CanonicalStatus.accepted:
      return 'Received';
    case CanonicalStatus.manualReview:
      return 'Manual review';
    case CanonicalStatus.cancelled:
      return 'Cancelled';
    case CanonicalStatus.unknown:
      return 'Unknown';
  }
}

// Dark-theme palette aligned with the LazerVault UI conventions.
Color statusColor(CanonicalStatus s) {
  switch (s) {
    case CanonicalStatus.completed:
    case CanonicalStatus.accepted:
    case CanonicalStatus.confirmed:
      return const Color(0xFF10B981); // emerald
    case CanonicalStatus.failed:
    case CanonicalStatus.rejected:
      return const Color(0xFFEF4444); // red
    case CanonicalStatus.reversed:
    case CanonicalStatus.refunded:
      return const Color(0xFFFB923C); // orange
    case CanonicalStatus.onHold:
    case CanonicalStatus.awaitingAML:
      return const Color(0xFFFBBF24); // amber
    case CanonicalStatus.manualReview:
      return const Color(0xFFA78BFA); // purple
    case CanonicalStatus.pending:
    case CanonicalStatus.processing:
      return const Color(0xFF3B82F6); // blue
    case CanonicalStatus.cancelled:
    case CanonicalStatus.unknown:
      return const Color(0xFF9CA3AF); // gray
  }
}

/// Convenience: raw wire string → renderable widget data in one call.
({String label, Color color}) renderQuidaxStatus(String raw,
    [StatusKind kind = StatusKind.unknown]) {
  final c = normalizeQuidaxStatus(raw, kind);
  return (label: displayLabel(c), color: statusColor(c));
}
