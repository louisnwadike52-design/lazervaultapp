import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:lazervault/core/config/feature_flags.dart';
import 'package:lazervault/core/types/app_routes.dart';

/// Single source of truth for "which login flow does this device/user get".
///
/// The app previously derived this independently at ~8 sites from an overlapping,
/// racy mix of signals (`preferred_login_method`, `login_method`, `stored_phone`,
/// `has_password`, platform `auth_mode`) with different precedence and async
/// timing — so the login screen (and the sign-up button on it) flip-flopped
/// between the phone+passcode and email+password flows across launches and
/// navigations, especially under slow/again network.
///
/// This resolver fixes that with ONE deterministic precedence, defaulting to
/// phone+passcode, and caches the result in [FeatureFlags.loginFlow] (a sync,
/// offline-safe SharedPreferences read) that every site now consumes.
class LoginFlowResolver {
  LoginFlowResolver._();

  // Secure-storage keys already used across the app.
  static const _preferredKey = 'preferred_login_method'; // explicit Settings choice
  static const _legacyMethodKey = 'login_method'; // legacy 'passcode'|'phone_passcode'
  static const _hasPasscodeKey = 'has_passcode';
  static const _hasPasswordKey = 'has_password';

  // Returning-user signals — the same keys the boot router + passcode lock screen
  // key off. Any one present means a previously-logged-in user is cached on this
  // device (so the passcode lock / quick-login is appropriate).
  static const _storedPhoneKey = 'stored_phone';
  static const _storedEmailKey = 'stored_email';
  static const _userIdKey = 'user_id';

  static const _phone = FeatureFlags.authModePhonePasscode; // 'phone_passcode'
  static const _email = FeatureFlags.authModeEmailPassword; // 'email_password'

  /// The app's ACTUAL secure-storage backend. The previous bare
  /// `const FlutterSecureStorage()` default used Android's DEFAULT keystore
  /// backend — NOT EncryptedSharedPreferences — so on Android every read here
  /// hit an empty store and returning users were sent to the full login screen.
  /// Mirrors injection_container + main.dart so callers that don't inject a
  /// storage still read the same values the auth flow wrote.
  static const _defaultStorage = FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
      resetOnError: true,
    ),
  );

  /// Whether a previously-logged-in user with an ACTUAL passcode is cached on this
  /// device. The passcode LOCK screen renders a cached identity + takes only a
  /// passcode, so it is a dead-end for anyone who doesn't have a passcode: fresh
  /// installs, fully-wiped accounts, AND email/password-only accounts (has a
  /// password but no passcode). Those must fall through to the full login screen.
  /// Gated on the mirrored `has_passcode` flag (written from the backend profile
  /// on every login) so only a genuine phone+passcode returning user reaches the
  /// lock; everyone else gets the correct full-login screen for their account.
  static Future<bool> hasCachedReturningUser({FlutterSecureStorage? storage}) async {
    final s = storage ?? _defaultStorage;

    // 1. Must have a cached identity — the lock renders it and can't unlock
    //    without one.
    final phone = await s.read(key: _storedPhoneKey);
    final email = await s.read(key: _storedEmailKey);
    final userId = await s.read(key: _userIdKey);
    final hasIdentity = (phone != null && phone.isNotEmpty) ||
        (email != null && email.isNotEmpty) ||
        (userId != null && userId.isNotEmpty);
    if (!hasIdentity) return false;

    // 2. A genuine email+password-preference account (explicitly chose email AND
    //    has a password) belongs on the email screen, never the passcode lock.
    final preferred = (await s.read(key: _preferredKey))?.toLowerCase().trim();
    final hasPassword = (await s.read(key: _hasPasswordKey)) == 'true';
    if (preferred == _email && hasPassword) return false;

    // 3. Passcode-credential signal: the mirrored `has_passcode` flag OR a
    //    passcode-family `login_method`. `has_passcode` is derived from the
    //    backend profile and can legitimately be absent/'false' (older builds,
    //    an unpopulated field, or a login before the mirror existed), so it is
    //    NOT sufficient on its own. The boot router + LoginFlowResolver.compute
    //    already treat a passcode-family `login_method` as "has a passcode"; if
    //    we required ONLY `has_passcode` here, the router would send a returning
    //    phone+passcode user to this lock and we'd bounce them straight to the
    //    full login page — the "app lock always opens the login screen" bug.
    final hasPasscodeFlag = (await s.read(key: _hasPasscodeKey)) == 'true';
    final method = (await s.read(key: _legacyMethodKey))?.toLowerCase().trim();
    final passcodeMethod = method == 'passcode' || method == _phone;
    return hasPasscodeFlag || passcodeMethod;
  }

  /// The route the "Log in" affordance should open, intelligent about whether a
  /// returning user is cached:
  ///   * email_password → the email+password screen (it handles fresh AND
  ///     returning users, incl. "use passcode instead").
  ///   * phone_passcode → the passcode LOCK screen only when a returning user is
  ///     cached; otherwise the full phone+passcode LOGIN screen (enter phone +
  ///     passcode), so a fresh install can actually sign in.
  static Future<String> resolveLoginRoute({FlutterSecureStorage? storage}) async {
    if (FeatureFlags.isEmailPasswordLogin) return AppRoutes.emailSignIn;
    final returning = await hasCachedReturningUser(storage: storage);
    return returning ? AppRoutes.passcodeLogin : AppRoutes.phonePasscodeLogin;
  }

  /// Pure, deterministic resolution. Precedence:
  ///   1. Explicit user choice (`preferred`) when the matching credential exists
  ///      — a Settings switch to email needs a password; to passcode needs a
  ///      passcode (otherwise the choice can't actually be used, so fall through).
  ///   2. Account shape — a passcode always uses the passcode screen; otherwise a
  ///      password uses the email screen.
  ///   3. phone+passcode (the product default) for brand-new / unknown accounts.
  static String compute({
    String? preferred,
    bool hasPasscode = false,
    bool hasPassword = false,
  }) {
    final p = (preferred ?? '').toLowerCase().trim();
    if (p == _email && hasPassword) return _email;
    if (p == _phone && hasPasscode) return _phone;
    if (hasPasscode) return _phone;
    if (hasPassword) return _email;
    return _phone;
  }

  /// Recompute + cache the flow from a freshly-loaded profile. Called from the
  /// session-save funnel so EVERY login path (email, passcode, phone) keeps the
  /// canonical flow in sync with the account's real shape + explicit choice.
  static Future<void> record({
    String? preferred,
    required bool hasPasscode,
    required bool hasPassword,
  }) async {
    await FeatureFlags.setLoginFlow(
      compute(preferred: preferred, hasPasscode: hasPasscode, hasPassword: hasPassword),
    );
  }

  /// Force the flow to an explicit choice (Settings switch). Persists the
  /// canonical cache AND the `preferred_login_method` mirror.
  static Future<void> setExplicit(String flow, {FlutterSecureStorage? storage}) async {
    final normalized = flow.toLowerCase().trim() == _email ? _email : _phone;
    await FeatureFlags.setLoginFlow(normalized);
    await (storage ?? _defaultStorage)
        .write(key: _preferredKey, value: normalized);
  }

  /// One-time boot migration: when the canonical flow hasn't been resolved yet,
  /// derive it OFFLINE from the legacy secure-storage signals so an existing
  /// account lands on the correct screen without waiting for GetMe/`/auth/config`.
  /// Idempotent — a no-op once [FeatureFlags.hasLoginFlow] is true.
  static Future<String> seedFromLegacyIfUnset({FlutterSecureStorage? storage}) async {
    if (FeatureFlags.hasLoginFlow) return FeatureFlags.loginFlow;
    final s = storage ?? _defaultStorage;
    final preferred = await s.read(key: _preferredKey);
    final legacy = (await s.read(key: _legacyMethodKey) ?? '').toLowerCase().trim();
    final passcodeFromMethod = legacy == 'passcode' || legacy == _phone;
    final hasPasscode =
        (await s.read(key: _hasPasscodeKey)) == 'true' || passcodeFromMethod;
    final hasPassword = (await s.read(key: _hasPasswordKey)) == 'true';
    // Self-heal the mirror: a returning passcode user whose `login_method`
    // survived but whose `has_passcode` flag didn't (older build / never
    // written) gets the flag backfilled here, so every OTHER site that still
    // keys off `has_passcode` alone agrees with the resolver.
    if (passcodeFromMethod &&
        (await s.read(key: _hasPasscodeKey)) != 'true') {
      await s.write(key: _hasPasscodeKey, value: 'true');
    }
    final flow = compute(
      preferred: preferred,
      hasPasscode: hasPasscode,
      hasPassword: hasPassword,
    );
    await FeatureFlags.setLoginFlow(flow);
    return flow;
  }
}
