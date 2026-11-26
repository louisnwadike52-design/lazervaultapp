import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/kyc/presentation/widgets/kyc_profile_fix.dart';

/// A NAME LOCKED AT THE VERIFICATION PARTNER IS NOT A RETRY.
///
/// Our partner registers a customer against the first accepted session and
/// refuses any later one carrying a different name. banking-service now
/// realigns that automatically from the name we recorded at the time; when it
/// cannot, only a human can clear it.
///
/// Measured in production 2026-11-09: before any of this existed, one customer
/// made 27 attempts, every one answered with "try again in a moment". These
/// tests pin that the refusal reaches a Contact-support button instead.
void main() {
  group('NAME_LOCKED_WITH_PARTNER', () {
    test('the error CODE routes to support whatever the prose says', () {
      // The code is the robust signal: it survives a copy edit of the message.
      expect(
        kycProfileFieldFor('anything at all', code: 'NAME_LOCKED_WITH_PARTNER'),
        KycProfileField.support,
      );
      expect(
        kycProfileFieldFor('', code: 'NAME_LOCKED_WITH_PARTNER'),
        KycProfileField.support,
      );
    });

    test('the wording also routes to support when no code is carried', () {
      // Older servers, and any path that surfaces the message through a
      // generic catch, do not carry a code.
      const msg = 'the name on your account does not match the one our '
          'verification partner holds for you, and we could not realign it '
          'automatically. Our support team can update it with them — please '
          'contact support';
      expect(kycProfileFieldFor(msg), KycProfileField.support);
    });

    test('it is NOT mistaken for the "name on your profile" fix', () {
      // That one opens the name editor, which is the wrong destination here:
      // editing the name again is what caused the lock.
      expect(
        kycProfileFieldFor('we need your name on your profile to verify'),
        KycProfileField.name,
      );
    });

    test('an unrelated message mentioning a name still retries', () {
      // The fallback matcher requires all three of partner + name + support,
      // so ordinary refusals are untouched.
      expect(kycProfileFieldFor('the bank name could not be resolved'),
          KycProfileField.none);
      expect(kycProfileFieldFor('we could not validate that BVN'),
          KycProfileField.none);
    });

    test('support is offered as Contact support, never Try Again', () {
      expect(kycProfileFixLabel(KycProfileField.support), 'Contact support');
      expect(kycProfileFixLabel(KycProfileField.none), 'Try Again');
    });
  });

  group('the existing classifications are unchanged', () {
    test('phone, email and already-linked still route as before', () {
      expect(kycProfileFieldFor('we need a valid Nigerian phone number'),
          KycProfileField.phone);
      expect(kycProfileFieldFor('we need a valid email on your profile'),
          KycProfileField.email);
      expect(kycProfileFieldFor('that BVN is already linked to another account'),
          KycProfileField.support);
      expect(kycProfileFieldFor(null), KycProfileField.none);
      expect(kycProfileFieldFor(''), KycProfileField.none);
    });
  });
}
