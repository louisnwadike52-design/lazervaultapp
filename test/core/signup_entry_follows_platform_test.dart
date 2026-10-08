import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/core/config/feature_flags.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Signing UP and signing BACK IN ask different questions, and conflating them
/// sent brand-new users down the wrong flow.
///
/// `effective_login_method` is resolved from the signed-in ACCOUNT's own shape
/// (does it have a passcode? a password?) and cached per device. For a login
/// that is correct — an email account must come back to its email screen. For
/// a SIGNUP it is meaningless and actively wrong: the person signing up does
/// not own that account, and frequently is not the same person. A device that
/// had once held an email account sent every new signup to the email flow no
/// matter what the platform default said.
///
/// So signupEntry must follow the PLATFORM mode (`auth_mode`, default
/// phone_passcode) while loginEntry keeps following the cached per-user flow.
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  // FeatureFlags.init() binds its prefs with `??=`, so it never rebinds once
  // set and setMockInitialValues alone cannot reach it between tests.
  // debugResetForTest() exists for exactly this: it rebinds AND clears, so the
  // values are written afterwards.
  Future<void> prime({String? platformMode, String? cachedUserFlow}) async {
    SharedPreferences.setMockInitialValues({});
    await FeatureFlags.debugResetForTest();
    final prefs = await SharedPreferences.getInstance();
    if (platformMode != null) {
      await prefs.setString(FeatureFlags.authMode, platformMode);
    }
    if (cachedUserFlow != null) {
      await prefs.setString(FeatureFlags.effectiveLoginMethod, cachedUserFlow);
    }
  }

  group('signup follows the platform, not the last user', () {
    test('a stale email_password cache does NOT divert a new signup', () async {
      // The reported bug, in one case: the platform says phone_passcode, but
      // this device remembers an email account from a previous user.
      await prime(
        platformMode: FeatureFlags.authModePhonePasscode,
        cachedUserFlow: FeatureFlags.authModeEmailPassword,
      );

      expect(FeatureFlags.isEmailPasswordLogin, isTrue,
          reason: 'the per-user cache is still email — that is what LOGIN uses');
      expect(AppRoutes.signupEntry, AppRoutes.phoneEntry,
          reason: 'but SIGNUP must follow the platform default');
    });

    test('a fresh device with no cache at all uses phone_passcode', () async {
      // The product default, and what a brand-new install must get even before
      // /auth/config has been read.
      await prime();
      expect(AppRoutes.signupEntry, AppRoutes.phoneEntry);
    });

    test('an admin flip to email_password moves signup too', () async {
      // The platform setting is the lever, so it has to work in both
      // directions — otherwise this is a hardcode wearing a getter.
      await prime(platformMode: FeatureFlags.authModeEmailPassword);
      expect(AppRoutes.signupEntry, AppRoutes.signUp);
    });

    test('an unknown platform value falls back to phone_passcode', () async {
      // Mirrors the server's normalizeAuthMode, which coerces anything
      // unrecognised to the product default rather than silently enabling
      // email mode.
      await prime(platformMode: 'something_else_entirely');
      expect(AppRoutes.signupEntry, AppRoutes.phoneEntry);
    });
  });

  group('login still honours the account it remembers', () {
    test('a cached email user comes back to the email screen', () async {
      // The other half of the contract: fixing signup must not drag existing
      // email accounts onto a passcode screen they have no passcode for.
      await prime(
        platformMode: FeatureFlags.authModePhonePasscode,
        cachedUserFlow: FeatureFlags.authModeEmailPassword,
      );
      expect(AppRoutes.loginEntry, AppRoutes.emailSignIn);
      expect(AppRoutes.freshLoginEntry, AppRoutes.emailSignIn);
    });

    test('a cached phone user keeps the passcode screens', () async {
      await prime(
        platformMode: FeatureFlags.authModePhonePasscode,
        cachedUserFlow: FeatureFlags.authModePhonePasscode,
      );
      expect(AppRoutes.loginEntry, AppRoutes.passcodeLogin);
      expect(AppRoutes.freshLoginEntry, AppRoutes.phonePasscodeLogin);
    });
  });
}
