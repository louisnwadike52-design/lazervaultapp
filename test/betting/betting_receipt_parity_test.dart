import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// One receipt, identical whichever way it is opened.
///
/// WHAT WAS WRONG. Four routes reach BettingReceiptScreen — the processing
/// screen after a purchase, the quick-buy shortcut, the home recent strip and
/// the full history — and they disagreed about what to send it:
///
///   quick_buy            passed ONLY `result`
///   processing           passed platformName + accountName
///   history / home       passed platformName, and `accountName: ''`
///
/// So straight after a purchase the receipt rendered a tick above an empty
/// platform and an empty name, and from history the funded account was never
/// shown at all. Same screen, three different amounts of truth.
///
/// Both values live on the payment record that every caller already passes,
/// so the screen reads them from there and an explicit argument only wins
/// when a caller has something better (quick-buy knows the platform's display
/// name; the record stores its slug). That is what makes the post-purchase
/// receipt match the one from history, rather than four call sites each
/// remembering to pass the same things.
void main() {
  String codeOf(String path) => File(path)
      .readAsStringSync()
      .split('\n')
      .where((l) => !l.trimLeft().startsWith('//'))
      .join('\n');

  const receipt =
      'lib/src/features/betting/presentation/view/betting_receipt_screen.dart';

  group('betting receipt payload parity', () {
    test('the receipt falls back to the payment record', () {
      final src = codeOf(receipt);
      expect(src.contains('record?.platform'), isTrue,
          reason: 'the platform no longer falls back to the payment record, '
              'so a caller that omits it renders a blank platform');
      expect(src.contains('record?.customerNumber'), isTrue,
          reason: 'the funded account no longer falls back to the record, '
              'which is how history receipts showed an empty account');
    });

    test('a whitespace-only argument counts as blank', () {
      final src = codeOf(receipt);
      expect(src.contains('_firstNonEmpty'), isTrue,
          reason: 'the fallback helper is gone');
      expect(src.contains('.trim()'), isTrue,
          reason: 'an argument of " " is blank to a reader even though it is '
              'not empty to Dart; untrimmed, it defeats the fallback');
    });

    test('no caller hardcodes an empty account name', () {
      // The original defect in its most literal form. A caller passing '' is
      // indistinguishable from one passing nothing, except that it looks
      // deliberate — and before the fallback existed it silently won.
      for (final path in [
        'lib/src/features/betting/presentation/view/betting_history_screen.dart',
        'lib/src/features/betting/presentation/view/betting_home_screen.dart',
        'lib/src/features/betting/presentation/widgets/betting_quick_buy.dart',
        'lib/src/features/betting/presentation/view/betting_processing_screen.dart',
      ]) {
        final src = codeOf(path);
        if (!src.contains('AppRoutes.bettingReceipt')) continue;
        expect(
          src.contains("'accountName': ''"),
          isFalse,
          reason: '$path passes an empty accountName to the receipt. Omit it '
              'and let the payment record supply it, or pass a real value.',
        );
      }
    });

    test('quick-buy supplies the platform display name', () {
      final src =
          codeOf('lib/src/features/betting/presentation/widgets/betting_quick_buy.dart');
      expect(src.contains("'platformName': _platform?.name"), isTrue,
          reason: 'quick-buy holds the platform DISPLAY name while the record '
              'stores its slug; dropping it shows the customer a slug');
    });
  });
}
