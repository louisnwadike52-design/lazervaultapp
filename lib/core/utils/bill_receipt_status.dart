library;

/// The ONE place a bill receipt's status becomes words.
///
/// WHAT WENT WRONG
/// ---------------
/// A refunded data purchase showed "Refunded" on the receipt screen and
/// "Failed" in the shared PDF — the same transaction, two different answers,
/// and the one the customer forwards to somebody else was the wrong one.
///
/// The screen read `DataPurchaseEntity.displayStatus`, which knows that a row
/// stored as `failed` with a `refund_source` is a REFUND. The PDF read the raw
/// `status` column and title-cased it. Two renderings of the same field, and
/// only one of them had the rule.
///
/// Cable TV, Internet and Water PDFs all had the same raw-status call, so the
/// same divergence was waiting in each of them.
///
/// THE RULE
/// --------
/// `failed` + any sign the money came back = **Refunded**. The backend keeps
/// the row as `failed` because the PURCHASE failed — that is correct and must
/// not change — but what the customer needs to read is whether they have their
/// money. "Failed" on a receipt for ₦260 they already have back is the version
/// that generates a support ticket.
///
/// NOTHING HERE IS HARDCODED. Every input is a field the backend actually
/// sent; when none of them indicate a refund the raw status is formatted as-is
/// rather than guessed at.

/// Canonical, user-facing label for a bill payment.
///
/// [rawStatus] is the backend's own status column. [refundSource],
/// [refundedAt] and [isRefunded] are the refund signals — pass whichever the
/// entity actually carries, and leave the rest null.
String billReceiptStatusLabel(
  String? rawStatus, {
  String? refundSource,
  DateTime? refundedAt,
  bool? isRefunded,
}) {
  final raw = (rawStatus ?? '').trim();
  if (raw.isEmpty) return 'Unknown';

  final lower = raw.toLowerCase();

  // An explicit refunded status always wins, whatever else is set.
  if (lower == 'refunded' || lower == 'reversed') return 'Refunded';

  if (_moneyCameBack(refundSource: refundSource, refundedAt: refundedAt, isRefunded: isRefunded)) {
    // Only a FAILED row is promoted. A completed purchase with a refund
    // signal is a partial or a later reversal and is not this function's to
    // reinterpret — showing "Refunded" over a delivered bundle would be the
    // opposite mistake.
    if (lower == 'failed' || lower == 'cancelled' || lower == 'canceled') {
      return 'Refunded';
    }
  }

  return _titleCase(raw);
}

/// Whether any field says the money was returned.
bool _moneyCameBack({
  String? refundSource,
  DateTime? refundedAt,
  bool? isRefunded,
}) {
  if (isRefunded == true) return true;
  if (refundedAt != null) return true;
  final src = (refundSource ?? '').trim();
  // Any non-empty refund_source means a refund path ran. The backend writes
  // things like "epins_failed", "vtpass_declined", "hold_released" — an
  // open vocabulary, so presence is the signal rather than a match against a
  // list that would silently stop recognising the next one.
  return src.isNotEmpty && src.toLowerCase() != 'none';
}

/// "awaiting_webhook" → "Awaiting Webhook".
String _titleCase(String s) => s
    .split(RegExp(r'[_\s]+'))
    .where((w) => w.isNotEmpty)
    .map((w) => w[0].toUpperCase() + w.substring(1).toLowerCase())
    .join(' ');

/// Whether [label] (from [billReceiptStatusLabel]) means the customer has
/// their money back.
///
/// Receipts colour and word themselves off this rather than re-deriving the
/// rule, so the badge and the line can never disagree.
bool isRefundLabel(String label) => label.toLowerCase() == 'refunded';
