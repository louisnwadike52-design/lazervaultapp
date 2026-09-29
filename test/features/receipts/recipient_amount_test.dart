import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/tag_pay/services/tag_pay_pdf_service.dart';

/// Praiz sent Grace ₦100 and paid a ₦23 fee. The ledger records ONE outgoing
/// debit of ₦123 (deliberately — one history row, with fees). The recipient's
/// copy took that figure straight and printed "Amount Received ₦123.00", and
/// the share sheet said "₦123.00 to GRACE C. ONWUANAKU".
///
/// Grace received ₦100. The ₦23 was Praiz's cost, and the document saying
/// otherwise is the one she keeps.
void main() {
  group('principal on a transfer receipt', () {
    test('an outgoing debit is principal + fee, so the fee comes off', () {
      // The production transfer: TRF-transfer_d557350c…, amount ₦100, fee ₦23.
      expect(TagPayPdfService.principalOfForTest(123.00, 23.00, false), 100.00);
    });

    test('an inflow is already the principal and must not be reduced', () {
      // The sender's fee was charged on THEIR ledger. Subtracting here would
      // understate what actually landed.
      expect(TagPayPdfService.principalOfForTest(100.00, 23.00, true), 100.00);
    });

    test('a zero fee changes nothing', () {
      expect(TagPayPdfService.principalOfForTest(100.00, 0, false), 100.00);
    });

    test('provider-agnostic: the rail never changes who paid the fee', () {
      // Same arithmetic whether Flutterwave, Nomba or anything else carried it.
      for (final fee in [10.75, 23.00, 26.88, 53.75]) {
        expect(
          TagPayPdfService.principalOfForTest(1000 + fee, fee, false),
          closeTo(1000, 0.001),
          reason: 'fee $fee',
        );
      }
    });

    test('a fee larger than the amount never prints a negative receipt', () {
      // That combination means the fee metadata does not belong to this row —
      // a mislabelled provider key, or a batch total in a per-leg field.
      // Printing the unadjusted figure is wrong; printing a negative one is
      // worse and unmistakably broken to whoever holds the document.
      expect(TagPayPdfService.principalOfForTest(100.00, 100.00, false), 100.00);
      expect(TagPayPdfService.principalOfForTest(100.00, 250.00, false), 100.00);
    });

    test('a nonsensical fee is ignored rather than propagated', () {
      expect(TagPayPdfService.principalOfForTest(100.00, -5, false), 100.00);
      expect(TagPayPdfService.principalOfForTest(100.00, double.nan, false), 100.00);
      expect(
          TagPayPdfService.principalOfForTest(100.00, double.infinity, false),
          100.00);
    });
  });
}
