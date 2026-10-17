import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/core/types/unified_transaction.dart';
import 'package:lazervault/src/features/transaction_history/data/repository/transaction_classifier.dart';

/// An invoice payment settles through core-payments-service, so accounts books
/// BOTH legs as an ordinary internal transfer:
///
///   category      transfer_out / transfer_in
///   service_name  core-payments-service
///   description   "Invoice payment: INV-1788196602-eb7a9258"
///   metadata      {"counterparty_user_id": "…"}        ← nothing else
///
/// (Measured on prod 2026-10-17: transactions d0a0425a-725f-4c59-9c63-
/// f59ff5fa0101 and d56b755f-7929-4b69-8615-5e6caa5b0b15, the two legs of one
/// NGN200 invoice payment.)
///
/// The `service_name contains core-payments ⇒ transfer` rule therefore titled
/// every invoice payment in production "Transfer Sent" / "Transfer Received",
/// filed it under the transfers filter, and drew a transfer icon — with the
/// invoice number visible only inside the narration.
///
/// The guard is the invoice NUMBER's own shape. Anyone can type the words
/// "invoice payment" as the narration of a real transfer, and that must stay a
/// transfer; only `INV-<unix seconds>-<8 hex>`, which nothing but
/// generateInvoiceNumber() in invoice-service produces, reclassifies a row.
void main() {
  const corePayments = 'core-payments-service';
  const invoiceSvc = 'invoice-service';
  const prodDesc = 'Invoice payment: INV-1788196602-eb7a9258';

  String domain(String category, String description,
          {String ref = '', String svc = corePayments}) =>
      classifyDomain(category, description, ref, svc);

  TransactionServiceType? svcType(String category, String description,
          {String ref = '', String svc = corePayments}) =>
      serviceTypeForDomain(classifyDomain(category, description, ref, svc));

  String title(String category, String type, String description,
          {String ref = '', String svc = corePayments}) =>
      generateTransactionTitle(category, type, description, ref, svc);

  group('the real production invoice-payment legs', () {
    test('the payer leg is an Invoice Payment, not a Transfer Sent', () {
      expect(domain('transfer_out', prodDesc), 'invoice');
      expect(svcType('transfer_out', prodDesc), TransactionServiceType.invoice);
      expect(title('transfer_out', 'debit', prodDesc), 'Invoice Payment');
    });

    test('the creator leg reads as received, not as a transfer in', () {
      expect(domain('transfer_in', prodDesc), 'invoice');
      expect(title('transfer_in', 'credit', prodDesc), 'Invoice Received');
    });

    test('the reference carries no invoice signal, so the narration must', () {
      // IDEM-XFER-85a44341-…-FROM: the real reference on the payer leg. If
      // classification depended on it, nothing would have been fixed.
      const realRef = 'IDEM-XFER-85a44341-8cc4-47d4-bec2-f3c3271f066a-FROM';
      expect(domain('transfer_out', prodDesc, ref: realRef), 'invoice');
    });
  });

  group('what must NOT be reclassified', () {
    test('a user-typed narration mentioning an invoice stays a transfer', () {
      expect(domain('transfer_out', 'invoice payment for the generator'),
          'transfer');
      expect(title('transfer_out', 'debit', 'paying my invoice'),
          'Transfer Sent');
    });

    test('a half-shaped number is not an invoice number', () {
      expect(domain('transfer_out', 'Invoice payment: INV-123'), 'transfer');
      expect(domain('transfer_out', 'Invoice payment: INV-1788196602'),
          'transfer');
    });

    test('an ordinary transfer is untouched', () {
      expect(domain('transfer_out', 'Transfer to Grace C. Onwuanaku'),
          'transfer');
    });
  });

  group('the fee is still a fee', () {
    // The creation/unlock fee's description carries the SAME invoice number
    // ("Invoice unlock fee: INV-1788196602-eb7a9258" — prod row
    // d8438767-9d9d-489d-940f-f2a949af903a), so the new arm has to sit BELOW
    // the fee branches or a platform fee would present as a payment of the
    // invoice itself.
    const feeDesc = 'Invoice unlock fee: INV-1788196602-eb7a9258';

    test('an unlock fee row is invoice_fee, not invoice', () {
      expect(domain('invoice_creation_fee', feeDesc, svc: invoiceSvc),
          'invoice_fee');
      expect(svcType('invoice_creation_fee', feeDesc, svc: invoiceSvc),
          TransactionServiceType.fee);
    });

    test('a legacy service_fee row stamped core-payments is still a fee', () {
      expect(domain('service_fee', feeDesc), 'invoice_fee');
    });
  });
}
