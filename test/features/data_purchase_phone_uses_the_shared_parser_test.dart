import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/core/utils/ng_msisdn.dart';

/// Every bill flow that takes a phone number is supposed to share ONE parser,
/// ng_msisdn.dart, which accepts the number the way people actually type it:
/// 0803…, 803…, +234803…, 00234803…, 234803…, and with spaces or dashes.
///
/// The data purchase recipient screen carried its OWN validator instead. It
/// stripped a leading zero and demanded exactly ten digits, so it accepted
/// 0803… and 803… and rejected every international spelling the airtime and
/// quick-buy fields already took — including a number pasted straight from a
/// contact saved as +234…. Two validators for one question is how they drift.
///
/// These pin the behaviour the screen now inherits, and that it inherits it
/// rather than reimplementing it.
void main() {
  group('the spellings a data purchase must accept', () {
    // All of these are the same subscriber.
    const spellings = <String>[
      '09046502258', // canonical, leading zero
      '9046502258', // what the +234 prefix asks for
      '2349046502258', // contact book
      '+2349046502258', // dialling code with the plus
      '002349046502258', // international access prefix
      '0904 650 2258', // spaced
      '0904-650-2258', // dashed
    ];

    test('every spelling resolves to the same national number', () {
      for (final s in spellings) {
        expect(ngNationalNumber(s), '9046502258',
            reason: '"$s" must be accepted — it is the number on the receipt '
                'from the reported purchase, typed another way');
      }
    });

    test('every spelling normalises to the one shape providers want', () {
      for (final s in spellings) {
        expect(normaliseNgMsisdn(s), '09046502258',
            reason: 'providers are always sent the 11-digit 0-prefixed form, '
                'never the raw field text');
      }
    });
  });

  group('what must still be refused', () {
    test('a non-mobile prefix', () {
      // Nigerian mobile national numbers begin 7, 8 or 9. These flows top up
      // a SIM, so a landline is correctly refused.
      expect(ngNationalNumber('0104650225'), isNull);
      expect(isValidNgMsisdn('01046502258'), isFalse);
    });

    test('too few and too many digits', () {
      expect(isValidNgMsisdn('090465022'), isFalse);
      expect(isValidNgMsisdn('090465022589'), isFalse);
    });

    test('the hint stays quiet while the number is still being typed', () {
      // Shouting "invalid" at the third keystroke is noise; the disabled
      // button already says "not yet".
      expect(ngMsisdnHint('090'), isNull);
      expect(ngMsisdnHint('0904650'), isNull);
      expect(ngMsisdnHint(''), isNull);
      // ...but says something once there is enough to judge.
      expect(ngMsisdnHint('01046502258'), isNotNull);
    });
  });

  group('the data recipient screen', () {
    late String src;

    setUpAll(() {
      final f = File(
          'lib/src/features/data_bundles/presentation/view/data_recipient_input_screen.dart');
      expect(f.existsSync(), isTrue, reason: 'screen moved — re-point this test');
      // Comments stripped: that file explains this change and names the
      // parser, so a raw scan would match the explanation.
      src = f
          .readAsStringSync()
          .split('\n')
          .where((l) => !l.trimLeft().startsWith('//'))
          .join('\n');
    });

    test('uses the shared parser rather than its own', () {
      expect(src.contains('ngNationalNumber('), isTrue,
          reason: 'the screen must normalise through ng_msisdn.dart; a local '
              'copy drifts from the one every other bill flow uses');
    });

    test('lets the accepted international spellings be typed at all', () {
      // digitsOnly silently ate the + from a pasted +234 number, leaving
      // 234… which then read as the wrong length.
      expect(src.contains('digitsOnly'), isFalse,
          reason: 'digitsOnly strips the + that +234… spellings need');
      expect(src.contains("RegExp(r'[0-9+]')"), isTrue,
          reason: 'the field must accept digits and a leading +');
    });

    test('still limits length as you type', () {
      // 15 = 00234 + ten digits, the longest accepted spelling. Capping at 11
      // made a pasted +2348031234567 untypeable.
      expect(src.contains('LengthLimitingTextInputFormatter(15)'), isTrue,
          reason: 'typing must still be bounded, just not below the longest '
              'spelling the parser accepts');
    });
  });
}
