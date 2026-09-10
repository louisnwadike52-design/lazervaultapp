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
      expect(
          title(hc, 'debit', 'Exchange NGN to USD ref=H', 'exchange-service'),
          'Currency Exchange');
    });

    test('exchange: international transfer → Transfer Sent', () {
      expect(
          title(hc, 'debit', 'International transfer to John',
              'exchange-service'),
          'Transfer Sent');
      expect(
          title(hc, 'debit', 'International transfer capture (retry) ref=R',
              'exchange-service'),
          'Transfer Sent');
    });

    test('insurance: premium capture → Insurance Payment (any description)',
        () {
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
              'banking-service',
              ref: 'WD-1'),
          'Account Withdrawal');
    });

    test('core-payments: transfer (+fallback descriptions) → Transfer Sent',
        () {
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
          title(
              'crypto_convert',
              'credit',
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
      expect(
          serviceTypeForDomain('crypto_swap'), TransactionServiceType.crypto);
      expect(
          serviceTypeForDomain('crypto_send'), TransactionServiceType.crypto);
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
      expect(
          title('hold_capture_partial', 'debit', 'RMB payout R', 'rmb-service'),
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
          title(
              hc,
              'credit',
              'Refund: balance refresh fee could not be settled',
              'banking-service'),
          'Balance Refresh Fee Refund');
      expect(
          title(hc, 'credit', 'Insurance premium reversal',
              'financial-products-service'),
          'Insurance Refund');
      expect(title(hc, 'credit', 'Transfer reversal', 'core-payments-service'),
          'Transfer Received');
    });

    test('gift-card SALE (credit) stays a sale, not a refund', () {
      expect(
          title('gift_card_sell', 'credit', 'payout', 'giftcards-service',
              ref: 'GC-1'),
          'Gift Card Sale');
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
      expect(
          classifyDomain(hc, 'Quidax order completed', cap, 'crypto-service'),
          'crypto');
      // giftcards is the only service that maps to the giftcard domain
      expect(
          classifyDomain(hc, 'purchase', cap, 'giftcards-service'), 'giftcard');
    });
  });

  group('invoice platform fee — never a transfer', () {
    const unlockRef =
        'IDEM-PW-unlock-123e4567-e89b-12d3-a456-426614174000-a1b2c3d4-FROM';

    test('new rows: invoice_creation_fee category → invoice_fee domain', () {
      expect(
          classifyDomain('invoice_creation_fee', 'Invoice creation fee',
              unlockRef, 'invoice-service'),
          'invoice_fee');
      expect(
          classifyDomain(
              'invoice_unlock_fee', 'Invoice creation fee', unlockRef, ''),
          'invoice_fee');
    });

    test(
        'legacy rows: service_fee + core-payments-service still resolve via the '
        'unlock reference — the branch must beat core-payments⇒transfer', () {
      expect(
          classifyDomain('service_fee', 'Platform service fee payment',
              unlockRef, 'core-payments-service'),
          'invoice_fee');
      // A non-invoice service_fee from core-payments must NOT be captured.
      expect(
          classifyDomain('service_fee', 'Platform service fee payment',
              'IDEM-OTHER-abc', 'core-payments-service'),
          isNot('invoice_fee'));
    });

    test('title: Invoice Creation Fee (debit) / Invoice Fee Refund (credit)',
        () {
      expect(titleForDomain('invoice_fee', 'debit'), 'Invoice Creation Fee');
      expect(titleForDomain('invoice_fee', 'credit'), 'Invoice Fee Refund');
    });

    test('service type: fee icon, never transfer/invoice-payment', () {
      expect(serviceTypeForDomain('invoice_fee'), TransactionServiceType.fee);
    });

    test('invoiceIdFromReference recovers the UUID from legacy references', () {
      expect(invoiceIdFromReference(unlockRef),
          '123e4567-e89b-12d3-a456-426614174000');
      expect(invoiceIdFromReference('TRF-123456'), isNull);
      expect(invoiceIdFromReference('IDEM-PW-unlock-not-a-uuid-FROM'), isNull);
    });
  });
  group('service families that used to fall through to unknown', () {
    // Every one of these rendered the grey help-outline glyph in the dashboard
    // transaction list, because inferServiceTypeFromCategory simply had no arm
    // for them. On a list of a user's own payments that reads as "we do not
    // know what this was" for perfectly ordinary transactions.
    const cases = <String, TransactionServiceType>{
      'split_bill': TransactionServiceType.splitBill,
      'qr_payment': TransactionServiceType.qrPayment,
      'contactless_pay': TransactionServiceType.contactlessPay,
      'payroll': TransactionServiceType.payroll,
      'autosave': TransactionServiceType.autosave,
      'lock_funds': TransactionServiceType.lockFunds,
      'group_contribution': TransactionServiceType.groupFunds,
      'crowdfund': TransactionServiceType.crowdfund,
      'stocks': TransactionServiceType.stocks,
      'data': TransactionServiceType.data,
      'cable_tv': TransactionServiceType.tvSubscription,
      'internet': TransactionServiceType.internet,
      'water': TransactionServiceType.water,
      'education': TransactionServiceType.education,
      'expense': TransactionServiceType.expense,
      'tax': TransactionServiceType.tax,
      'refund': TransactionServiceType.refund,
      'reversal': TransactionServiceType.reversal,
    };

    cases.forEach((category, expected) {
      test('$category resolves to ${expected.name}', () {
        expect(
          inferServiceTypeFromCategory(category, 'debit', '', ''),
          expected,
          reason: '$category would show the unknown glyph',
        );
      });
    });
  });

  group('the new arms do not shadow the existing ones', () {
    test('batch_transfer stays a transfer, which is what it already was', () {
      // Not in the list above: it was never showing the unknown glyph. An
      // earlier arm already catches anything containing "transfer", so a batch
      // shows the transfer icon. That is defensible — a batch transfer IS a
      // transfer — and re-ordering established classification to win a more
      // specific glyph is a bigger change than the icon bug being fixed here.
      expect(inferServiceTypeFromCategory('batch_transfer', 'debit', '', ''),
          TransactionServiceType.transfer);
    });

    // Added arms run AFTER the established ones, so anything already
    // classified must be untouched. These are the pairs where one name
    // contains or resembles another.
    test('a split bill is not a generic bill, and vice versa', () {
      expect(inferServiceTypeFromCategory('split_bill', 'debit', '', ''),
          TransactionServiceType.splitBill);
      // Airtime still wins its own arm rather than being caught by a later one.
      expect(inferServiceTypeFromCategory('airtime', 'debit', '', ''),
          TransactionServiceType.airtime);
    });

    test('gift cards are resolved before anything card-shaped', () {
      expect(inferServiceTypeFromCategory('giftcard', 'debit', '', ''),
          TransactionServiceType.giftCard);
    });

    test('a deposit is still a deposit, not a fee or refund', () {
      expect(inferServiceTypeFromCategory('deposit', 'credit', '', ''),
          TransactionServiceType.deposit);
    });

    test('the generic money shapes only apply when nothing specific matched',
        () {
      // "crypto refund" must stay crypto — the refund arm is last on purpose.
      expect(inferServiceTypeFromCategory('crypto', 'debit', 'refund', ''),
          TransactionServiceType.crypto);
    });

    test('a genuinely unknown category is still unknown', () {
      expect(
          inferServiceTypeFromCategory('something_invented', 'debit', '', ''),
          TransactionServiceType.unknown);
    });
  });

  // ── AutoSave must not be classified as Insurance ───────────────────────
  //
  // financial-products-service is a MULTI-PRODUCT service. The classifier used
  // to answer "insurance" for the whole service, so this real prod row —
  //   category=auto_save, type=credit, service_name=financial-products-service
  //   description='AutoSave (manual_trigger): Save on wallet deposit'
  // rendered in history as "Insurance Refund" behind a shield icon.
  group('autosave is classified by category, not by the owning service', () {
    const svc = 'financial-products-service';
    const ref = 'IDEM-CR-65ec3cf3de878d70f8e51b2938e56ef2a872e0dcd6ea185ef8'
        '0b91602c431ebd:credit';

    test('the exact prod row titles as an Auto-Save deposit', () {
      expect(
        generateTransactionTitle('auto_save', 'credit',
            'AutoSave (manual_trigger): Save on wallet deposit', ref, svc),
        'Auto-Save Deposit',
      );
    });

    test('the source-side debit leg titles as an Auto-Save transfer', () {
      expect(
        generateTransactionTitle('auto_save', 'debit',
            'AutoSave (scheduled_worker): Rainy day', ref, svc),
        'Auto-Save Transfer',
      );
    });

    test('domains map to the savings service type, never insurance', () {
      for (final cat in const ['auto_save', 'auto_save_reversal']) {
        expect(serviceTypeForDomain(classifyDomain(cat, '', ref, svc)),
            TransactionServiceType.autosave,
            reason: cat);
      }
      expect(serviceTypeForDomain(classifyDomain('autosave_fee', '', ref, svc)),
          TransactionServiceType.fee);
    });

    test('a genuine insurance row on the same service still says insurance', () {
      expect(
        generateTransactionTitle('insurance_settle', 'debit',
            'Insurance premium', 'INS-123', svc),
        'Insurance Payment',
      );
    });
  });

  // ── AutoSave detail recovered from the ledger description ──────────────
  //
  // The accounts ledger stores no autosave metadata, so the receipt (and its
  // PDF) can only name the rule and trigger if they are parsed back out of the
  // description the service stamps.
  group('autosave details are recovered from the description', () {
    test('the exact prod description parses into rule + trigger', () {
      final d = autoSaveDetailsFromDescription(
          'AutoSave (manual_trigger): Save on wallet deposit');
      expect(d.ruleName, 'Save on wallet deposit');
      expect(d.triggerReason, 'manual_trigger');
      expect(autoSaveTriggerReasonLabel(d.triggerReason!), 'Manual save');
    });

    test('every trigger reason gets readable words', () {
      expect(autoSaveTriggerReasonLabel('scheduled_worker'), 'Scheduled');
      expect(autoSaveTriggerReasonLabel('round_up'), 'Round-up');
      expect(autoSaveTriggerReasonLabel('on_deposit'), 'On deposit');
      expect(autoSaveTriggerReasonLabel('external_inflow'), 'Bank inflow');
      expect(autoSaveTriggerReasonLabel('scheduled_external'),
          'Recurring bank debit');
      // An unknown reason is de-snaked rather than shown raw.
      expect(autoSaveTriggerReasonLabel('some_new_reason'), 'Some new reason');
    });

    test('a rule name containing a colon survives intact', () {
      final d = autoSaveDetailsFromDescription(
          'AutoSave (round_up): Rent: 2026 fund');
      expect(d.ruleName, 'Rent: 2026 fund');
      expect(d.triggerReason, 'round_up');
    });

    test('a description in another shape yields nothing, never a guess', () {
      for (final s in const [
        'Transfer to Grace',
        'AutoSave without parens',
        '',
      ]) {
        final d = autoSaveDetailsFromDescription(s);
        expect(d.ruleName, isNull, reason: s);
        expect(d.triggerReason, isNull, reason: s);
      }
    });
  });
}
