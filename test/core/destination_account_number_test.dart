import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/core/utils/destination_account_number.dart';

/// ONE definition of "a complete destination account number", and proof that
/// every field which takes one is capped to hold it.
///
/// The rule lived in four copies. A copy that drifts fails quietly: the field
/// accepts a number nothing acts on, or a validator rejects one the payer can
/// see is right. Split bill had both — `maxLength: 10` beside a `^\d{10}$`
/// validator, so an 11-digit wallet number was untypeable AND would have been
/// called invalid.
void main() {
  group('the rule', () {
    test('a 10-digit NUBAN is complete', () {
      expect(isCompleteDestinationAccount('0123456789'), isTrue);
    });

    test('an 11-digit wallet number with its leading zero is complete', () {
      expect(isCompleteDestinationAccount('08012345678'), isTrue,
          reason: 'OPay, PalmPay and Moniepoint assign phone-number-based '
              'accounts; core-payments normalizePhoneAccount reduces this to '
              'the same NUBAN, so refusing it refuses a number the backend '
              'would have resolved');
    });

    test('11 digits NOT starting with zero is a typo, not a wallet', () {
      expect(isCompleteDestinationAccount('18012345678'), isFalse);
    });

    test('short, long and empty are all incomplete', () {
      for (final v in ['', '  ', '012', '012345678', '012345678901']) {
        expect(isCompleteDestinationAccount(v), isFalse, reason: 'for "$v"');
      }
    });

    test('separators are tolerated — saved rows carry them', () {
      expect(isCompleteDestinationAccount('0123-456-789'), isTrue);
      expect(isCompleteDestinationAccount('0801 234 5678'), isTrue);
      expect(destinationAccountDigits('0123-456-789'), '0123456789');
    });

    test('the cap can hold everything the rule accepts', () {
      expect(kDestinationAccountMaxLength, 11,
          reason: 'a field capped below the rule is a dead end the payer '
              'cannot escape');
    });
  });

  group('every destination field obeys it', () {
    const fields = <String, String>{
      'send funds':
          'lib/src/features/recipients/presentation/widgets/add_recipient.dart',
      'batch transfer':
          'lib/src/features/funds/presentation/widgets/batch_transfer/batch_transfer_form_part2.dart',
      'split bill':
          'lib/src/features/split_bills/presentation/view/create_split_bill_screen.dart',
    };

    for (final e in fields.entries) {
      test('${e.key} has no 10-digit assumption left', () {
        final src = File(e.value)
            .readAsLinesSync()
            // Drop comment lines: they discuss the old rule on purpose.
            .where((l) => !l.trimLeft().startsWith('//'))
            .join('\n');
        for (final bad in [
          'maxLength: 10,',
          'LengthLimitingTextInputFormatter(10)',
          r'\d{10}$',
        ]) {
          expect(src.contains(bad), isFalse,
              reason: '${e.key} still carries "$bad" — an 11-digit wallet '
                  'number is either untypeable there or rejected after '
                  'being typed');
        }
      });
    }

    test('the two widened surfaces use the shared rule, not a local copy', () {
      for (final key in ['batch transfer', 'split bill']) {
        final src = File(fields[key]!).readAsStringSync();
        expect(src.contains('isCompleteDestinationAccount('), isTrue,
            reason: '$key should ask the one helper, not re-derive the rule');
      }
    });
  });
}
