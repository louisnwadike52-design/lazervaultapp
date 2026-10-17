import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/invoice/utils/invoice_receipt_fields.dart';

/// The payload invoice-service stamps on both ledger legs
/// (invoice_receipt_payload.go). Values are the JSON types it marshals, not
/// pre-formatted strings — that is the whole point of a canonical payload.
Map<String, dynamic> stamped({
  bool split = false,
  int totalMinor = 500000,
  int? shareMinor,
  String? settleCurrency,
  double? fxRate,
  bool? settled,
}) =>
    {
      'counterparty_user_id': '806fd9c5-f872-4047-a9ab-19a156a25c64',
      'invoice_id': 'eaec318b-9df4-47bb-899c-a3b836633bf2',
      'invoice_number': 'INV-1788196602-eb7a9258',
      'invoice_doc_type': 'invoice',
      'invoice_title': 'Website redesign, phase 2',
      'invoice_currency': 'NGN',
      'invoice_total_minor': totalMinor,
      'invoice_due_date': '2026-11-01T00:00:00Z',
      'invoice_billed_by': 'Lazer Studios Ltd',
      'invoice_billed_to': 'Praiz Onah',
      if (split) 'invoice_split': true,
      if (split) 'invoice_payers': 3,
      if (shareMinor != null) 'invoice_share_minor': shareMinor,
      if (settleCurrency != null) 'invoice_settle_currency': settleCurrency,
      if (fxRate != null) 'invoice_fx_rate': fxRate,
      if (settled != null) 'invoice_settled': settled,
    };

String symbolFor(String code) {
  switch (code.toUpperCase()) {
    case 'NGN':
      return '₦';
    case 'USD':
      return '\$';
    default:
      return '${code.toUpperCase()} ';
  }
}

String? valueFor(List<MapEntry<String, String>> rows, String label) {
  for (final r in rows) {
    if (r.key == label) return r.value;
  }
  return null;
}

List<MapEntry<String, String>> rowsFor(
  Map<String, dynamic>? metadata, {
  String currency = 'NGN',
  bool isIncoming = false,
  double? amountPaid,
  String? description,
  String? reference,
  String? counterpartyName,
  String? counterpartyAccount,
}) =>
    InvoiceReceiptFields.rows(
      metadata,
      currency: currency,
      isIncoming: isIncoming,
      symbolFor: symbolFor,
      amountPaid: amountPaid,
      description: description,
      reference: reference,
      counterpartyName: counterpartyName,
      counterpartyAccount: counterpartyAccount,
    );

void main() {
  group('InvoiceReceiptFields — the real prod history row', () {
    // Measured on prod 2026-10-17, transactions d0a0425a / d56b755f: the two
    // legs of a real NGN200 invoice payment. metadata holds ONE key and the
    // invoice is named only in the narration.
    const prodDescription = 'Invoice payment: INV-1788196602-eb7a9258';
    const prodMetadata = <String, dynamic>{
      'counterparty_user_id': '04595c14-bff2-4ffc-9d83-513b12caf63c',
    };

    test('names the invoice from the narration when nothing was stamped', () {
      expect(
        InvoiceReceiptFields.describes(prodMetadata,
            description: prodDescription),
        isTrue,
      );
      final rows = rowsFor(prodMetadata,
          amountPaid: 200, description: prodDescription);
      expect(valueFor(rows, 'Invoice No.'), 'INV-1788196602-eb7a9258');
    });

    test('offers no invoice to open, because there is no id to open it with',
        () {
      // There is no lookup by invoice NUMBER, so a "View the invoice" button
      // built from one would be dead. The receipt still names the invoice.
      expect(InvoiceReceiptFields.idFrom(prodMetadata), '');
    });

    test('does not invent rows it has no data for', () {
      final rows = rowsFor(prodMetadata,
          amountPaid: 200, description: prodDescription);
      expect(valueFor(rows, 'Billed by'), isNull);
      expect(valueFor(rows, 'Billed to'), isNull);
      expect(valueFor(rows, 'Invoice total'), isNull);
      expect(valueFor(rows, 'Due date'), isNull);
    });

    test('still names the other side from the ledger columns', () {
      // The card this projection replaces named the counterparty, and those
      // columns ARE populated on both legs (prod: "Praiz Onah" / 8756255958).
      // Trading a named party for an invoice number would have fixed one
      // missing fact by creating another.
      final payer = rowsFor(prodMetadata,
          amountPaid: 200,
          description: prodDescription,
          counterpartyName: 'Nnaemeka Ezeke',
          counterpartyAccount: '9800138852');
      expect(valueFor(payer, 'Paid to'), 'Nnaemeka Ezeke');
      expect(valueFor(payer, 'Account'), '9800138852');

      final creator = rowsFor(prodMetadata,
          isIncoming: true,
          amountPaid: 200,
          description: prodDescription,
          counterpartyName: 'Praiz Onah',
          counterpartyAccount: '8756255958');
      expect(valueFor(creator, 'Paid by'), 'Praiz Onah');
      expect(valueFor(creator, 'Paid to'), isNull);
    });

    test('never renders a provider placeholder as a person', () {
      final rows = rowsFor(prodMetadata,
          amountPaid: 200,
          description: prodDescription,
          counterpartyName: 'Unknown');
      expect(valueFor(rows, 'Paid to'), isNull);
    });

    test('the stamped party wins over the ledger counterparty', () {
      // With the payload present there is no fallback row to duplicate it:
      // the invoice's own party block is the better answer and two rows naming
      // the same side read as a bug.
      final rows = rowsFor(stamped(),
          amountPaid: 5000, counterpartyName: 'Nnaemeka Ezeke');
      expect(valueFor(rows, 'Billed by'), 'Lazer Studios Ltd');
      expect(valueFor(rows, 'Paid to'), isNull);
    });
  });

  group('InvoiceReceiptFields — guards', () {
    test('a user-typed narration is NOT reclassified as an invoice', () {
      // Anyone can type this as the description of an ordinary transfer. Only
      // the INV-<unix>-<8 hex> shape invoice-service generates counts.
      expect(
        InvoiceReceiptFields.describes(
          const {},
          description: 'invoice payment for the generator',
        ),
        isFalse,
      );
      expect(
        InvoiceReceiptFields.describes(const {},
            description: 'paying invoice INV-123'),
        isFalse,
      );
    });

    test('an ordinary transfer projects nothing at all', () {
      expect(
        rowsFor(const {'counterparty_user_id': 'x'},
            description: 'Transfer to Grace C. Onwuanaku'),
        isEmpty,
      );
    });
  });

  group('InvoiceReceiptFields — the stamped payload', () {
    test('renders the identity rows the post-payment receipt showed', () {
      final rows = rowsFor(stamped(),
          amountPaid: 5000, reference: 'INV-PAY-a42c7c53');
      expect(valueFor(rows, 'Invoice No.'), 'INV-1788196602-eb7a9258');
      expect(valueFor(rows, 'Description'), 'Website redesign, phase 2');
      expect(valueFor(rows, 'Billed by'), 'Lazer Studios Ltd');
      expect(valueFor(rows, 'Billed to'), 'Praiz Onah');
      expect(valueFor(rows, 'Reference'), 'INV-PAY-a42c7c53');
      expect(valueFor(rows, 'Type'), 'Invoice');
      expect(valueFor(rows, 'Category'), 'Debit');
      expect(valueFor(rows, 'Due date'), '1 Nov 2026');
      expect(InvoiceReceiptFields.idFrom(stamped()),
          'eaec318b-9df4-47bb-899c-a3b836633bf2');
    });

    test('the identity rows come FIRST, before the ledger boilerplate', () {
      // A receipt is scanned top-down; "which invoice" must not sit under
      // Type/Category/Currency.
      final rows = rowsFor(stamped(), amountPaid: 5000);
      final labels = rows.map((r) => r.key).toList();
      expect(labels.indexOf('Invoice No.'), 0);
      expect(labels.indexOf('Billed to'), lessThan(labels.indexOf('Type')));
    });

    test('omits the total when it IS the amount that moved', () {
      // Printing "Invoice total ₦5,000.00" under a ₦5,000.00 headline is
      // noise, and repetition on a receipt reads as a mistake in the money.
      final rows = rowsFor(stamped(), amountPaid: 5000);
      expect(valueFor(rows, 'Invoice total'), isNull);
    });

    test('shows the total and the share on a split invoice', () {
      // The payer paid ₦1,666.67 of a ₦5,000.00 invoice. Without both rows
      // the receipt reads as an underpayment of the document.
      final rows = rowsFor(
        stamped(split: true, shareMinor: 166667),
        amountPaid: 1666.67,
      );
      expect(valueFor(rows, 'Invoice total'), '₦5,000.00');
      expect(valueFor(rows, 'Your share'), '₦1,666.67');
      expect(valueFor(rows, 'Split between'), '3 payers');
    });

    test('the creator leg reads as money received, not money owed', () {
      final rows = rowsFor(
        stamped(split: true, shareMinor: 166667),
        isIncoming: true,
        amountPaid: 1666.67,
      );
      expect(valueFor(rows, 'Category'), 'Credit');
      expect(valueFor(rows, 'Share received'), '₦1,666.67');
      expect(valueFor(rows, 'Your share'), isNull);
    });

    test('a cross-currency payment carries the rate and the invoice currency',
        () {
      // The headline is USD (the payer's account); the invoice is NGN. Without
      // the rate the receipt cannot be tied back to the document it settles.
      final rows = rowsFor(
        stamped(settleCurrency: 'USD', fxRate: 0.000612),
        currency: 'USD',
        amountPaid: 3.06,
      );
      expect(valueFor(rows, 'Invoice total'), '₦5,000.00');
      expect(valueFor(rows, 'Exchange rate'), '1 NGN = 0.000612 USD');
      expect(valueFor(rows, 'Currency'), 'USD');
    });

    test('settlement state renders only when the row actually knows it', () {
      // The ledger stamp is written BEFORE the invoice status transition
      // commits, so a history receipt has no settlement state. Absent must not
      // read as "awaiting".
      final history = rowsFor(stamped(split: true, shareMinor: 166667),
          amountPaid: 1666.67);
      expect(valueFor(history, 'Invoice status'), isNull);

      final fresh = rowsFor(
        stamped(split: true, shareMinor: 166667, settled: false),
        amountPaid: 1666.67,
      );
      expect(valueFor(fresh, 'Invoice status'), 'Awaiting other recipients');

      final lastPayer = rowsFor(
        stamped(split: true, shareMinor: 166667, settled: true),
        amountPaid: 1666.67,
      );
      expect(valueFor(lastPayer, 'Invoice status'), 'Fully paid');
    });

    test('a payment request and a quote are not called "Invoice"', () {
      final request = stamped()..['invoice_doc_type'] = 'request';
      final rows = rowsFor(request, amountPaid: 5000);
      expect(valueFor(rows, 'Payment request No.'),
          'INV-1788196602-eb7a9258');
      expect(valueFor(rows, 'Type'), 'Payment request');
      expect(valueFor(rows, 'Invoice No.'), isNull);
    });

    test('string-typed values survive a JSON round trip', () {
      // accounts-service merges the stamp into existing metadata, and a
      // gateway hop can stringify numbers. A receipt must not lose the total
      // because it arrived as "500000" rather than 500000.
      final asStrings = <String, dynamic>{
        'invoice_number': 'INV-1788196602-eb7a9258',
        'invoice_currency': 'NGN',
        'invoice_total_minor': '500000',
        'invoice_split': 'true',
        'invoice_share_minor': '166667',
      };
      final rows = rowsFor(asStrings, amountPaid: 1666.67);
      expect(valueFor(rows, 'Invoice total'), '₦5,000.00');
      expect(valueFor(rows, 'Your share'), '₦1,666.67');
    });

    test('every consumed key is actually read, so none renders twice', () {
      // consumedKeys is what the receipt hides from its generic metadata dump.
      // A key listed there but never read would silently disappear; a key read
      // here but missing from the list would print twice — once designed, once
      // as raw snake_case.
      const read = {
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
      expect(InvoiceReceiptFields.consumedKeys, read);
    });
  });
}
