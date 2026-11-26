// THE CHAINED RESOLVE MUST CARRY EVERY FACT THE FIRST ONE HAD.
//
// resolvePostLoginRoute answers "where next" once. When it sends the user to a
// verification screen it also computes where THAT screen should go afterwards,
// by calling itself with the newly-true fact — the `after()` helper inside
// signup_resume.dart.
//
// That helper forwarded a SUBSET of its inputs, and the two it dropped both
// have defaults that are wrong for a chained call:
//
//   phoneOtpDeliverable defaults TRUE. Dropped, the phone gate was re-decided
//   as if SMS could be delivered — so a user who verified their email was then
//   sent to a verify-phone screen for a code that cannot be sent. Skipping it
//   deliberately does not set phone_verified, so it recurred on every login:
//   exactly the loop that parameter was added to end.
//
//   mustChangeCredentials defaults FALSE. Dropped, a holder whose passcode was
//   set by an ADMIN could walk past the mandatory replacement step simply by
//   having an email verification ahead of it in the chain.
//
// A dropped named argument is not a compile error. It is a different answer,
// silently. So the property asserted here is equality: resolving twice must
// agree with resolving once from the same facts.
import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/core/utils/kyc_completion.dart';
import 'package:lazervault/src/features/authentication/presentation/utils/signup_resume.dart';

const _kycDone = KycLoginGate(state: KycState.verified, isRequired: true);

void main() {
  group('chained resolve preserves every input', () {
    test(
        'verifying email does not conjure a phone step when SMS cannot be sent',
        () {
      // A user with an unverified email AND an unverified phone, on a platform
      // with no SMS delivery. The email screen is correct; what follows it
      // must NOT be the phone screen.
      final first = resolvePostLoginRoute(
        step: null,
        status: null,
        email: 'holder@example.com',
        phone: '+2348031234567',
        hasPasscode: true,
        hasTransactionPin: true,
        kyc: _kycDone,
        phoneVerified: false,
        phoneOtpDeliverable: false, // no provider
        emailVerificationRequired: true,
        isEmailVerified: false,
      );

      expect(first.name, AppRoutes.emailVerification,
          reason: 'an unverified, required email comes first');

      // Where the email screen is told to go next.
      final next = first.args?['nextRoute'] as String?;
      expect(next, isNot(AppRoutes.phoneVerification),
          reason: 'phoneOtpDeliverable was dropped on the chained resolve, so '
              'the user is sent to ask for a code that cannot be delivered — '
              'and skipping it does not set the flag, so it recurs forever');

      // And it must equal resolving directly with the email now verified.
      final direct = resolvePostLoginRoute(
        step: null,
        status: null,
        email: 'holder@example.com',
        phone: '+2348031234567',
        hasPasscode: true,
        hasTransactionPin: true,
        kyc: _kycDone,
        phoneVerified: false,
        phoneOtpDeliverable: false,
        emailVerificationRequired: true,
        isEmailVerified: true,
      );
      expect(next, direct.name,
          reason: 'resolving twice must agree with resolving once');
    });

    test('an admin-set credential still blocks after an email verification',
        () {
      final first = resolvePostLoginRoute(
        step: null,
        status: null,
        email: 'holder@example.com',
        phone: '+2348031234567',
        hasPasscode: true,
        hasTransactionPin: true,
        kyc: _kycDone,
        phoneVerified: true,
        emailVerificationRequired: true,
        isEmailVerified: false,
        mustChangeCredentials: true,
      );

      // The credential gate outranks everything, so it is the FIRST answer.
      // If an email step somehow precedes it, what follows must still be the
      // credential replacement — never the dashboard.
      if (first.name == AppRoutes.emailVerification) {
        final next = first.args?['nextRoute'] as String?;
        expect(next, isNot(AppRoutes.dashboard),
            reason: 'mustChangeCredentials was dropped on the chained resolve, '
                'so a credential chosen by someone other than the holder '
                'survived — it is admitted exactly once, by design');
      }

      final direct = resolvePostLoginRoute(
        step: null,
        status: null,
        email: 'holder@example.com',
        phone: '+2348031234567',
        hasPasscode: true,
        hasTransactionPin: true,
        kyc: _kycDone,
        phoneVerified: true,
        emailVerificationRequired: true,
        isEmailVerified: true,
        mustChangeCredentials: true,
      );
      final String? chained = (first.name == AppRoutes.emailVerification)
          ? (first.args?['nextRoute'] as String?)
          : first.name;
      expect(chained, direct.name,
          reason: 'the chained answer must match the direct one');
    });

    test('the phone screen also chains with every fact intact', () {
      // Email done, phone outstanding and deliverable → phone screen, and what
      // follows it must match a direct resolve with the phone verified.
      final first = resolvePostLoginRoute(
        step: null,
        status: null,
        email: 'holder@example.com',
        phone: '+2348031234567',
        hasPasscode: true,
        hasTransactionPin: false, // a PIN step waits behind the phone step
        kyc: _kycDone,
        phoneVerified: false,
        phoneOtpDeliverable: true,
        isEmailVerified: true,
      );
      expect(first.name, AppRoutes.phoneVerification);

      final direct = resolvePostLoginRoute(
        step: null,
        status: null,
        email: 'holder@example.com',
        phone: '+2348031234567',
        hasPasscode: true,
        hasTransactionPin: false,
        kyc: _kycDone,
        phoneVerified: true,
        phoneOtpDeliverable: true,
        isEmailVerified: true,
      );
      expect(first.args?['nextRoute'], direct.name,
          reason: 'after verifying the phone the user must land where a direct '
              'resolve would have put them — here, the transaction-PIN setup');
    });
  });
}
