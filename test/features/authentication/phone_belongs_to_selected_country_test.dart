import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/core/config/country_config.dart';

/// A NUMBER MUST BELONG TO THE COUNTRY THE CUSTOMER PICKED.
///
/// ## The defect
///
/// A real account was created on the Nigerian locale holding a UK phone
/// number. It happened because the legacy signup screen validated the phone by
/// LENGTH alone, and a UK mobile NSN is ten digits — exactly like a Nigerian
/// one. The app then assembled +234 followed by a UK subscriber number: a
/// number nobody owns. The account is created against it and its owner is
/// stuck at an SMS step forever, because no code can ever arrive.
///
/// ## Why the fix is a shared validator, not a new rule
///
/// `CountryCode.validateNationalNumber` already checked the mobile PREFIX as
/// well as the length, and `phone_entry_screen` and `forgot_passcode_phone`
/// had both used it from the start. The legacy signup screen carried its own
/// length-only table and was the single path that did not — which is why the
/// gap existed there and nowhere else. The fix routes it through the same
/// validator rather than teaching a second place the same rules, because two
/// copies of a rule is how this happened.
void main() {
  group('Nigerian locale rejects a number that is not Nigerian', () {
    const ng = CountryCode.nigeria;

    test('THE PROD CASE: a UK mobile NSN is refused', () {
      // 7911 123456 — a real UK mobile shape. Ten digits, so every
      // length check in the app passes it.
      expect(
        ng.validateNationalNumber('7911123456'),
        isNotNull,
        reason:
            'a UK number must not be accepted as Nigerian merely '
            'because it is the right length',
      );
    });

    test('the length alone would NOT have caught it', () {
      // Stated explicitly: this is why length-only validation failed.
      expect('7911123456'.length, ng.nationalNumberLength);
    });

    test('real Nigerian mobile prefixes are accepted', () {
      for (final nsn in <String>[
        '8031234567', // 080
        '8131234567', // 081
        '9031234567', // 090
        '9131234567', // 091
        '7031234567', // 070
        '7131234567', // 071
      ]) {
        expect(
          ng.validateNationalNumber(nsn),
          isNull,
          reason: '$nsn is a valid NG mobile NSN',
        );
      }
    });

    test('a right-length but meaningless number is refused', () {
      expect(ng.validateNationalNumber('1234567890'), isNotNull);
    });

    test('wrong lengths are still refused', () {
      expect(ng.validateNationalNumber('80312345'), isNotNull);
      expect(ng.validateNationalNumber('803123456789'), isNotNull);
    });
  });

  /// The trunk "0" is the form most Nigerians actually type ("0803…"), and the
  /// signup screen accepts it. It must be stripped BEFORE the shared validator
  /// sees it, or every correctly-typed number is rejected for being one digit
  /// too long — a far worse bug than the one being fixed.
  test('the signup screen strips the trunk 0 before validating', () {
    const ng = CountryCode.nigeria;
    expect(
      ng.validateNationalNumber('08031234567'),
      isNotNull,
      reason: 'the validator itself takes a bare NSN',
    );
    expect(
      ng.validateNationalNumber('08031234567'.substring(1)),
      isNull,
      reason: 'stripped, it is the same valid number',
    );

    final src = File(
      'lib/src/features/authentication/presentation/widgets/sign_up.dart',
    ).readAsStringSync();
    expect(
      src.contains('isTrunkAndNsn ? raw.substring(1) : raw'),
      isTrue,
      reason:
          'sign_up.dart must strip the trunk 0 it just accepted before '
          'handing the number to the shared validator',
    );
  });

  /// Every screen that takes a phone number during onboarding or recovery has
  /// to use the SAME validator. The defect was one screen having its own.
  test('all phone entry points use the shared country validator', () {
    const paths = <String>[
      'lib/src/features/authentication/presentation/widgets/sign_up.dart',
      'lib/src/features/authentication/presentation/views/phone_entry_screen.dart',
      'lib/src/features/authentication/presentation/views/forgot_passcode_phone_screen.dart',
    ];
    for (final p in paths) {
      final src = File(p).readAsStringSync();
      expect(
        src.contains('validateNationalNumber'),
        isTrue,
        reason:
            '$p takes a phone number and must validate it against the '
            'selected country, prefix included — a length check alone lets '
            'a UK number through as Nigerian',
      );
    }
  });
}
