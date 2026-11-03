import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/kyc/presentation/widgets/kyc_profile_fix.dart';

/// WHERE A KYC REFUSAL SENDS THE CUSTOMER.
///
/// The dialog's primary button is chosen by matching the SERVER's sentence,
/// so the copy decides the destination — and the destination has to be
/// somewhere they can actually act. Two real mis-routes are pinned here:
///
///  * "this BVN is already linked to another account" classified as `none`,
///    so the button was **Try Again** — which resubmits the same BVN against
///    the same row and fails identically.
///  * a name refusal said "name" and "profile", which routes to the profile
///    editor — where the name is READ-ONLY ("Verified — contact support to
///    change"), because names are immutable on this platform.
void main() {
  group('already-linked BVN', () {
    test('goes to support, never a futile retry', () {
      for (final m in [
        'this BVN is already linked to another account',
        'This NIN is already linked to another account',
      ]) {
        expect(kycProfileFieldFor(m), KycProfileField.support,
            reason: 'must not offer Try Again: $m');
      }
      expect(kycProfileFixLabel(KycProfileField.support), 'Contact support');
    });
  });

  group('the live server messages', () {
    test('a name refusal lands on Try Again, not the read-only editor', () {
      // banking-service proveNameMismatchMessage(), verbatim.
      const refusal = 'The BVN you entered belongs to a different person. '
          'Check the number and try again.';
      expect(kycProfileFieldFor(refusal), KycProfileField.none);
      expect(kycProfileFixLabel(kycProfileFieldFor(refusal)), 'Try Again');
    });

    test('a profile-data refusal still reaches the field it names', () {
      expect(kycProfileFieldFor('we need a Nigerian phone number on your profile'),
          KycProfileField.phone);
      expect(kycProfileFieldFor('we need an email address'),
          KycProfileField.email);
    });

    test('an unrecognised message degrades to Try Again', () {
      // Never to a navigation the message did not ask for.
      expect(kycProfileFieldFor('the provider is unavailable'),
          KycProfileField.none);
      expect(kycProfileFieldFor(null), KycProfileField.none);
      expect(kycProfileFieldFor(''), KycProfileField.none);
    });
  });
}
