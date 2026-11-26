import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/support/data/support_contact_info.dart';

/// NO SUPPORT ADDRESS IS HARDCODED IN A DOCUMENT.
///
/// Three PDF generators each carried a literal `support@lazervault.com`, while
/// the public website (27 occurrences), the transactional email templates (13)
/// and the app's help config all publish `support@lazervault.app`. A customer
/// who downloaded an exchange receipt, a batch-transfer report or an invoice
/// receipt was told to write somewhere different from every other surface.
///
/// A PDF is worse than a screen for this: it is generated once and then saved,
/// shared and printed, so a wrong address keeps saying so for as long as the
/// file exists.
void main() {
  group('the footer sentence', () {
    test('omits the email clause entirely when nothing is configured', () {
      final s = SupportContactInfo.sentence('For questions');
      expect(s, contains('through the Lazervault app'));
      expect(s, isNot(contains('@')),
          reason: 'a document must never print a guessed address — it would '
              'keep telling customers to write somewhere nobody reads');
      expect(s.trim(), endsWith('.'));
      expect(s, startsWith('For questions'));
    });

    test("the lead is the caller's, so each document reads naturally", () {
      expect(SupportContactInfo.sentence('For any queries'),
          startsWith('For any queries'));
      expect(SupportContactInfo.sentence('For help'), startsWith('For help'));
    });
  });

  group('no literal address survives in a document generator', () {
    test('the three PDF services read the setting', () {
      const files = [
        'lib/src/features/currency_exchange/services/exchange_pdf_service.dart',
        'lib/src/features/funds/services/batch_transfer_pdf_service.dart',
        'lib/src/features/invoice/services/invoice_pdf_service.dart',
      ];
      for (final path in files) {
        final src = File(path).readAsStringSync();
        expect(src, isNot(contains('support@lazervault')),
            reason: '$path must read SupportContactInfo, not a literal');
        expect(src, contains('SupportContactInfo'),
            reason: '$path should build its footer from the setting');
        expect(src, contains('SupportContactInfo.refresh()'),
            reason: '$path must warm the address before building pages');
      }
    });
  });
}
