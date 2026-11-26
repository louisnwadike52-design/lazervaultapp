import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/kyc/presentation/widgets/kyc_profile_fix.dart';

/// WHAT A CUSTOMER WITH NO DATE OF BIRTH IS OFFERED.
///
/// The case, from production on 2026-11-24: a holder signed up with
/// phone+passcode (which captures no date of birth), entered his BVN, and
/// banking-service refused twice with "name mismatch with no comparable date
/// of birth — refusing". The app answered with a dialog offering a NAME edit
/// — against a registry spelling it deliberately never shows him — so the one
/// action that would have cleared the check was the one action absent. He gave
/// up on Tier 2 and abandoned a Tier-1 session seventeen seconds in.
///
/// `reconcileSignupIdentity` refuses a name difference ONLY when it has no
/// date to corroborate with; when a date IS comparable and agrees, the
/// registry's spelling is adopted and the check passes. So the date of birth
/// is the lever, and these pin that it is the one offered.
void main() {
  // Verbatim from banking-service identity_signup_reconcile.go.
  const detailsMsg =
      'The provided name or date of birth does not match BVN records';
  const detailsCode = 'IDENTITY_DETAILS_MISMATCH';

  group('IDENTITY_DETAILS_MISMATCH', () {
    test('with no date of birth on file, the DATE is what is offered', () {
      expect(
        kycProfileFieldFor(detailsMsg,
            code: detailsCode, profileHasDateOfBirth: false),
        KycProfileField.dateOfBirth,
        reason: 'supplying a date is what makes the registry name adoptable; '
            'a name edit is a guess at a spelling we never show',
      );
    });

    test('with a date on file, the NAME editor stays the destination', () {
      expect(
        kycProfileFieldFor(detailsMsg,
            code: detailsCode, profileHasDateOfBirth: true),
        KycProfileField.name,
        reason: 'our date is present, so the registry half is the missing one '
            'and nothing the customer types about a date can fix it',
      );
    });

    test('when the caller does not know, it is still not a dead end', () {
      // The regression this closes: the message carries neither "your
      // profile" nor "profile", so every message-only classifier returned
      // `none` — a bare Try Again against an unchanged profile.
      expect(kycProfileFieldFor(detailsMsg, code: detailsCode),
          isNot(KycProfileField.none));
    });

    test('the code is matched case- and whitespace-insensitively', () {
      expect(
        kycProfileFieldFor(detailsMsg,
            code: '  identity_details_mismatch ',
            profileHasDateOfBirth: false),
        KycProfileField.dateOfBirth,
      );
    });

    test('the message alone is still NOT read as a DOB refusal', () {
      // Unchanged contract: without the code this is a name decision, and the
      // "date of birth on YOUR PROFILE" matcher must not claim it.
      expect(kycProfileFieldFor(detailsMsg),
          isNot(KycProfileField.dateOfBirth));
    });
  });

  group('the screens pass what they know', () {
    test('bvn_signup offers the date when the profile has none', () {
      final src = File(
              'lib/src/features/kyc/presentation/views/bvn_signup_screen.dart')
          .readAsStringSync();
      expect(src.contains('_hasNoDateOfBirthOnFile'), isTrue,
          reason: 'the IDENTITY_DETAILS_MISMATCH branch must ask whether a '
              'date of birth exists before offering a name edit');
      expect(src.contains('_showMissingDobDialog'), isTrue);
      expect(src.contains('missingNotMismatched'), isTrue,
          reason: 'the support ticket must describe the right problem');
    });

    test('bvn_verification passes profileHasDateOfBirth', () {
      final src = File(
              'lib/src/features/kyc/presentation/views/bvn_verification_screen.dart')
          .readAsStringSync();
      expect(src.contains('profileHasDateOfBirth:'), isTrue,
          reason: 'Tier 3 classifies by message, so without this an '
              'IDENTITY_DETAILS_MISMATCH renders a bare Try Again');
      expect(src.contains('_hasDateOfBirthOnFile'), isTrue);
    });
  });
}
