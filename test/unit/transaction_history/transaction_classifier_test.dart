import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/core/types/unified_transaction.dart';
import 'package:lazervault/src/features/transaction_history/data/repository/transaction_classifier.dart';

/// Regression tests for the shared `hold_capture` transaction classifier.
///
/// accounts-service books many charges as a hold + capture, all sharing the
/// generic ledger `category` of `hold_capture` and a domain-less `HOLD-CAP-…`
/// reference. The classifier must recover the real domain from the capturing
/// `service_name` (+ description). These tests lock in that behaviour so no
/// non-giftcard capture regresses back to "Gift Card Purchase".
void main() {
  const hc = 'hold_capture';
  // The capture reference carries NO domain signal (always HOLD-CAP-…).
  const cap = 'HOLD-CAP-abc12345';

  String title(String cat, String type, String desc, String svc,
          {String ref = cap}) =>
      generateTransactionTitle(cat, type, desc, ref, svc);

  group('hold_capture titles — one row per real backend capture flow', () {
    test('crypto: all description variants → Crypto buy (debit)', () {
      for (final d in const [
        'Crypto order filled: X',
        'Quidax order completed: X', // no "crypto" text — service_name saves it
        'bridge sell compensation: capture XYZ (already swapped)',
        'crypto swap completion R',
      ]) {
        expect(title(hc, 'debit', d, 'crypto-service'), 'Crypto buy',
            reason: d);
      }
    });

    test('exchange: FX conversion → Currency Exchange', () {
      expect(title(hc, 'debit', 'Exchange NGN to USD ref=H', 'exchange-service'),
          'Currency Exchange');
    });

    test('exchange: international transfer → Transfer Sent', () {
      expect(
          title(hc, 'debit', 'International transfer to John', 'exchange-service'),
          'Transfer Sent');
      expect(
          title(hc, 'debit', 'International transfer capture (retry) ref=R',
              'exchange-service'),
          'Transfer Sent');
    });

    test('insurance: premium capture → Insurance Payment (any description)', () {
      expect(title(hc, 'debit', 'INS-9af', 'financial-products-service'),
          'Insurance Payment');
      expect(
          title(hc, 'debit', 'CAPTURE-VERIFIED-INS-9af',
              'financial-products-service'),
          'Insurance Payment');
    });

    test('banking: refresh fee → Balance Refresh Fee', () {
      expect(title(hc, 'debit', 'Bank balance refresh fee', 'banking-service'),
          'Balance Refresh Fee');
    });

    test('banking: withdrawal capture → Account Withdrawal', () {
      expect(
          title('withdrawal', 'debit', 'Withdrawal captured: WD-1',
              'banking-service', ref: 'WD-1'),
          'Account Withdrawal');
    });

    test('core-payments: transfer (+fallback descriptions) → Transfer Sent', () {
      expect(title(hc, 'debit', 'Transfer to Jane', 'core-payments-service'),
          'Transfer Sent');
      expect(
          title(hc, 'debit', 'Fund hold captured on transfer completion',
              'core-payments-service'),
          'Transfer Sent');
    });

    test('invoice → Invoice Payment', () {
      expect(title(hc, 'debit', 'Invoice payment capture', 'invoice-service'),
          'Invoice Payment');
    });

    test('rmb → RMB Transfer', () {
      expect(title(hc, 'debit', 'RMB payout R', 'rmb-service'), 'RMB Transfer');
    });

    test('giftcards: purchase → Gift Card Purchase (the ONE legit case)', () {
      expect(title(hc, 'debit', 'Gift card purchase - R', 'giftcards-service'),
          'Gift Card Purchase');
    });
  });

  group('zero-amount crypto rows (crypto_convert / crypto_send)', () {
    // Written explicitly by crypto-service into the unified history with
    // amount 0 — the category is authoritative, and MUST beat the generic
    // credit⇒sell / debit⇒buy heuristic ("Crypto sell +₦0.00" bug).
    test('crypto_convert credit → Crypto swap, never Crypto sell', () {
      expect(
          title('crypto_convert', 'credit',
              'Converted 1.7000000000000000000 USDT → 1.08 XRP',
              'crypto-service',
              ref: 'CRYPTO-6e232840'),
          'Crypto swap');
    });

    test('crypto_send debit → Crypto send, never Crypto buy', () {
      expect(
          title('crypto_send', 'debit', 'Sent 5.000000 USDT to chris',
              'crypto-service',
              ref: 'CRYPTO-abc'),
          'Crypto send');
    });

    test('swap/send resolve to the crypto service type', () {
      expect(serviceTypeForDomain('crypto_swap'), TransactionServiceType.crypto);
      expect(serviceTypeForDomain('crypto_send'), TransactionServiceType.crypto);
      expect(
          classifyDomain('crypto_convert', 'Converted 1.7 USDT → 1.08 XRP',
              'CRYPTO-6e232840', 'crypto-service'),
          'crypto_swap');
      expect(
          classifyDomain('crypto_send', 'Sent 5 USDT to chris', 'CRYPTO-abc',
              'crypto-service'),
          'crypto_send');
    });

    test('a reversed/refunded crypto row still reads as a refund', () {
      expect(
          classifyDomain('crypto_send', 'Refund: send reversed', 'CRYPTO-abc',
              'crypto-service'),
          'crypto_refund');
    });
  });

  group('edge cases', () {
    test('partial / overage capture categories still resolve by service_name',
        () {
      expect(title('hold_capture_partial', 'debit', 'RMB payout R', 'rmb-service'),
          'RMB Transfer');
      expect(
          title('hold_capture_overage', 'debit', 'Invoice payment capture',
              'invoice-service'),
          'Invoice Payment');
    });

    test('credits (refunds/reversals) read as refunds, not payments', () {
      expect(title(hc, 'credit', 'Gift card refund - R', 'giftcards-service'),
          'Gift Card Refund');
      expect(
          title(hc, 'credit', 'Refund: balance refresh fee could not be settled',
              'banking-service'),
          'Balance Refresh Fee Refund');
      expect(title(hc, 'credit', 'Insurance premium reversal',
          'financial-products-service'), 'Insurance Refund');
      expect(title(hc, 'credit', 'Transfer reversal', 'core-payments-service'),
          'Transfer Received');
    });

    test('gift-card SALE (credit) stays a sale, not a refund', () {
      expect(title('gift_card_sell', 'credit', 'payout', 'giftcards-service',
          ref: 'GC-1'), 'Gift Card Sale');
    });

    test('legacy rows without service_name recover from description text', () {
      expect(title(hc, 'debit', 'crypto swap completion', ''), 'Crypto buy');
      expect(title(hc, 'debit', 'Transfer to Jane', ''), 'Transfer Sent');
      expect(title(hc, 'debit', 'INS-1 premium', ''), 'Insurance Payment');
    });

    test('unresolvable hold_capture → neutral label, never giftcard', () {
      expect(title(hc, 'debit', 'Reconciliation capture: R', 'banking-service'),
          'Payment');
      expect(title(hc, 'debit', 'something opaque', ''), 'Payment');
      expect(title(hc, 'credit', 'something opaque', ''), 'Refund');
    });
  });

  group('service type resolution (icon/colour) via domain', () {
    void expectType(String domain, TransactionServiceType? want) =>
        expect(serviceTypeForDomain(domain), want);

    test('each domain maps to its concrete service type', () {
      expectType('crypto', TransactionServiceType.crypto);
      expectType('exchange', TransactionServiceType.exchange);
      expectType('insurance', TransactionServiceType.insurance);
      expectType('refresh_fee', TransactionServiceType.fee);
      expectType('invoice', TransactionServiceType.invoice);
      expectType('rmb', TransactionServiceType.rmb);
      expectType('transfer', TransactionServiceType.transfer);
      expectType('withdrawal', TransactionServiceType.withdrawal);
      expectType('giftcard', TransactionServiceType.giftCard);
      expectType('', null);
    });

    test('inferServiceTypeFromCategory pins captures to the right type', () {
      // exchange-service has no direct AppServiceName backend mapping, so the
      // service-name path returns unknown; the domain must still yield exchange.
      expect(
          inferServiceTypeFromCategory(
              hc, 'debit', 'Exchange NGN to USD', cap, 'exchange-service'),
          TransactionServiceType.exchange);
      expect(
          inferServiceTypeFromCategory(
              hc, 'debit', 'Bank balance refresh fee', cap, 'banking-service'),
          TransactionServiceType.fee);
      expect(
          inferServiceTypeFromCategory(
              hc, 'debit', 'RMB payout', cap, 'rmb-service'),
          TransactionServiceType.rmb);
    });
  });

  group('classifyDomain — service_name is authoritative', () {
    test('service_name wins even when description is bland/misleading', () {
      expect(classifyDomain(hc, 'HOLD-CAP-x', cap, 'rmb-service'), 'rmb');
      expect(classifyDomain(hc, 'Quidax order completed', cap, 'crypto-service'),
          'crypto');
      // giftcards is the only service that maps to the giftcard domain
      expect(classifyDomain(hc, 'purchase', cap, 'giftcards-service'), 'giftcard');
    });
  });
}
