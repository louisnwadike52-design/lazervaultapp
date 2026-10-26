// Validates the shared post-login routing that ALL SIX successful-auth surfaces
// use — email/password sign-in, the passcode lock screen, email+passcode,
// phone+passcode, 2FA verification and the step-up OTP screen — so a login
// converges on the SAME destination however it was performed: resume onboarding
// when incomplete, else the passcode / phone / transaction-PIN / identity gates,
// else the dashboard.
//
// Three of those surfaces used to call `Get.offAllNamed(dashboard)` directly
// and skip every gate; two more carried their own drifted copies of the tail.
// These tests are what stops that happening again.
import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/core/utils/kyc_completion.dart';
import 'package:lazervault/src/features/authentication/presentation/utils/signup_resume.dart';

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

    test('NO passcode → passcode setup', () {
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

  group('resolvePostLoginRoute — onboarding resume takes precedence', () {
    test('incomplete: email_verify → email verification (with args)', () {
      final r = resolvePostLoginRoute(
        step: 'email_verify',
        status: 'incomplete',
        email: 'a@b.com',
        phone: '+2348012345678',
        hasPasscode: false,
        hasTransactionPin: false,
        kyc: KycLoginGate.none,
      );
      expect(r.name, AppRoutes.emailVerification);
      expect(r.args?['email'], 'a@b.com');
      expect(r.args?['isRequired'], true);
    });

    test('incomplete: phone_verify WITH phone → phone verification', () {
      final r = resolvePostLoginRoute(
        step: 'phone_verify',
        status: 'incomplete',
        email: 'a@b.com',
        phone: '+2348012345678',
        hasPasscode: false,
        hasTransactionPin: false,
        kyc: KycLoginGate.none,
      );
      expect(r.name, AppRoutes.phoneVerification);
      expect(r.args?['phoneNumber'], '+2348012345678');
    });

    test('incomplete: phone_verify WITHOUT phone → defensive passcode setup',
        () {
      final r = resolvePostLoginRoute(
        step: 'phone_verify',
        status: 'incomplete',
        email: 'a@b.com',
        phone: null,
        hasPasscode: false,
        hasTransactionPin: false,
        kyc: KycLoginGate.none,
      );
      expect(r.name, AppRoutes.passcodeSetup);
    });

    test('incomplete: identity_verify → KYC BVN verification', () {
      final r = resolvePostLoginRoute(
        step: 'identity_verify',
        status: 'incomplete',
        email: 'a@b.com',
        hasPasscode: true,
        hasTransactionPin: true,
        kyc: KycLoginGate.none,
      );
      expect(r.name, AppRoutes.kycBVNVerification);
    });

    test('incomplete: passcode_setup → passcode setup', () {
      final r = resolvePostLoginRoute(
        step: 'passcode_setup',
        status: 'incomplete',
        email: 'a@b.com',
        hasPasscode: false,
        hasTransactionPin: false,
        kyc: KycLoginGate.none,
      );
      expect(r.name, AppRoutes.passcodeSetup);
    });

    test('incomplete: account_created → passcode setup', () {
      final r = resolvePostLoginRoute(
        step: 'account_created',
        status: 'incomplete',
        email: 'a@b.com',
        hasPasscode: false,
        hasTransactionPin: false,
        kyc: KycLoginGate.none,
      );
      expect(r.name, AppRoutes.passcodeSetup);
    });

    test(
        'CRITICAL: incomplete onboarding beats the passcode/PIN gates '
        '(2FA success must NOT skip resume even for a full account)', () {
      // A user with a passcode+PIN but an incomplete signup step must still
      // resume onboarding — this is exactly what the 2FA screen was skipping.
      final r = resolvePostLoginRoute(
        step: 'email_verify',
        status: 'incomplete',
        email: 'a@b.com',
        phone: '+2348012345678',
        hasPasscode: true,
        hasTransactionPin: true,
        kyc: KycLoginGate.none,
      );
      expect(r.name, AppRoutes.emailVerification);
      expect(r.name, isNot(AppRoutes.dashboard));
    });

    test('status=complete overrides a stale step → gates, not resume', () {
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
    ({String name, Map<String, dynamic>? args}) routeFor(KycLoginGate kyc) =>
        resolvePostLoginRoute(
          step: null,
          status: 'complete',
          email: 'a@b.com',
          hasPasscode: true,
          hasTransactionPin: true,
          kyc: kyc,
        );

    test('required + unverified → verification, with no way to skip', () {
      final r = routeFor(const KycLoginGate(
          state: KycState.unverified, isRequired: true));
      expect(r.name, AppRoutes.kycBVNVerification);
      // The screen must not offer a skip when the platform requires this —
      // offering a way past a gate that will stop you is a lie.
      expect(r.args?['isRequired'], true);
    });

    test('required + REJECTED → verification (they must redo it)', () {
      final r = routeFor(
          const KycLoginGate(state: KycState.rejected, isRequired: true));
      expect(r.name, AppRoutes.kycBVNVerification);
    });

    test('required + IN REVIEW → dashboard, never back into the form', () {
      // The holder has submitted and is waiting on us. Routing them into
      // verification again invites a second submission of the same documents.
      final r = routeFor(
          const KycLoginGate(state: KycState.inReview, isRequired: true));
      expect(r.name, AppRoutes.dashboard);
    });

    test('required + verified → dashboard', () {
      final r = routeFor(
          const KycLoginGate(state: KycState.verified, isRequired: true));
      expect(r.name, AppRoutes.dashboard);
    });

    test('NOT required + unverified → dashboard (the prompt handles it)', () {
      // With the admin setting off, verification is asked for by the
      // dismissible once-per-login prompt, not by blocking the dashboard.
      final gate = const KycLoginGate(
          state: KycState.unverified, isRequired: false);
      expect(routeFor(gate).name, AppRoutes.dashboard);
      expect(gate.shouldPromptOnDashboard, isTrue);
      expect(gate.blocksDashboard, isFalse);
    });

    test('the hard gate and the prompt are never both on', () {
      // Whatever the inputs, a user is either blocked or prompted — never
      // both, which would mean a dialog over a screen they cannot leave.
      for (final required in [true, false]) {
        for (final state in KycState.values) {
          final g = KycLoginGate(state: state, isRequired: required);
          expect(g.blocksDashboard && g.shouldPromptOnDashboard, isFalse,
              reason: 'state=$state required=$required');
        }
      }
    });

    test('verification comes AFTER the transaction PIN', () {
      // KYC is the heaviest step and the likeliest to be abandoned. Asking
      // first would leave someone who gives up with no PIN either.
      final r = resolvePostLoginRoute(
        step: null,
        status: 'complete',
        email: 'a@b.com',
        hasPasscode: true,
        hasTransactionPin: false,
        kyc: const KycLoginGate(
            state: KycState.unverified, isRequired: true),
      );
      expect(r.name, AppRoutes.transactionPinSetup);
    });

    test('an unfinished signup still outranks verification', () {
      final r = resolvePostLoginRoute(
        step: 'email_verify',
        status: 'incomplete',
        email: 'a@b.com',
        hasPasscode: true,
        hasTransactionPin: true,
        kyc: const KycLoginGate(
            state: KycState.unverified, isRequired: true),
      );
      expect(r.name, AppRoutes.emailVerification);
    });
  });

  group('resolvePostLoginRoute — phone re-verification gate', () {
    test('fires for an account with a number when an admin turned it on', () {
      // Previously lived only in the passcode lock screen, so the same user
      // logging in by email was never asked.
      final r = resolvePostLoginRoute(
        step: null,
        status: 'complete',
        email: 'a@b.com',
        phone: '+2348012345678',
        hasPasscode: true,
        hasTransactionPin: true,
        kyc: KycLoginGate.none,
        phoneVerificationRequired: true,
        phoneVerified: false,
      );
      expect(r.name, AppRoutes.phoneVerification);
      expect(r.args?['isRequired'], true);
    });

    test('does NOT strand an account that has no phone to verify', () {
      final r = resolvePostLoginRoute(
        step: null,
        status: 'complete',
        email: 'a@b.com',
        phone: null,
        hasPasscode: true,
        hasTransactionPin: true,
        kyc: KycLoginGate.none,
        phoneVerificationRequired: true,
        phoneVerified: false,
      );
      expect(r.name, AppRoutes.dashboard);
    });
  });
}
