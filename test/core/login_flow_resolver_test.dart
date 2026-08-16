// Edge-case coverage for the canonical login-flow resolution that fixed the
// login-screen flip-flop. The invariant under test everywhere: the DEFAULT is
// phone_passcode, and email_password only appears for an account that genuinely
// has a password or an explicit email choice.
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:lazervault/core/config/feature_flags.dart';
import 'package:lazervault/core/services/login_flow_resolver.dart';

const _phone = FeatureFlags.authModePhonePasscode; // 'phone_passcode'
const _email = FeatureFlags.authModeEmailPassword; // 'email_password'
const _ssChannel =
    MethodChannel('plugins.it_nomads.com/flutter_secure_storage');

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  // In-memory stand-in for the platform secure storage.
  final secure = <String, String>{};

  setUp(() async {
    SharedPreferences.setMockInitialValues(<String, Object>{});
    // Isolate each test: rebind + clear the prefs the resolver reads/writes so a
    // prior test's effective_login_method can't leak in.
    await FeatureFlags.debugResetForTest();
    secure.clear();
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(_ssChannel, (call) async {
      final args = call.arguments as Map?;
      switch (call.method) {
        case 'write':
          secure[args!['key'] as String] = args['value'] as String;
          return null;
        case 'read':
          return secure[args!['key'] as String];
        case 'delete':
          secure.remove(args!['key']);
          return null;
        case 'readAll':
          return Map<String, String>.from(secure);
        case 'deleteAll':
          secure.clear();
          return null;
        case 'containsKey':
          return secure.containsKey(args!['key']);
      }
      return null;
    });
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(_ssChannel, null);
  });

  // ── Pure precedence ────────────────────────────────────────────────────
  group('LoginFlowResolver.compute — precedence & default', () {
    test('brand-new account (no signals) → phone_passcode (DEFAULT)', () {
      expect(LoginFlowResolver.compute(), _phone);
    });

    test('passcode only → phone_passcode', () {
      expect(LoginFlowResolver.compute(hasPasscode: true), _phone);
    });

    test('password only → email_password', () {
      expect(LoginFlowResolver.compute(hasPassword: true), _email);
    });

    test('BOTH passcode + password, no explicit → phone_passcode (passcode wins)',
        () {
      expect(
        LoginFlowResolver.compute(hasPasscode: true, hasPassword: true),
        _phone,
      );
    });

    test('explicit email_password + has password → email_password', () {
      expect(
        LoginFlowResolver.compute(preferred: _email, hasPassword: true),
        _email,
      );
    });

    test('explicit email_password but NO password → falls to shape (default phone)',
        () {
      // Can't honor an email choice with no password → fall through to shape.
      expect(LoginFlowResolver.compute(preferred: _email), _phone);
      // ...unless a passcode exists, still phone.
      expect(
        LoginFlowResolver.compute(preferred: _email, hasPasscode: true),
        _phone,
      );
    });

    test('explicit phone_passcode + has passcode → phone_passcode', () {
      expect(
        LoginFlowResolver.compute(preferred: _phone, hasPasscode: true),
        _phone,
      );
    });

    test('explicit phone_passcode, NO passcode, has password → email_password',
        () {
      // Can't honor a passcode choice with no passcode → fall to shape.
      expect(
        LoginFlowResolver.compute(preferred: _phone, hasPassword: true),
        _email,
      );
    });

    test('explicit phone_passcode, nothing set → phone_passcode', () {
      expect(LoginFlowResolver.compute(preferred: _phone), _phone);
    });

    test('BOTH credentials + explicit email → email_password', () {
      expect(
        LoginFlowResolver.compute(
            preferred: _email, hasPasscode: true, hasPassword: true),
        _email,
      );
    });

    test('BOTH credentials + explicit phone → phone_passcode', () {
      expect(
        LoginFlowResolver.compute(
            preferred: _phone, hasPasscode: true, hasPassword: true),
        _phone,
      );
    });

    test('garbage / empty / whitespace preferred is ignored (shape wins)', () {
      expect(LoginFlowResolver.compute(preferred: 'nonsense'), _phone);
      expect(LoginFlowResolver.compute(preferred: ''), _phone);
      expect(LoginFlowResolver.compute(preferred: '   '), _phone);
      expect(
        LoginFlowResolver.compute(preferred: 'garbage', hasPassword: true),
        _email,
      );
    });

    test('preferred is case/whitespace-insensitive', () {
      expect(
        LoginFlowResolver.compute(
            preferred: '  EMAIL_PASSWORD ', hasPassword: true),
        _email,
      );
      expect(
        LoginFlowResolver.compute(
            preferred: 'Phone_Passcode', hasPasscode: true),
        _phone,
      );
    });
  });

  // ── FeatureFlags cached API ────────────────────────────────────────────
  group('FeatureFlags.loginFlow — cached, offline-safe, default phone', () {
    test('authenticationMode defaults to phone_passcode', () {
      expect(FeatureFlags.authenticationMode, _phone);
      expect(FeatureFlags.isPhonePasscodeMode, isTrue);
    });

    test('loginFlow defaults to phone_passcode when never set', () {
      expect(FeatureFlags.hasLoginFlow, isFalse);
      expect(FeatureFlags.loginFlow, _phone);
      expect(FeatureFlags.isEmailPasswordLogin, isFalse);
    });

    test('setLoginFlow persists + is read back; normalizes garbage → phone',
        () async {
      await FeatureFlags.setLoginFlow(_email);
      expect(FeatureFlags.hasLoginFlow, isTrue);
      expect(FeatureFlags.loginFlow, _email);
      expect(FeatureFlags.isEmailPasswordLogin, isTrue);

      await FeatureFlags.setLoginFlow('garbage');
      expect(FeatureFlags.loginFlow, _phone);

      await FeatureFlags.setLoginFlow(_phone);
      expect(FeatureFlags.loginFlow, _phone);
      expect(FeatureFlags.isEmailPasswordLogin, isFalse);
    });

    test('explicit effective flow overrides the platform auth_mode', () async {
      await FeatureFlags.setAuthenticationMode(_email); // platform says email
      await FeatureFlags.setLoginFlow(_phone); // user resolved to phone
      expect(FeatureFlags.loginFlow, _phone);
    });

    test('with no effective flow, falls back to platform auth_mode', () async {
      await FeatureFlags.setAuthenticationMode(_email);
      expect(FeatureFlags.hasLoginFlow, isFalse);
      expect(FeatureFlags.loginFlow, _email);
    });
  });

  // ── record() from a fresh profile ──────────────────────────────────────
  group('LoginFlowResolver.record — caches from account shape', () {
    test('passcode account → phone_passcode', () async {
      await LoginFlowResolver.record(hasPasscode: true, hasPassword: false);
      expect(FeatureFlags.loginFlow, _phone);
    });

    test('password account → email_password', () async {
      await LoginFlowResolver.record(hasPasscode: false, hasPassword: true);
      expect(FeatureFlags.loginFlow, _email);
    });

    test('explicit email + password → email_password', () async {
      await LoginFlowResolver.record(
          preferred: _email, hasPasscode: false, hasPassword: true);
      expect(FeatureFlags.loginFlow, _email);
    });

    test('empty preferred does not force email on a passcode account',
        () async {
      await LoginFlowResolver.record(
          preferred: '', hasPasscode: true, hasPassword: false);
      expect(FeatureFlags.loginFlow, _phone);
    });
  });

  // ── Offline boot seed ──────────────────────────────────────────────────
  group('LoginFlowResolver.seedFromLegacyIfUnset — offline migration', () {
    test('no legacy signals → phone_passcode + persisted', () async {
      final flow = await LoginFlowResolver.seedFromLegacyIfUnset();
      expect(flow, _phone);
      expect(FeatureFlags.hasLoginFlow, isTrue);
      expect(FeatureFlags.loginFlow, _phone);
    });

    test('legacy has_password=true → email_password', () async {
      secure['has_password'] = 'true';
      final flow = await LoginFlowResolver.seedFromLegacyIfUnset();
      expect(flow, _email);
    });

    test('legacy has_passcode=true → phone_passcode', () async {
      secure['has_passcode'] = 'true';
      secure['has_password'] = 'false';
      final flow = await LoginFlowResolver.seedFromLegacyIfUnset();
      expect(flow, _phone);
    });

    test("legacy login_method=='phone_passcode' → phone_passcode", () async {
      secure['login_method'] = 'phone_passcode';
      final flow = await LoginFlowResolver.seedFromLegacyIfUnset();
      expect(flow, _phone);
    });

    test('explicit preferred=email + password → email_password', () async {
      secure['preferred_login_method'] = _email;
      secure['has_password'] = 'true';
      final flow = await LoginFlowResolver.seedFromLegacyIfUnset();
      expect(flow, _email);
    });

    test('idempotent: does NOT reseed once resolved', () async {
      await FeatureFlags.setLoginFlow(_email); // already resolved
      secure['has_passcode'] = 'true'; // conflicting legacy signal
      final flow = await LoginFlowResolver.seedFromLegacyIfUnset();
      expect(flow, _email); // unchanged — cached value wins
      expect(FeatureFlags.loginFlow, _email);
    });
  });

  // ── Explicit Settings switch ───────────────────────────────────────────
  group('LoginFlowResolver.setExplicit — Settings switch', () {
    test('switch to email_password persists cache + secure mirror', () async {
      await LoginFlowResolver.setExplicit(_email);
      expect(FeatureFlags.loginFlow, _email);
      expect(FeatureFlags.isEmailPasswordLogin, isTrue);
      expect(secure['preferred_login_method'], _email);
    });

    test('switch to phone_passcode persists cache + secure mirror', () async {
      await LoginFlowResolver.setExplicit(_email); // start on email
      await LoginFlowResolver.setExplicit(_phone); // switch back
      expect(FeatureFlags.loginFlow, _phone);
      expect(secure['preferred_login_method'], _phone);
    });

    test('garbage explicit value normalizes to phone_passcode', () async {
      await LoginFlowResolver.setExplicit('???');
      expect(FeatureFlags.loginFlow, _phone);
      expect(secure['preferred_login_method'], _phone);
    });
  });
}
