library;

import 'package:intl/intl.dart';

/// THE invoice receipt field set — one definition, every surface.
///
/// WHY THIS EXISTS
/// ---------------
/// The same invoice payment produced two different documents depending on how
/// it was opened:
///
///   straight after paying   Invoice No. · From · Bill To · Your Share ·
///                           Total Invoice · Status · (FX rows)
///
///   reopened from           Account · Description ("Invoice payment:
///   transaction history     INV-…") · Reference · Type · Category ·
///                           Currency · Transaction ID
///
/// The first set was never persisted anywhere. `InvoicePaymentReceiptScreen`
/// assembled it in the app from the pay RPC's response and discarded it, so
/// the copy people actually keep — history, and the PDF generated from it —
/// could not name the invoice, the parties or the total. It read as an
/// anonymous transfer for an arbitrary amount.
///
/// invoice-service now stamps the invoice as DATA on both ledger legs
/// (`invoice_receipt_payload.go`) and this projects it, the way
/// `CryptoReceiptFields` projects a trade and `EscrowReceiptFields` a deal.
/// Every entry point calls it, so there is nothing left to drift.
///
/// ## Rows written before the payload
///
/// They carry no invoice keys at all — but the ledger narration has always
/// been `Invoice payment: INV-<ts>-<hex>`, so the invoice NUMBER is
/// recoverable from it. Those rows therefore still answer "which invoice was
/// this", and simply omit the rows nothing can supply. Nothing is invented:
/// no id means no "View invoice" action.
class InvoiceReceiptFields {
  const InvoiceReceiptFields._();

  static final NumberFormat _money = NumberFormat('#,##0.00');

  /// `INV-<unix seconds>-<8 hex>` — `generateInvoiceNumber()` in
  /// invoice-service. Deliberately shape-specific: a user-typed transfer
  /// narration mentioning the word "invoice" must not be mistaken for one.
  static final RegExp _numberPattern =
      RegExp(r'\bINV-\d{9,}-[0-9a-fA-F]{8}\b', caseSensitive: false);

  /// The invoice number this row refers to, from the stamped payload or
  /// recovered from the ledger narration/reference. '' when neither has one.
  static String numberFrom(
    Map<String, dynamic>? metadata, {
    String? description,
    String? reference,
  }) {
    final stamped = _str(metadata, 'invoice_number');
    if (stamped.isNotEmpty) return stamped;
    for (final text in [description ?? '', reference ?? '']) {
      final m = _numberPattern.firstMatch(text);
      // Verbatim, NOT upper-cased: the hex half comes from a UUID and is
      // stored lowercase, so normalising the case would print a number that
      // does not match the one on the invoice.
      if (m != null) return m.group(0)!;
    }
    return '';
  }

  /// The invoice's own id, when the row carries it. '' otherwise.
  ///
  /// Only the stamped payload has this — there is no lookup by number — so an
  /// older row yields '' and callers must not offer to open the invoice.
  static String idFrom(Map<String, dynamic>? metadata) =>
      _str(metadata, 'invoice_id');

  /// Whether this row is an invoice payment this projection can describe.
  ///
  /// Keyed on the payload (or a recoverable number) rather than on the
  /// transaction's service type, because the money legs classify as a
  /// TRANSFER: accounts books them as `transfer_out`/`transfer_in` under
  /// `core-payments-service`. Keying on the service type would have missed
  /// every real invoice payment in the ledger.
  static bool describes(
    Map<String, dynamic>? metadata, {
    String? description,
    String? reference,
  }) {
    if (idFrom(metadata).isNotEmpty) return true;
    return numberFrom(
      metadata,
      description: description,
      reference: reference,
    ).isNotEmpty;
  }

  /// The ordered rows, label → value. Empty when [describes] is false.
  ///
  /// [amountPaid] is what actually moved on THIS leg, in [currency] — passed
  /// in because the share/total comparison is the whole reason a split
  /// invoice's receipt makes sense, and the leg's own amount is the only
  /// honest source for it.
  static List<MapEntry<String, String>> rows(
    Map<String, dynamic>? metadata, {
    required String currency,
    required bool isIncoming,
    required String Function(String code) symbolFor,
    double? amountPaid,
    String? description,
    String? reference,
    String? counterpartyName,
    String? counterpartyAccount,
  }) {
    if (!describes(metadata, description: description, reference: reference)) {
      return const [];
    }

    final number = numberFrom(
      metadata,
      description: description,
      reference: reference,
    );
    final docType = _str(metadata, 'invoice_doc_type').toLowerCase();
    final title = _str(metadata, 'invoice_title');
    final billedBy = _str(metadata, 'invoice_billed_by');
    final billedTo = _str(metadata, 'invoice_billed_to');
    final invoiceCcy = _str(metadata, 'invoice_currency').toUpperCase();
    final totalMinor = _num(metadata, 'invoice_total_minor');
    final shareMinor = _num(metadata, 'invoice_share_minor');
    final payers = _num(metadata, 'invoice_payers').round();
    final isSplit = _bool(metadata, 'invoice_split') || shareMinor > 0;
    final settleCcy = _str(metadata, 'invoice_settle_currency').toUpperCase();
    final fxRate = _num(metadata, 'invoice_fx_rate');
    final dueDate = _date(metadata, 'invoice_due_date');
    // Only the fresh post-payment receipt knows this: the ledger stamp is
    // written BEFORE the invoice's status transition commits, so a history
    // receipt has no settlement state and shows no row rather than guessing.
    final settled = _boolOrNull(metadata, 'invoice_settled');

    final docLabel = switch (docType) {
      'request' => 'Payment request',
      'quote' => 'Quote',
      _ => 'Invoice',
    };
    // The currency the INVOICE is denominated in. Falls back to the leg's own
    // currency, which is the same thing whenever no conversion happened.
    final docCcy = invoiceCcy.isNotEmpty ? invoiceCcy : currency.toUpperCase();

    final out = <MapEntry<String, String>>[];
    void add(String label, String value) {
      if (value.trim().isEmpty) return;
      out.add(MapEntry(label, value));
    }

    // IDENTITY FIRST: what makes this row recognisable a month later.
    add('$docLabel No.', number);
    // DESCRIPTION is what the invoice was FOR, not the ledger's own narration
    // — "Invoice payment: INV-1788196602-eb7a9258" only repeated the number.
    add('Description', title);
    add('Billed by', billedBy);
    // Not "To": on a split invoice the person who paid is one of several
    // payers, and the document is addressed to all of them.
    add('Billed to', billedTo);

    // THE LEG'S OWN COUNTERPARTY, when the invoice's party block is missing.
    //
    // Pre-payload rows have no parties at all, and the card this projection
    // replaces DID name the other side from the ledger's counterparty columns
    // (populated on every leg — measured on prod). Dropping it to show an
    // invoice number would have traded one missing fact for another.
    //
    // Labelled for what it actually is — who this money went to, or came from
    // — never as the invoice's "Billed to": on a split invoice the document is
    // addressed to several people and this is only the one who paid this leg.
    final other = (counterpartyName ?? '').trim();
    final sideMissing = isIncoming ? billedTo.isEmpty : billedBy.isEmpty;
    if (sideMissing && !_isPlaceholder(other)) {
      add(isIncoming ? 'Paid by' : 'Paid to', other);
    }
    add('Account', (counterpartyAccount ?? '').trim());

    add('Reference', (reference ?? '').trim());
    add('Type', docLabel);
    add('Category', isIncoming ? 'Credit' : 'Debit');
    add('Currency', currency.toUpperCase());

    // THE INVOICE TOTAL, whenever it is not simply the amount that moved.
    // Without it a split payment reads as an underpayment of the document.
    final totalMajor = totalMinor / 100.0;
    if (totalMajor > 0) {
      final paid = amountPaid ?? 0;
      final sameAsPaid =
          docCcy == currency.toUpperCase() && (paid - totalMajor).abs() < 0.005;
      if (!sameAsPaid) {
        add('$docLabel total',
            '${symbolFor(docCcy)}${_money.format(totalMajor)}');
      }
    }
    if (isSplit) {
      final shareMajor = shareMinor > 0 ? shareMinor / 100.0 : 0.0;
      if (shareMajor > 0) {
        add(
          isIncoming ? 'Share received' : 'Your share',
          '${symbolFor(docCcy)}${_money.format(shareMajor)}',
        );
      }
      if (payers > 1) add('Split between', '$payers payers');
    }
    if (settled != null) {
      add('$docLabel status',
          settled ? 'Fully paid' : 'Awaiting other recipients');
    }
    // Cross-currency settlement: the headline amount is in the payer's
    // currency, so without the rate the receipt cannot be tied back to the
    // invoice it settles.
    if (settleCcy.isNotEmpty && fxRate > 0 && settleCcy != docCcy) {
      add('Exchange rate', _rate(docCcy, settleCcy, fxRate));
    }
    if (dueDate != null) {
      add('Due date', DateFormat('d MMM yyyy').format(dueDate));
    }
    return out;
  }

  /// The raw keys this projection consumes. A caller that also renders a
  /// generic metadata dump must hide these, or every value appears twice —
  /// once in a designed row and once as a snake_case key.
  static const Set<String> consumedKeys = {
    'invoice_id',
    'invoice_number',
    'invoice_doc_type',
    'invoice_title',
    'invoice_billed_by',
    'invoice_billed_to',
    'invoice_currency',
    'invoice_total_minor',
    'invoice_share_minor',
    'invoice_payers',
    'invoice_split',
    'invoice_settle_currency',
    'invoice_fx_rate',
    'invoice_due_date',
    'invoice_settled',
  };

  /// "1 NGN = 0.000612 USD" — extra precision for very small rates, which is
  /// every NGN→hard-currency pair.
  static String _rate(String from, String to, double rate) {
    final r = rate >= 0.01 ? rate.toStringAsFixed(4) : rate.toStringAsFixed(6);
    return '1 $from = $r $to';
  }

  /// Provider/ledger placeholders that must never render as a person's name.
  /// Mirrors the receipt widget's own filter — a row reading "Paid to Unknown"
  /// is worse than no row.
  static bool _isPlaceholder(String v) {
    switch (v.trim().toLowerCase()) {
      case '':
      case 'anonymous customer':
      case 'anonymous':
      case 'unknown':
      case 'n/a':
      case 'na':
      case 'null':
        return true;
    }
    return false;
  }

  static String _str(Map<String, dynamic>? m, String k) {
    final v = m?[k];
    if (v == null) return '';
    final s = v.toString().trim();
    return (s.isEmpty || s == 'null') ? '' : s;
  }

  static double _num(Map<String, dynamic>? m, String k) {
    final v = m?[k];
    if (v is num) return v.toDouble();
    return double.tryParse(_str(m, k)) ?? 0;
  }

  static bool _bool(Map<String, dynamic>? m, String k) =>
      _boolOrNull(m, k) ?? false;

  /// Tri-state: absent is NOT the same as false for a settlement flag — a
  /// history row has no settlement state and must render no row at all.
  static bool? _boolOrNull(Map<String, dynamic>? m, String k) {
    final v = m?[k];
    if (v == null) return null;
    if (v is bool) return v;
    switch (v.toString().trim().toLowerCase()) {
      case 'true':
        return true;
      case 'false':
        return false;
    }
    return null;
  }

  static DateTime? _date(Map<String, dynamic>? m, String k) {
    final s = _str(m, k);
    if (s.isEmpty) return null;
    return DateTime.tryParse(s)?.toLocal();
  }
}
