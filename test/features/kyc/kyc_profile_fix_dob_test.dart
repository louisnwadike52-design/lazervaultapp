import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/kyc/presentation/widgets/kyc_profile_fix.dart';

/// The classifier decides what a refusal OFFERS. A date-of-birth refusal that
/// classifies as [KycProfileField.none] renders a "Try Again" button against an
/// unchanged profile — the loop kyc_profile_fix.dart exists to prevent — and
/// that is exactly what happened when the editor shipped without teaching the
/// classifier about it.
void main() {
  group('kycProfileFieldFor — date of birth', () {
    test('the server\'s own DOB refusal routes to the editor', () {
      // Verbatim from banking-service reconcileSignupIdentity.
      const msg = 'The date of birth on your profile does not match this BVN';
      expect(kycProfileFieldFor(msg), KycProfileField.dateOfBirth,
          reason: 'a DOB refusal must offer the DOB editor, not Try Again');
    });

    test('the NIN wording routes there too', () {
      const msg = 'The date of birth on your profile does not match this NIN';
      expect(kycProfileFieldFor(msg), KycProfileField.dateOfBirth);
    });

    test('the combined details refusal is NOT swallowed as a DOB edit', () {
      // IDENTITY_DETAILS_MISMATCH. It mentions a date of birth but is a NAME
      // decision, routed by code before the classifier is consulted — so the
      // classifier must not claim it.
      const msg = 'The provided name or date of birth does not match BVN records';
      expect(kycProfileFieldFor(msg), isNot(KycProfileField.dateOfBirth));
    });

    test('an unrelated sentence mentioning a date is not captured', () {
      expect(kycProfileFieldFor('Your card expiry date of birth year is odd'),
          isNot(KycProfileField.dateOfBirth));
    });

    test('the field has a usable action label', () {
      expect(kycProfileFixLabel(KycProfileField.dateOfBirth), isNotEmpty);
      expect(kycProfileFixLabel(KycProfileField.dateOfBirth),
          isNot(equals('Try Again')));
    });
  });
}
