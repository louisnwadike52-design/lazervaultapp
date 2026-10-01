import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/core/services/deep_link_service.dart';
import 'package:lazervault/src/features/ai_scan_to_pay/domain/entities/scan_entities.dart';
import 'package:lazervault/src/features/ai_scan_to_pay/domain/services/scanned_code_classifier.dart';

/// Every payload here is built the way the APP builds it, from the code that
/// writes the QR — not from a guess at the shape:
///
///   my_qr_code_screen                          → lazervault_pay v2.1 / lazervault_recipient
///   invoice_qr_service                         → invoice / payment
///   qr_display_screen, qr_code_details_sheet    → qr_payment / raw "QR-…"
///   transfer_receipt_screen                    → transfer / batch_transfer
///   bill_receipt_qr_block                      → airtime, data, cable_tv, …
///   contribution_payment_confirmation_screen    → group_contribution
///   donation_receipt_screen                    → lazervault://crowdfund/donation/<txn>
///   crowdfund share, escrow share, family invite → lazervault.app links
void main() {
  const c = ScannedCodeClassifier();

  group('payable codes still classify', () {
    test('a static profile QR pays a Lazervault user', () {
      final raw = jsonEncode({
        'type': 'lazervault_recipient',
        'recipientId': 'u-1',
        'username': 'praiz',
        'name': 'Praiz Onah',
        'version': '1.0',
      });
      final intent = c.classify(raw);
      expect(intent?.type, ScanIntentType.recipient);
      expect(intent?.username, 'praiz');
      // No amount was requested, so the payer sets it.
      expect(intent?.amountEditable, isTrue);
    });

    test('a profile QR WITH an amount is a server-minted reference', () {
      final raw = jsonEncode(
          {'type': 'lazervault_pay', 'qr_code': 'QR-abc123', 'v': '2.1'});
      final intent = c.classify(raw);
      expect(intent?.type, ScanIntentType.qrPay);
      expect(intent?.qrCode, 'QR-abc123');
      // Server-held amount: the payer must not be able to edit it.
      expect(intent?.amountEditable, isFalse);
    });

    test('an invoice QR is fixed-amount', () {
      final raw = jsonEncode({
        'type': 'invoice',
        'invoiceId': 'inv-9',
        'amount': 2500,
        'currency': 'NGN',
      });
      final intent = c.classify(raw);
      expect(intent?.type, ScanIntentType.invoice);
      expect(intent?.invoiceId, 'inv-9');
      expect(intent?.amountEditable, isFalse);
    });

    test('a bare qr-pay reference classifies', () {
      expect(c.classify('QR-xyz')?.type, ScanIntentType.qrPay);
    });
  });

  group('receipts are receipts, never payments', () {
    // This is a double-payment guard. A receipt carries a reference, an amount
    // and often the payee — the same shape as a payment request — so before it
    // was recognised the scan fell through to OCR, which reads those fields as a
    // request and offers to pay them. Scanning your own receipt could charge you
    // again.
    final receipts = <String, String>{
      'transfer': jsonEncode({
        'type': 'transfer',
        'ref': 'LV-REF-1',
        'amount': '5000.00',
        'currency': 'NGN',
        'to': 'Praiz Onah',
        'date': '2026-10-01T09:30:00.000Z',
      }),
      'batch_transfer': jsonEncode({
        'type': 'batch_transfer',
        'ref': 'BATCH-1',
        'amount': '15000.00',
        'currency': 'NGN',
        'recipients': 3,
        'date': '2026-10-01T09:30:00.000Z',
      }),
      'airtime bill': jsonEncode({
        'type': 'airtime',
        'ref': 'BILL-1',
        'amount': '100.00',
        'currency': 'NGN',
        'status': 'successful',
        'date': '2026-10-01T09:30:00.000Z',
      }),
      'cable tv bill': jsonEncode({
        'type': 'cable_tv',
        'ref': 'BILL-2',
        'amount': '7900.00',
        'currency': 'NGN',
        'status': 'successful',
        'date': '2026-10-01T09:30:00.000Z',
      }),
      'group contribution': jsonEncode({
        'type': 'group_contribution',
        'ref': 'GC-1',
        'amount': '2000.00',
        'currency': 'NGN',
        'date': '2026-10-01T09:30:00.000Z',
      }),
    };

    receipts.forEach((name, raw) {
      test('$name is recognised as a receipt', () {
        expect(c.classifyReceipt(raw), isNotNull, reason: name);
      });

      test('$name is NOT payable', () {
        expect(c.classify(raw), isNull, reason: name);
      });
    });

    test('the receipt carries the fields a human needs to find the original',
        () {
      final r = c.classifyReceipt(receipts['transfer']!)!;
      expect(r.reference, 'LV-REF-1');
      expect(r.amount, 5000.00);
      expect(r.currency, 'NGN');
      expect(r.counterparty, 'Praiz Onah');
      expect(r.date, isNotNull);
      expect(r.kindLabel, 'Transfer');
    });

    test('cable_tv reads as Cable Tv, not cable_tv', () {
      expect(c.classifyReceipt(receipts['cable tv bill']!)!.kindLabel,
          'Cable Tv');
    });

    test('every receipt type is refused by the payment classifier', () {
      // The invariant the guard in classify() enforces: the receipt vocabulary
      // and the payable vocabulary must stay disjoint. Asserted over the WHOLE
      // set rather than the samples above, so adding a payable branch whose
      // discriminator collides with a receipt's fails here instead of in
      // production.
      for (final t in ScannedCodeClassifier.receiptTypes) {
        final raw = jsonEncode({'type': t, 'ref': 'R-1', 'amount': '1.00'});
        expect(c.classify(raw), isNull, reason: t);
        expect(c.classifyReceipt(raw), isNotNull, reason: t);
      }
    });

    test('a receipt with no reference is not treated as one', () {
      // Nothing to look up and nothing to show — and refusing it keeps a
      // malformed payload from silently suppressing the payment paths.
      final raw = jsonEncode({'type': 'transfer', 'amount': '10.00'});
      expect(c.classifyReceipt(raw), isNull);
    });
  });

  group('our own links', () {
    test('both forms the app mints are recognised', () {
      expect(c.lazervaultLink('lazervault://crowdfund/abc'), isNotNull);
      expect(c.lazervaultLink('https://lazervault.app/escrow/offer/tok'),
          isNotNull);
      expect(c.lazervaultLink('https://www.lazervault.app/groups/g1'),
          isNotNull);
    });

    test('a lookalike host is NOT ours', () {
      // A suffix match would hand an attacker's URL to our own router.
      for (final url in [
        'https://lazervault.app.attacker.example/escrow/offer/tok',
        'https://notlazervault.app/crowdfund/1',
        'https://example.com/lazervault.app/x',
      ]) {
        expect(c.lazervaultLink(url), isNull, reason: url);
      }
    });

    test('a plain URL is not one of ours', () {
      expect(c.lazervaultLink('https://google.com'), isNull);
      expect(c.lazervaultLink('hello world'), isNull);
    });

    test('the donation receipt link is a RECEIPT, not a campaign', () {
      // app_links gives host='crowdfund', segments=['donation', '<txn>'], and
      // the campaign branch used to take segments[0] — opening a campaign whose
      // id was literally "donation".
      final data = DeepLinkService.parseUriForTest(
          Uri.parse('lazervault://crowdfund/donation/TXN-77'));
      expect(data.type, DeepLinkType.paymentReceipt);
      expect(data.receiptReference, 'TXN-77');
      expect(data.crowdfundCampaignId, isNull);
    });

    test('a real campaign link still opens a campaign', () {
      final data = DeepLinkService.parseUriForTest(
          Uri.parse('https://lazervault.app/crowdfund/camp-1'));
      expect(data.type, DeepLinkType.crowdfundCampaign);
      expect(data.crowdfundCampaignId, 'camp-1');
    });
  });
}
