// SOCIAL AND BIOMETRIC LOGINS MUST OBEY THE SAME RESUMPTION STATES.
//
// Every credential ends at `resolvePostLoginRoute`, but they do NOT all arrive
// carrying the same facts, and that difference is where a gate goes quiet:
//
//   * A password / passcode / SOCIAL login answers an RPC whose `User` carries
//     kyc_tier, kyc_status, signup_status, current_signup_step, email_verified
//     and phone_verified — so every gate can decide on live values.
//   * A BIOMETRIC or voice unlock proves a local gate and rebuilds the user
//     from the `common` profile proto, which carries none of them
//     (see session_user_facts.dart). Those facts are restored from
//     LoginFactsStore / KycSnapshot — a MIRROR of what the last credential
//     login saw.
//
// The rule these tests pin down: a mirrored reading is good enough to ASK with
// and NOT good enough to BLOCK on. Blocking on a mirror would let a stale local
// value lock someone out of their dashboard after a fingerprint; refusing to
// prompt on one would make verification silent for a daily Face ID user who
// never does a credential login again.
//
// Both halves have to hold for BOTH auth flows — email/password and
// phone/passcode — because the passcode lock screen is shared by both account
// kinds and hosts social and biometric for both.
import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/core/utils/kyc_completion.dart';
import 'package:lazervault/src/features/authentication/presentation/utils/signup_resume.dart';

/// A login that talked to the server and got live KYC fields back. This is the
/// shape of a password, passcode AND social sign-in: auth-service's
/// `userToProto` populates kyc_tier/kyc_status on all of them, and
/// SocialLoginResponse carries that same `User`.
const _liveUnverified =
    KycLoginGate(state: KycState.unverified, isRequired: true);

/// A session unlock: the live fields were absent, so the state came from the
/// mirror of the last credential login.
const _mirroredUnverified = KycLoginGate(
  state: KycState.unverified,
  isRequired: true,
  fromMirror: true,
);

({String name, Map<String, dynamic>? args}) _route({
  required KycLoginGate kyc,
  String? phone,
  bool hasPasscode = true,
  bool hasTransactionPin = true,
}) =>
    resolvePostLoginRoute(
      step: null,
      status: 'complete',
      email: 'holder@example.com',
      phone: phone,
      hasPasscode: hasPasscode,
      hasTransactionPin: hasTransactionPin,
      kyc: kyc,
      phoneVerified: true,
      isEmailVerified: true,
    );

void main() {
  group('a credential login with LIVE facts can be blocked by the KYC gate',
      () {
    test('email/password-shaped account → verification, not dashboard', () {
      // No phone on the account: the email/password flow's shape.
      final r = _route(kyc: _liveUnverified, phone: null);
      expect(r.name, AppRoutes.kycBVNVerification,
          reason: 'a live unverified reading with KYC required must divert');
    });

    test('phone/passcode-shaped account → verification, not dashboard', () {
      final r = _route(kyc: _liveUnverified, phone: '+2348012345678');
      expect(r.name, AppRoutes.kycBVNVerification);
    });

    test('this is the SOCIAL case too', () {
      // SocialLoginResponse.user is built by the same `userToProto` as a
      // password login, so a social sign-in reaches the resolver with live
      // fields and must be gated identically. If social ever stopped carrying
      // them, this would still pass while production silently stopped
      // gating — which is why the mirror tests below exist alongside it.
      expect(_liveUnverified.fromMirror, isFalse);
      expect(_liveUnverified.blocksDashboard, isTrue);
    });
  });

  group('a session unlock with MIRRORED facts is never blocked', () {
    test('biometric on an email/password account reaches the dashboard', () {
      final r = _route(kyc: _mirroredUnverified, phone: null);
      expect(r.name, AppRoutes.dashboard,
          reason: 'a mirrored reading must not be able to refuse the '
              'dashboard after a proven fingerprint');
    });

    test('biometric on a phone/passcode account reaches the dashboard', () {
      final r = _route(kyc: _mirroredUnverified, phone: '+2348012345678');
      expect(r.name, AppRoutes.dashboard);
    });

    test('…but it still ASKS, once on the dashboard', () {
      // The complement. Not prompting would make verification invisible to
      // someone who only ever unlocks with Face ID.
      expect(_mirroredUnverified.blocksDashboard, isFalse);
      expect(_mirroredUnverified.shouldPromptOnDashboard, isTrue);
    });
  });

  group('the mirror never overrides a live answer', () {
    test('a live VERIFIED reading is not re-gated', () {
      final r = _route(
        kyc: const KycLoginGate(state: KycState.verified, isRequired: true),
      );
      expect(r.name, AppRoutes.dashboard);
    });

    test('fromMirror is what distinguishes the two, not the state', () {
      // Same state, same requirement — only the provenance differs, and only
      // the provenance may change whether it blocks.
      expect(_liveUnverified.state, _mirroredUnverified.state);
      expect(_liveUnverified.isRequired, _mirroredUnverified.isRequired);
      expect(_liveUnverified.blocksDashboard,
          isNot(_mirroredUnverified.blocksDashboard));
    });
  });

  group('earlier gates apply to every credential equally', () {
    test('a social account with no passcode resumes INTO passcode setup', () {
      // Documented in resolvePostLoginRoute: "a social (Google/Apple) sign-in
      // with no passcode resumes INTO this step like any other unfinished
      // onboarding step". No skip, for any account — the passcode is what the
      // app lock and every quick action assume exists.
      final r = _route(kyc: KycLoginGate.none, hasPasscode: false);
      expect(r.name, AppRoutes.passcodeSetup);
    });

    test('a biometric unlock missing hasPasscode would hit the same gate', () {
      // Which is exactly why enrichSessionUser restores it from
      // LoginFactsStore before the router runs, and why it fails toward
      // "passcode present" when the backend cannot be reached: the alternative
      // is sending the app's daily Face ID users to set a passcode they
      // already have.
      final r = _route(kyc: KycLoginGate.none, hasPasscode: false);
      expect(r.name, AppRoutes.passcodeSetup,
          reason: 'the gate is credential-blind — the FIX is supplying the '
              'fact, never special-casing the router');
    });

    test('the transaction-PIN gate is credential-blind too', () {
      final r = _route(kyc: KycLoginGate.none, hasTransactionPin: false);
      expect(r.name, AppRoutes.transactionPinSetup);
    });
  });
}
