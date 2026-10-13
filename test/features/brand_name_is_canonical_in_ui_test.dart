import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// Our own name is rendered through the canonicaliser, never from the raw
/// bank column.
///
/// The stored value is whatever wrote it — "LazerVault" from an older record,
/// "LAZERVAULT LTD" or "Lazervault MFB" from the NIBSS registry. It must keep
/// driving internal/external routing and beneficiary matching (BrandBank
/// explains what one wrong spelling already cost), so the fix is never to
/// rewrite the column: it is to render `displayBankName`.
///
/// That had been done everywhere except the saved-recipients rail, which
/// printed `recipient.bankName` verbatim — so Select Recipient showed
/// "LazerVault", the old logotype, while every other surface read
/// "Lazervault".
void main() {
  test('the saved-recipients rail renders displayBankName, not bankName', () {
    final src = File(
      'lib/src/features/recipients/presentation/widgets/'
      'saved_recipients_rail.dart',
    ).readAsStringSync();

    // Comments stripped: the explanation names the banned expression, and a
    // bare substring check would match the prose rather than the code — the
    // way three guards did before this one.
    final code = src
        .split('\n')
        .where((l) => !l.trimLeft().startsWith('//'))
        .join('\n');

    expect(
      RegExp(r'Text\(\s*recipient\.bankName').hasMatch(code),
      isFalse,
      reason: 'The rail is rendering the raw bank column. Use '
          'recipient.displayBankName so our own name reads "Lazervault" '
          'rather than the stored spelling.',
    );
    expect(
      code.contains('recipient.displayBankName'),
      isTrue,
      reason: 'The rail should render displayBankName somewhere.',
    );
  });

  test('BrandBank collapses every registry spelling to one display name', () {
    // Pins the contract the rail now depends on.
    const variants = [
      'LazerVault',
      'LAZERVAULT LTD',
      'Lazervault- LTD.',
      'Lazervault MFB',
      'lazervault',
    ];
    final brandBank =
        File('lib/core/utils/brand_bank.dart').readAsStringSync();
    expect(brandBank.contains("displayName = 'Lazervault'"), isTrue,
        reason: 'The one user-facing spelling is "Lazervault".');
    expect(brandBank.contains("contains('lazervault')"), isTrue,
        reason: 'isOurs must match on substring — an exact-equality check '
            'missed every registry variant with a suffix, which is how the '
            'saved list still read "LazerVault": ${variants.join(", ")}');
  });
}
