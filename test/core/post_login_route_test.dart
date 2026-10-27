// Validates the shared post-login routing that ALL SIX successful-auth surfaces
// use — email/password sign-in, the passcode lock screen, email+passcode,
// phone+passcode, 2FA verification and the step-up OTP screen — plus the
// biometric and voice unlocks that funnel through the same navigator.
//
// The rule under test: every gate reads the FACT it exists to change
// (has_passcode, phone_verified, email_verified, has_transaction_pin, the KYC
// fields), never the signup step label. The label put a Tier-3 holder into a
// "You're Verified" screen and a passcode holder into "Set Up Passcode" on
// every login; these tests are what stops that happening again.
import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/core/utils/kyc_completion.dart';
import 'package:lazervault/src/features/authentication/domain/entities/user.dart';
import 'package:lazervault/src/features/authentication/presentation/utils/signup_resume.dart';

const _required = KycLoginGate(state: KycState.unverified, isRequired: true);
const _notRequired =
    KycLoginGate(state: KycState.unverified, isRequired: false);
const _verifiedRequired =
    KycLoginGate(state: KycState.verified, isRequired: true);

void main() {
  group('resolvePostLoginRoute — completed signup gates', () {
    test('has passcode + PIN → dashboard', () {
      final r = resolvePostLoginRoute(
        step: null,
        status: 'complete',
        email: 'a@b.com',
        phone: '+2348012345678',
        hasPasscode: true,
        hasTransactionPin: true,
        kyc: KycLoginGate.none,
      );
      expect(r.name, AppRoutes.dashboard);
    });

    test('has passcode, NO PIN → transaction-PIN setup', () {
      final r = resolvePostLoginRoute(
        step: null,
        status: 'complete',
        email: 'a@b.com',
        hasPasscode: true,
        hasTransactionPin: false,
        kyc: KycLoginGate.none,
      );
      expect(r.name, AppRoutes.transactionPinSetup);
      expect(r.args?['fromLoginFlow'], true);
    });

    test('NO passcode → passcode setup, flagged as the login flow (no skip)',
        () {
      final r = resolvePostLoginRoute(
        step: null,
        status: 'complete',
        email: 'a@b.com',
        hasPasscode: false,
        hasTransactionPin: false,
        kyc: KycLoginGate.none,
      );
      expect(r.name, AppRoutes.passcodeSetup);
      expect(r.args?['fromLoginFlow'], true);
      expect(r.args?['hasTransactionPin'], false);
    });

    test('legacy account (status null) falls through to the gates → dashboard',
        () {
      final r = resolvePostLoginRoute(
        step: null,
        status: null,
        email: 'a@b.com',
        hasPasscode: true,
        hasTransactionPin: true,
        kyc: KycLoginGate.none,
      );
      expect(r.name, AppRoutes.dashboard);
    });
  });

  group('resolvePostLoginRoute — the step label never outranks the fact', () {
    test(
        'step=passcode_setup but the account HAS a passcode → not passcode setup',
        () {
      // The reported bug: "Set Up Passcode" on every login for someone who
      // types their passcode daily.
      final r = resolvePostLoginRoute(
        step: 'passcode_setup',
        status: 'identity_verified', // regressed by the old tracker
        email: 'a@b.com',
        phone: '+2348012345678',
        hasPasscode: true,
        hasTransactionPin: true,
        kyc: KycLoginGate.none,
      );
      expect(r.name, AppRoutes.dashboard);
    });

    test('step=account_created but the account HAS a passcode → dashboard', () {
      final r = resolvePostLoginRoute(
        step: 'account_created',
        status: 'created',
        email: 'a@b.com',
        phone: '+2348012345678',
        hasPasscode: true,
        hasTransactionPin: true,
        kyc: KycLoginGate.none,
      );
      expect(r.name, AppRoutes.dashboard);
    });

    test('step=identity_verify but the holder IS verified → dashboard', () {
      // The other reported bug: routed into verification, greeted with
      // "You're Verified".
      final r = resolvePostLoginRoute(
        step: 'identity_verify',
        status: 'phone_verified',
        email: 'a@b.com',
        phone: '+2348012345678',
        hasPasscode: true,
        hasTransactionPin: true,
        kyc: _verifiedRequired,
      );
      expect(r.name, AppRoutes.dashboard);
    });

    test('step=identity_verify, unverified, admin requires → verification', () {
      final r = resolvePostLoginRoute(
        step: 'identity_verify',
        status: 'phone_verified',
        email: 'a@b.com',
        phone: '+2348012345678',
        hasPasscode: true,
        hasTransactionPin: true,
        kyc: _required,
      );
      expect(r.name, AppRoutes.kycBVNVerification);
    });

    test(
        'step=identity_verify, unverified, admin does NOT require → dashboard '
        '(the dismissible prompt asks)', () {
      final r = resolvePostLoginRoute(
        step: 'identity_verify',
        status: 'phone_verified',
        email: 'a@b.com',
        phone: '+2348012345678',
        hasPasscode: true,
        hasTransactionPin: true,
        kyc: _notRequired,
      );
      expect(r.name, AppRoutes.dashboard);
    });

    test('step=phone_verify but the phone IS verified → not the phone screen',
        () {
      final r = resolvePostLoginRoute(
        step: 'phone_verify',
        status: 'email_verified',
        email: 'a@b.com',
        phone: '+2348012345678',
        hasPasscode: true,
        hasTransactionPin: true,
        phoneVerified: true,
        kyc: KycLoginGate.none,
      );
      expect(r.name, AppRoutes.dashboard);
    });

    test('step=email_verify but the email IS verified → not the email screen',
        () {
      final r = resolvePostLoginRoute(
        step: 'email_verify',
        status: 'created',
        email: 'a@b.com',
        phone: '+2348012345678',
        hasPasscode: true,
        hasTransactionPin: true,
        isEmailVerified: true,
        kyc: KycLoginGate.none,
      );
      expect(r.name, AppRoutes.dashboard);
    });

    test('status=complete with a stale step → gates, not resume', () {
      final r = resolvePostLoginRoute(
        step: 'email_verify', // stale
        status: 'complete',
        email: 'a@b.com',
        hasPasscode: true,
        hasTransactionPin: true,
        kyc: KycLoginGate.none,
      );
      expect(r.name, AppRoutes.dashboard);
    });
  });

  group('resolvePostLoginRoute — genuinely unfinished signup', () {
    test('no passcode yet → passcode setup first, whatever the step says', () {
      for (final step in [
        'passcode_setup',
        'account_created',
        'phone_verify'
      ]) {
        final r = resolvePostLoginRoute(
          step: step,
          status: 'created',
          email: 'a@b.com',
          phone: step == 'phone_verify' ? null : '+2348012345678',
          hasPasscode: false,
          hasTransactionPin: false,
          kyc: KycLoginGate.none,
        );
        expect(r.name, AppRoutes.passcodeSetup, reason: step);
        expect(r.args?['fromLoginFlow'], true, reason: step);
      }
    });

    test(
        'parked at email_verify with an unverified email → email verification, '
        'even when the admin does not require it, chained onward', () {
      final r = resolvePostLoginRoute(
        step: 'email_verify',
        status: 'created',
        email: 'a@b.com',
        phone: '+2348012345678',
        hasPasscode: true,
        hasTransactionPin: true,
        isEmailVerified: false,
        emailVerificationRequired: false,
        kyc: KycLoginGate.none,
      );
      expect(r.name, AppRoutes.emailVerification);
      expect(r.args?['email'], 'a@b.com');
      expect(r.args?['isRequired'], false);
      expect(r.args?['nextRoute'], AppRoutes.dashboard);
    });

    test(
        'CRITICAL: an unverified email beats the passcode/PIN gates when '
        'required (2FA success must NOT skip it even for a full account)', () {
      final r = resolvePostLoginRoute(
        step: null,
        status: 'complete',
        email: 'a@b.com',
        phone: '+2348012345678',
        hasPasscode: true,
        hasTransactionPin: true,
        isEmailVerified: false,
        emailVerificationRequired: true,
        kyc: KycLoginGate.none,
      );
      expect(r.name, AppRoutes.emailVerification);
      expect(r.args?['isRequired'], true);
    });

    test(
        'an unverified email on an account NOT parked there, not required → '
        'no email screen', () {
      final r = resolvePostLoginRoute(
        step: null,
        status: 'complete',
        email: 'a@b.com',
        hasPasscode: true,
        hasTransactionPin: true,
        isEmailVerified: false,
        emailVerificationRequired: false,
        kyc: KycLoginGate.none,
      );
      expect(r.name, AppRoutes.dashboard);
    });

    test('a phone-only account (no email) is never asked to verify an email',
        () {
      final r = resolvePostLoginRoute(
        step: 'email_verify',
        status: 'created',
        email: '',
        phone: '+2348012345678',
        hasPasscode: true,
        hasTransactionPin: true,
        isEmailVerified: false,
        emailVerificationRequired: true,
        kyc: KycLoginGate.none,
      );
      expect(r.name, AppRoutes.dashboard);
    });
  });

  group('resolvePostLoginRoute — forgot-passcode reset', () {
    test('fromForgotPasscode → passcode setup with the reset flag', () {
      final r = resolvePostLoginRoute(
        step: null,
        status: 'complete',
        email: 'a@b.com',
        hasPasscode: true,
        hasTransactionPin: true,
        fromForgotPasscode: true,
        kyc: KycLoginGate.none,
      );
      expect(r.name, AppRoutes.passcodeSetup);
      expect(r.args?['fromForgotPasscode'], true);
      expect(r.args?['fromLoginFlow'], true);
    });
  });

  group('resolvePostLoginRoute — identity verification gate', () {
    ({String name, Map<String, dynamic>? args}) run(KycLoginGate kyc,
            {bool hasTransactionPin = true}) =>
        resolvePostLoginRoute(
          step: null,
          status: 'complete',
          email: 'a@b.com',
          hasPasscode: true,
          hasTransactionPin: hasTransactionPin,
          kyc: kyc,
        );

    test('required + unverified → verification', () {
      final r = run(_required);
      expect(r.name, AppRoutes.kycBVNVerification);
      expect(r.args, isNull);
    });

    test('required + REJECTED → verification (they must redo it)', () {
      expect(
          run(const KycLoginGate(state: KycState.rejected, isRequired: true))
              .name,
          AppRoutes.kycBVNVerification);
    });

    test('required + IN REVIEW → dashboard, never back into the form', () {
      expect(
          run(const KycLoginGate(state: KycState.inReview, isRequired: true))
              .name,
          AppRoutes.dashboard);
    });

    test('required + verified → dashboard', () {
      expect(run(_verifiedRequired).name, AppRoutes.dashboard);
    });

    test('NOT required + unverified → dashboard (the prompt handles it)', () {
      expect(run(_notRequired).name, AppRoutes.dashboard);
    });

    test('a MIRRORED reading may prompt but never block', () {
      const mirrored = KycLoginGate(
          state: KycState.unverified, isRequired: true, fromMirror: true);
      expect(run(mirrored).name, AppRoutes.dashboard);
      expect(mirrored.shouldPromptOnDashboard, isTrue);
    });

    test('the hard gate and the prompt are never both on', () {
      for (final g in [_required, _notRequired, _verifiedRequired]) {
        expect(g.blocksDashboard && g.shouldPromptOnDashboard, isFalse);
      }
    });

    test('verification comes AFTER the transaction PIN', () {
      final r = run(_required, hasTransactionPin: false);
      expect(r.name, AppRoutes.transactionPinSetup);
    });

    test('a missing passcode still outranks verification', () {
      final r = resolvePostLoginRoute(
        step: null,
        status: 'complete',
        email: 'a@b.com',
        hasPasscode: false,
        hasTransactionPin: true,
        kyc: _required,
      );
      expect(r.name, AppRoutes.passcodeSetup);
    });
  });

  group('resolvePostLoginRoute — phone verification gate', () {
    ({String name, Map<String, dynamic>? args}) run({
      required bool required,
      String? phone = '+2348012345678',
      bool hasTransactionPin = true,
      KycLoginGate kyc = KycLoginGate.none,
    }) =>
        resolvePostLoginRoute(
          step: null,
          status: 'complete',
          email: 'a@b.com',
          phone: phone,
          hasPasscode: true,
          hasTransactionPin: hasTransactionPin,
          phoneVerificationRequired: required,
          phoneVerified: false,
          kyc: kyc,
        );

    test('fires for an unverified number when the admin requires it, no skip',
        () {
      final r = run(required: true);
      expect(r.name, AppRoutes.phoneVerification);
      expect(r.args?['phoneNumber'], '+2348012345678');
      expect(r.args?['isRequired'], true);
      expect(r.args?['codeSent'], false);
    });

    test(
        'STILL fires when the admin does not require it — shown, but skippable',
        () {
      final r = run(required: false);
      expect(r.name, AppRoutes.phoneVerification);
      expect(r.args?['isRequired'], false);
    });

    test('does NOT strand an account that has no phone to verify', () {
      expect(run(required: true, phone: null).name, AppRoutes.dashboard);
      expect(run(required: true, phone: '').name, AppRoutes.dashboard);
    });

    test('a verified phone is never asked again', () {
      final r = resolvePostLoginRoute(
        step: null,
        status: 'complete',
        email: 'a@b.com',
        phone: '+2348012345678',
        hasPasscode: true,
        hasTransactionPin: true,
        phoneVerificationRequired: true,
        phoneVerified: true,
        kyc: KycLoginGate.none,
      );
      expect(r.name, AppRoutes.dashboard);
    });

    test('hands over to the PIN gate, with its args, once the phone is done',
        () {
      final r = run(required: false, hasTransactionPin: false);
      expect(r.name, AppRoutes.phoneVerification);
      expect(r.args?['nextRoute'], AppRoutes.transactionPinSetup);
      expect((r.args?['nextRouteArgs'] as Map?)?['fromLoginFlow'], true);
    });

    test('hands over to verification when that is what remains', () {
      final r = run(required: false, kyc: _required);
      expect(r.args?['nextRoute'], AppRoutes.kycBVNVerification);
    });

    test('hands over to the dashboard when nothing remains', () {
      final r = run(required: false);
      expect(r.args?['nextRoute'], AppRoutes.dashboard);
      expect(r.args?['nextRouteArgs'], isNull);
    });

    test('the passcode comes before the phone', () {
      final r = resolvePostLoginRoute(
        step: null,
        status: 'complete',
        email: 'a@b.com',
        phone: '+2348012345678',
        hasPasscode: false,
        hasTransactionPin: true,
        phoneVerified: false,
        kyc: KycLoginGate.none,
      );
      expect(r.name, AppRoutes.passcodeSetup);
    });
  });

  // A GOOGLE/APPLE ACCOUNT HAS NO CREDENTIAL OF ITS OWN.
  // EVERY RESUMPTION STEP IS COMPULSORY EXCEPT THE PHONE OTP.
  //
  // The passcode is what the app lock, the biometric unlock and every quick
  // login use, so a login that reaches this gate must set one — including a
  // social (Google/Apple) sign-in, whose provider link gets them in but
  // leaves the app with no local credential. Setting it needs nothing
  // external: six digits, twice. Only the phone OTP stays skippable, because
  // it needs an SMS we cannot guarantee arrives.
  group('resolvePostLoginRoute — the passcode is compulsory for every account',
      () {
    ({String name, Map<String, dynamic>? args}) run({
      required bool hasPasscode,
      bool hasTransactionPin = true,
    }) =>
        resolvePostLoginRoute(
          step: null,
          status: 'complete',
          email: 'a@b.com',
          hasPasscode: hasPasscode,
          hasTransactionPin: hasTransactionPin,
          kyc: KycLoginGate.none,
        );

    test('no passcode → passcode setup, and never a skip flag', () {
      final r = run(hasPasscode: false);
      expect(r.name, AppRoutes.passcodeSetup);
      expect(r.args?['fromLoginFlow'], true);
      expect(r.args!.containsKey('allowSkip'), isFalse,
          reason: 'the screen hides its skip on fromLoginFlow; nothing may '
              'hand it a way back');
    });

    test('a passcode already set is never asked for again', () {
      expect(run(hasPasscode: true).name, AppRoutes.dashboard);
      expect(run(hasPasscode: true, hasTransactionPin: false).name,
          AppRoutes.transactionPinSetup);
    });

    test('the phone OTP is the only skippable step in the chain', () {
      // Phone: skippable when the admin has not made it mandatory.
      final phone = resolvePostLoginRoute(
        step: null,
        status: 'complete',
        email: 'a@b.com',
        phone: '+2348012345678',
        hasPasscode: true,
        hasTransactionPin: true,
        phoneVerified: false,
        phoneVerificationRequired: false,
        kyc: KycLoginGate.none,
      );
      expect(phone.name, AppRoutes.phoneVerification);
      expect(phone.args?['isRequired'], false,
          reason: 'the screen shows its skip when the admin does not require '
              'verification');

      // Email, PIN and identity: no skip affordance is ever passed.
      final email = resolvePostLoginRoute(
        step: null,
        status: 'complete',
        email: 'a@b.com',
        hasPasscode: true,
        hasTransactionPin: true,
        isEmailVerified: false,
        emailVerificationRequired: true,
        kyc: KycLoginGate.none,
      );
      expect(email.name, AppRoutes.emailVerification);
      expect(email.args?['isRequired'], true);

      final pin = run(hasPasscode: true, hasTransactionPin: false);
      expect(pin.args!.containsKey('allowSkip'), isFalse);

      final kyc = resolvePostLoginRoute(
        step: null,
        status: 'complete',
        email: 'a@b.com',
        hasPasscode: true,
        hasTransactionPin: true,
        kyc: const KycLoginGate(state: KycState.unverified, isRequired: true),
      );
      expect(kyc.name, AppRoutes.kycBVNVerification);
      expect(kyc.args, isNull,
          reason: 'the verification screen enforces its own stricter rule and '
              'reads no argument from here');
    });
  });

  group('User.isSocialAccount', () {
    User user({String? authType, String? preferred}) => User(
          id: 'u1',
          firstName: 'Ada',
          lastName: 'Obi',
          email: 'a@b.com',
          verified: true,
          isEmailVerified: true,
          createdAt: DateTime(2026),
          updatedAt: DateTime(2026),
          authType: authType,
          preferredLoginMethod: preferred,
        );

    test('the backend auth_type stamp decides', () {
      expect(user(authType: 'SOCIAL').isSocialAccount, isTrue);
      expect(user(authType: 'social').isSocialAccount, isTrue);
      expect(user(authType: 'EMAIL_PASSWORD').isSocialAccount, isFalse);
      expect(user(authType: 'PHONE_PASSCODE').isSocialAccount, isFalse);
    });

    test('the older preferredLoginMethod mirror also answers', () {
      expect(user(preferred: 'social').isSocialAccount, isTrue);
      expect(user(preferred: 'email_password').isSocialAccount, isFalse);
    });

    test('a response that carries neither answers false', () {
      // Which is why goAfterLogin accepts an override from a caller that read
      // `login_method` out of storage.
      expect(user().isSocialAccount, isFalse);
    });
  });
}
