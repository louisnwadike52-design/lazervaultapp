import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// Saved-payee matching must behave the SAME on every surface that takes a
/// bare account number — send funds, batch transfer and split bill.
///
/// They were already three copies of the account-first flow, and the copies had
/// drifted once: `suggestBanks` rejected 11-digit wallet numbers, which all
/// three inherited silently. Pinning the shared wiring here is what stops the
/// next divergence from being invisible.
///
/// Source assertions rather than widget pumps: each of these screens needs a
/// service locator, several blocs and ScreenUtil, and what breaks is a value
/// not passed or a branch on the wrong condition — both of which compile.
/// Behaviour itself is covered against the cubit in
/// test/src/features/recipients/saved_payee_as_you_type_test.dart.
void main() {
  const surfaces = <String, String>{
    'send funds':
        'lib/src/features/recipients/presentation/widgets/add_recipient.dart',
    'batch transfer':
        'lib/src/features/funds/presentation/widgets/batch_transfer/batch_transfer_form_part2.dart',
    'split bill':
        'lib/src/features/split_bills/presentation/view/create_split_bill_screen.dart',
  };

  late final Map<String, String> src;

  setUpAll(() {
    src = {
      for (final e in surfaces.entries) e.key: File(e.value).readAsStringSync(),
    };
  });

  for (final name in surfaces.keys) {
    group(name, () {
      test('matches saved payees as the number is typed', () {
        expect(
          RegExp(r'savedRecipientMatches\(').hasMatch(src[name]!),
          isTrue,
          reason: '$name never asks for saved payees, so the dropdown is '
              'dead on that surface',
        );
      });

      test('bounds come from admin settings, not literals', () {
        expect(src[name]!.contains('FeatureFlags.savedPayeeMinDigits'), isTrue,
            reason: 'a hardcoded threshold on $name cannot be tuned, and '
                'this one controls how much of a payee book is shown over '
                "the payer's shoulder");
        expect(src[name]!.contains('FeatureFlags.savedPayeeMaxRows'), isTrue);
      });

      test('selecting a match fills the field with the FULL number', () {
        expect(
          RegExp(r'_sync\w*AccountField\w*\(').hasMatch(src[name]!),
          isTrue,
          reason: 'a row can be tapped from a PARTIAL number on $name. '
              'Without writing the full number back, the controller keeps the '
              'few digits typed while the form holds a resolved payee — a '
              'state the verify path cannot act on.',
        );
      });

      test('an empty resolution does not erase the saved rows', () {
        expect(
          src[name]!.contains('suggestions.isNotEmpty'),
          isTrue,
          reason: 'on $name a bank lookup that resolves nothing overwrites '
              'the list with [], taking back saved rows that are still '
              'correct — a complete 10-digit entry legitimately prefixes an '
              '11-digit saved wallet number',
        );
      });

      test('a saved-only preview is distinguishable from a resolution', () {
        expect(
          RegExp(r'_\w*[sS]avedOnlyPreview').hasMatch(src[name]!),
          isTrue,
          reason: '$name cannot tell a typing preview from a resolved list, '
              'so it will label saved payees as resolved destinations',
        );
      });
    });
  }

  test('all three surfaces share one matcher — no local reimplementation', () {
    for (final name in surfaces.keys) {
      expect(
        src[name]!.contains('.savedRecipientMatches('),
        isTrue,
        reason: '$name should call the cubit, not grow its own copy of the '
            'digits-only prefix/contains ranking',
      );
    }
  });
}
