import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/core/types/unified_transaction.dart';
import 'package:lazervault/src/features/transaction_history/data/repository/transaction_classifier.dart';

/// financial-products-service is a MULTI-PRODUCT service: autosave, insurance,
/// crowdfund, uplift (Lazerfunds) and the pool all write through it. Its
/// `service_name` therefore says NOTHING about which product a row belongs to,
/// and the classifier's service_name fallback answers "insurance" for the whole
/// service.
///
/// That fallback has now mislabelled two different products in production:
///
///   * AutoSave credits showed as "Insurance Refund" under a shield icon. Fixed
///     by classifying on the category ahead of the fallback.
///   * Crowdfund donations showed as "Insurance Payment" under a shield icon —
///     the same bug, in the same branch, left behind by the same fix.
///
/// Uplift/Lazerfunds sits in the identical trap and was never exercised.
///
/// These tests pin the rule that prevents a third occurrence: for any row
/// written by financial-products-service, the CATEGORY decides the product, and
/// `insurance` is only ever the answer for an actual insurance category.
void main() {
  const fp = 'financial-products-service';

  String title(String category, String type, String description,
          {String ref = ''}) =>
      generateTransactionTitle(category, type, description, ref, fp);

  TransactionServiceType? svcType(String category, String description,
          {String ref = ''}) =>
      serviceTypeForDomain(classifyDomain(category, description, ref, fp));

  group('crowdfund is never insurance', () {
    // The exact shape of the production rows behind the bug report. Both are
    // real: `category='crowdfund_contribution'`, `service_name=
    // 'financial-products-service'`, description naming the campaign.
    const donationDesc = 'Crowdfund contribution to: Expand Glora to 54 '
        'African Countries';

    test('a donation debit is a Crowdfund Donation, not an Insurance Payment',
        () {
      expect(title('crowdfund_contribution', 'debit', donationDesc),
          'Crowdfund Donation');
    });

    test('the campaign-wallet credit leg reads as received, not a refund', () {
      // creditCampaignWallet books the credit with the same category, so the
      // direction alone must separate the two legs of one donation.
      expect(
        title('crowdfund_contribution', 'credit',
            'Crowdfund contribution received: Expand Glora'),
        'Crowdfund Received',
      );
    });

    test('a donation carries the crowdfund icon, not the insurance shield', () {
      expect(svcType('crowdfund_contribution', donationDesc),
          TransactionServiceType.crowdfund);
    });

    test('refunds and payouts stay on the crowdfund identity', () {
      expect(svcType('crowdfund_refund', 'Crowdfund refund'),
          TransactionServiceType.crowdfund);
      expect(svcType('crowdfund_withdrawal', 'Crowdfund withdrawal'),
          TransactionServiceType.crowdfund);
    });
  });

  group('lazerfunds (uplift) is never insurance', () {
    test('a commitment debit is not an Insurance Payment', () {
      expect(title('uplift_commitment', 'debit', 'Lazerfunds commitment'),
          'Lazerfunds Commitment');
    });

    test('a disbursement credit carries the Lazerfunds identity', () {
      expect(svcType('uplift_disbursement', 'Milestone release'),
          TransactionServiceType.lazerfunds);
    });
  });

  group('autosave stays fixed', () {
    test('a save credit is not an Insurance Refund', () {
      expect(title('auto_save', 'credit', 'AutoSave deposit'),
          'Auto-Save Deposit');
      expect(svcType('auto_save', 'AutoSave deposit'),
          TransactionServiceType.autosave);
    });
  });

  group('insurance itself is untouched', () {
    // The fallback must keep working for the product it was actually right
    // about — this is a narrowing, not a removal.
    test('a real insurance row still classifies as insurance', () {
      expect(svcType('insurance_premium', 'Insurance premium payment'),
          TransactionServiceType.insurance);
      expect(title('insurance_premium', 'debit', 'Insurance premium payment'),
          'Insurance Payment');
    });

    test('a row with no product signal still falls back to insurance', () {
      // Unchanged behaviour: when the category tells us nothing, the
      // service_name fallback is all there is.
      expect(svcType('hold_capture', 'Capture'),
          TransactionServiceType.insurance);
    });
  });
}
