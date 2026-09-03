// Validates the shared post-login routing that the email/password sign-in, the
// passcode lock screen, AND the 2FA verification screen all use — so a login
// (with or without 2FA, in either auth mode) always converges on the SAME
// correct destination: resume onboarding when incomplete, else the passcode /
// transaction-PIN setup gates, else the dashboard.
import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/core/types/app_routes.dart';
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
      );
      expect(r.name, AppRoutes.passcodeSetup);
      expect(r.args?['fromForgotPasscode'], true);
      expect(r.args?['fromLoginFlow'], true);
    });
  });
}
