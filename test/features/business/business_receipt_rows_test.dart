// A business receipt's SAVED document must carry what its SCREEN shows.
//
// Recording a sale produced a receipt whose Download/Share exported a flat
// image of the page, because no business service type was in the unified
// receipt's PDF allowlist — the same defect already fixed once each for
// invoices, gift cards, escrow and autosave. Adding the types is half of it;
// without their detail rows the PDF would still have been an amount and a
// date, which is a saved document quietly poorer than the screen.

import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/core/types/unified_transaction.dart';
import 'package:lazervault/src/features/widgets/unified_transaction_receipt.dart';

UnifiedTransaction _sale({
  String? description,
  Map<String, dynamic>? metadata,
  TransactionServiceType type = TransactionServiceType.sale,
}) =>
    UnifiedTransaction(
      id: 'BIZ-1',
      serviceType: type,
      title: 'Sale recorded',
      description: description,
      amount: 100,
      currency: 'NGN',
      createdAt: DateTime(2026, 10, 21),
      status: UnifiedTransactionStatus.completed,
      flow: TransactionFlow.incoming,
      metadata: metadata,
    );

void main() {
  group('businessReceiptRows', () {
    test('carries the sale payload the screen shows, in a stable order', () {
      final rows = businessReceiptRows(_sale(
        description: '1 × House cables',
        metadata: {
          'Customer': 'Harry',
          'Type': 'Paid sale',
          'Payment method': 'cash',
          'Quantity': '1 pcs',
        },
      ));

      expect(rows.map((e) => e.key).toList(),
          ['Description', 'Type', 'Payment method', 'Quantity', 'Customer']);
      expect(rows.first.value, '1 × House cables');
      expect(
          rows.firstWhere((e) => e.key == 'Payment method').value, 'cash');
    });

    test('a field the flow adds later still reaches the document', () {
      final rows = businessReceiptRows(_sale(
        metadata: {'Type': 'Receivable', 'Due date': '30 Nov 2026'},
      ));
      // Preferred keys lead; unknown ones follow rather than being dropped.
      expect(rows.map((e) => e.key).toList(), ['Type', 'Due date']);
    });

    test('empty and blank values are omitted, not rendered as empty rows', () {
      final rows = businessReceiptRows(_sale(
        description: '   ',
        metadata: {'Type': 'Paid sale', 'Customer': '', 'Quantity': '   '},
      ));
      expect(rows.map((e) => e.key).toList(), ['Type']);
    });

    test('non-ASCII and emoji survive — the PDF embeds a font for them', () {
      final rows = businessReceiptRows(_sale(
        description: 'Café crème 🍎 — ₦100',
        metadata: const {},
      ));
      expect(rows.single.value, 'Café crème 🍎 — ₦100');
    });

    // Guards the omission this test suite was written after: `tax` (the VAT
    // and WHT screens) was missed on the first pass through the business
    // flows, so its receipts would have kept exporting a flat image.
    test('the set covers every business flow that builds a receipt', () {
      expect(
        kBusinessReceiptServiceTypes,
        containsAll(<TransactionServiceType>[
          TransactionServiceType.sale,
          TransactionServiceType.expense,
          TransactionServiceType.payroll,
          TransactionServiceType.purchaseOrder,
          TransactionServiceType.tax,
        ]),
      );
    });

    test('every business service type produces rows', () {
      for (final t in kBusinessReceiptServiceTypes) {
        final rows =
            businessReceiptRows(_sale(type: t, metadata: {'Type': 'x'}));
        expect(rows, isNotEmpty, reason: '$t should carry its detail rows');
      }
    });

    test('a non-business receipt is untouched by this path', () {
      final rows = businessReceiptRows(_sale(
        type: TransactionServiceType.transfer,
        metadata: {'Type': 'Paid sale'},
      ));
      expect(rows, isEmpty);
    });
  });
}
