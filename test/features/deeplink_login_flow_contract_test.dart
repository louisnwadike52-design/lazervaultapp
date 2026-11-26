import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// A DEEPLINK NEVER CHOOSES A LOGIN SCREEN. IT WAITS, AND ONE RESOLVER CHOOSES.
///
/// The requirement, in the operator's order of precedence:
///
///   1. the user's own saved preference (`effective_login_method`)
///   2. otherwise the admin dashboard's `auth_mode`
///   3. otherwise phone_passcode
///
/// The failure this guards against is not a missing branch — it is a SECOND
/// branch. The moment any deeplink path decides for itself which screen to
/// open, that copy drifts from the dashboard, and a tapped link sends somebody
/// to a login their account cannot use. It happened: a device that had once
/// held an email account sent every new user to email/password regardless of
/// what the platform said.
///
/// So these assert the SHAPE of the code, not a rendered screen: that the
/// decision exists in exactly one place, that the deeplink layer defers to it,
/// and that the precedence is the stated one.
void main() {
  String read(String p) => File(p).readAsStringSync();

  /// Whitespace-free containment — `dart format` is free to rewrap anything,
  /// and a source-text test that breaks on reflow gets deleted.
  bool has(String haystack, String needle) {
    String flat(String s) =>
        s.replaceAll(RegExp(r'\s+'), '').replaceAll("''", '');
    return flat(haystack).contains(flat(needle));
  }

  group('the precedence is user → dashboard → phone_passcode', () {
    final flags = read('lib/core/config/feature_flags.dart');

    test('loginFlow prefers the saved choice, then the platform mode', () {
      expect(
        has(flags,
            'return _prefs?.getString(effectiveLoginMethod) ?? authenticationMode;'),
        isTrue,
        reason: 'the user choice must win, and the platform mode must be the '
            'only fallback — a literal here would ignore the dashboard',
      );
    });

    test('anything that is not email_password normalises to phone_passcode',
        () {
      // A bare `?? phone_passcode` covers only NULL, so an empty string or a
      // typo in the settings row used to fall through to the email branch.
      expect(has(flags, 'raw == authModeEmailPassword'), isTrue,
          reason: 'the test must be FOR email_password, so every other value '
              'lands on the phone_passcode default');
    });
  });

  group('routing reads the resolver, never a hardcoded screen', () {
    final routes = read('lib/core/types/app_routes.dart');

    test('both login entries branch on the resolved flow', () {
      expect(
          has(routes,
              'FeatureFlags.isEmailPasswordLogin ? emailSignIn : passcodeLogin'),
          isTrue);
      expect(
          has(routes,
              'FeatureFlags.isEmailPasswordLogin ? emailSignIn : phonePasscodeLogin'),
          isTrue);
    });

    test('signup for a user with no account reads the PLATFORM mode', () {
      // Deliberately the platform setting and not the per-account flow:
      // `effective_login_method` survives logout, so on a shared device the
      // last person's choice was deciding a brand-new user's screen.
      expect(
          has(routes, 'FeatureFlags.isPhonePasscodeMode ? phoneEntry : signUp'),
          isTrue);
    });
  });

  group('the deeplink layer defers rather than deciding', () {
    final nav = read('lib/core/notifications/notification_navigator.dart');
    final svc = read('lib/src/core/services/deep_link_service.dart');

    test('an unauthenticated target is held, not routed to a login screen', () {
      // MATCHED ON THE GUARD, NOT ON THE WHOLE LINE. The statement gained a
      // bounded retry (`return _retryShortly();`) because the last route
      // change of a login is offAllNamed(dashboard) and the access token is
      // written after it — a target held back at that instant had no further
      // event to wake it. What this test is about is that the branch HOLDS
      // rather than deciding where to send an unauthenticated user, and that
      // is unchanged.
      final at = nav.indexOf('if (target.requiresAuth && !_isAuthenticated())');
      expect(at, greaterThan(-1),
          reason: 'the hold is what hands the choice back to the one resolver');
      final stmt = nav.substring(at, nav.indexOf(';', at));
      expect(stmt.contains('return'), isTrue,
          reason: 'it must return without routing anywhere');
      for (final login in const ['loginEntry', 'passcodeLogin', 'signIn']) {
        expect(stmt.contains(login), isFalse,
            reason: 'two deciders disagree — the resolver owns this');
      }
    });

    test('no deeplink file names a login screen itself', () {
      // The whole contract in one assertion: if either of these ever pushes a
      // login route, there are two deciders and they will disagree.
      for (final entry in {
        'notification_navigator.dart': nav,
        'deep_link_service.dart': svc,
      }.entries) {
        for (final screen in [
          'AppRoutes.emailSignIn',
          'AppRoutes.passcodeLogin',
          'AppRoutes.phonePasscodeLogin',
          'AppRoutes.phoneEntry',
        ]) {
          expect(entry.value.contains(screen), isFalse,
              reason: '${entry.key} names $screen — the login screen is '
                  "AppRoutes.loginEntry's decision, and a second one drifts");
        }
      }
    });

    test('every pre-auth gate makes the replay wait', () {
      // Breadth is deliberate: a false positive costs a short wait, a false
      // negative pushes a destination over a gate the user has not passed.
      for (final clause in [
        "r.startsWith('/auth/')",
        "r.startsWith('/kyc/')",
        'r.startsWith(AppRoutes.onboarding)',
        "r.contains('login')",
        "r.contains('passcode')",
      ]) {
        expect(has(nav, clause), isTrue,
            reason: 'missing gate clause: $clause');
      }
    });

    test('a blocking overlay that is not a route also makes it wait', () {
      // The forced-update screen replaces the app (no Navigator in the tree)
      // and the maintenance overlay is a Positioned.fill. Neither moves
      // Get.currentRoute and neither registers as a dialog, so a replay once
      // navigated into a Navigator nobody could see and CONSUMED the stash.
      expect(has(nav, 'AppStartupGate.blockingTheScreen'), isTrue);
      expect(has(nav, 'Get.isDialogOpen == true'), isTrue);
    });

    test('a stashed target cannot replay for a different user', () {
      // A shared device: one person's transfer notification must not open for
      // whoever signs in next.
      expect(has(nav, 'if (now != null && now != owner)'), isTrue);
    });
  });
}
