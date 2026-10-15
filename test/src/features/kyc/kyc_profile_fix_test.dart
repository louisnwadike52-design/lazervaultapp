import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/kyc/presentation/widgets/kyc_profile_fix.dart';

/// Reported: identity verification refused with "we need a valid Nigerian
/// phone number (0 followed by 10 digits) on your profile … Please update
/// your phone and try again", and the dialog offered Cancel and **Try Again**.
/// Trying again runs the identical check against the identical profile and
/// fails identically. The one action that could help was the one the screen
/// would not take the user to.
///
/// These are the EXACT strings banking-service produces, copied from
/// prove_kyc.go and prove_kyc_progress.go. If a message is reworded there and
/// not here, this test is what notices — the app shows the server's sentence
/// verbatim and classifies on it.
void main() {
  group('a refusal about the profile names the field to fix', () {
    test('the reported case: no Nigerian phone', () {
      expect(
        kycProfileFieldFor(
            'we need a valid Nigerian phone number (0 followed by 10 digits) '
            'on your profile to verify your identity. Please update your '
            'phone and try again'),
        KycProfileField.phone,
      );
    });

    test('a phone that exists but is unusable', () {
      expect(
        kycProfileFieldFor('the phone number on your profile looks invalid '
            'for verification. Please update it and try again'),
        KycProfileField.phone,
      );
    });

    test('no email', () {
      expect(
        kycProfileFieldFor('we need a valid email on your profile to verify '
            'your identity. Please add one and try again'),
        KycProfileField.email,
      );
    });

    test('no name', () {
      expect(
        kycProfileFieldFor('we need your name on your profile to verify your '
            'identity. Please complete your profile and try again'),
        KycProfileField.name,
      );
    });
  });

  group('everything else keeps plain Try Again', () {
    test('a provider or network failure is not the user to fix', () {
      for (final m in [
        'Verification service is temporarily unavailable. Please try again.',
        'Session token not available. Please try again.',
        'Failed to launch verification. Please try again.',
        'BVN could not be verified at this time',
      ]) {
        expect(kycProfileFieldFor(m), KycProfileField.none, reason: m);
      }
    });

    test('empty and null are not a profile problem', () {
      expect(kycProfileFieldFor(null), KycProfileField.none);
      expect(kycProfileFieldFor(''), KycProfileField.none);
    });

    test('a bank NAME in an unrelated message is not the profile name', () {
      // "name" alone is too common a word to key on; the profile rule is
      // guarded on "profile" appearing too.
      expect(
        kycProfileFieldFor('the account name returned by the bank did not match'),
        KycProfileField.none,
      );
    });
  });

  group('the button says which field', () {
    test('it names the field rather than "Open Settings"', () {
      expect(kycProfileFixLabel(KycProfileField.phone), 'Update phone');
      expect(kycProfileFixLabel(KycProfileField.email), 'Update email');
      expect(kycProfileFixLabel(KycProfileField.name), 'Update profile');
    });

    test('an unclassified failure keeps the ordinary retry', () {
      expect(kycProfileFixLabel(KycProfileField.none), 'Try Again');
    });
  });
}
